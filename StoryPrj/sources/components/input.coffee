import { ddbs as dd } from 'ddeyes'
import React, { Component } from 'react'
import { HotKeys } from 'react-hotkeys'
import { Input } from 'StoryView'
import { prefixDom } from 'cfx.dom'
import { connect } from 'cfx.react-redux'
import { store } from 'ReduxServ'
{
  actions
  reducers
  sagas
} = store
import { getState } from './components'

CFX = prefixDom {
  Input
  HotKeys
}
class StoryTodos extends Component

  constructor: (props) ->
    super props
    @state =
      todo: ''
      filter: props.state.filter
    @

  componentWillReceiveProps: (nextProps) ->
    {
      filter
    } = nextProps.state
    @setState {
      filter
    }
    @

  render: ->
    
    {
      c_Input
      c_HotKeys
    } = CFX

    c_HotKeys
      keyMap:
        submit: 'enter'
      handlers:
        submit: ( ->
          # @props.actions.save todo: @state.todo
          @props.actions.create todo: @state.todo
          @refs.RefInput.refs.RefInput.clearInput()
        ).bind @
    ,
      c_Input
        ref: 'RefInput'
        filter: @state.filter
        ##冒泡框筛选状态 active completed all
        selector: (
          (filter) ->
            @props.actions.filterSave
              filter: filter
        ).bind @
        #input框输入值穿到state
        onChange: (
          (v) ->
            @setState todo: v
        ).bind @
        # value: @state.todo

mapStateToProps = (state) ->
  getState state.todosRedux

mapActionToProps =
  filterSave: actions.filterSave
  
  # save: actions.todoSave

  create: actions.todoCreate

export default connect(
  mapStateToProps
  mapActionToProps
  StoryTodos
)