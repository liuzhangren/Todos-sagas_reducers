import { ddbs as dd } from 'ddeyes'
import React, { Component } from 'react'
import { List } from 'StoryView'
import { prefixDom } from 'cfx.dom'
import { connect } from 'cfx.react-redux'
import { store } from 'ReduxServ'
{ 
  actions 
  reducers
} = store
import { getState } from './components'

CFX = prefixDom {
  List
  'div'
}

class StoryTodos extends Component
  constructor: (props) ->
    super props
    @state = 
      todos: props.state.todos
      filter: props.state.filter
    @
  
  componentWillMount: ->
    @props.actions.fetchAll()
    @

  componentWillReceiveProps: (nextProps) ->
    {
      todos
      filter
    } = nextProps.state
    @setState {
      todos
      filter
    }
    @
  
  render: ->
    
    {
      c_div
      c_List
    } = CFX
    # 将 isCompleted 分为 false true 两组塞给data
    Packet = (bool, data) ->
      data.reduce (r, c) =>
        [
          r...
          (
            if c.isCompleted is bool
            then [ c ]
            else []
          )...
        ]
      , []

    c_div {}
    ,
      c_List
        data:
          switch @state.filter
            when 'active' then Packet false, @state.todos
            when 'completed' then Packet true, @state.todos
            when 'all' then @state.todos
        #点击list样式更改
        styleChange: (
          (objectId, isCompleted) ->
            if isCompleted is true
              textDecorationLine: 'line-through'
              opacity: 0.4
        ).bind @
        #删除
        Delete: (
          (key) ->
            @props.actions.delete
              objectId: key
        ).bind @
        #更改 isCompleted
        hasClick: (
          (key, todo, isCompleted) ->
            console.log key, todo, isCompleted
            @props.actions.update
              objectId: key
              todo: todo
              isCompleted: !isCompleted
        ).bind @
        #更改输入的todo值
        Patch: (
          (key, value, isCompleted) ->
            console.log '2', isCompleted
            @props.actions.update
              objectId: key
              todo: value
              isCompleted: isCompleted
        ).bind @

mapStateToProps = (state) ->
  getState state.todosRedux

mapActionToProps =
  # patch: actions.todoPatch
  # remove: actions.todoRemove

  delete: actions.todoDelete
  update: actions.todoUpdate
  fetchAll: actions.todoFetchAll
  
export default connect(
  mapStateToProps
  mapActionToProps
  StoryTodos
)