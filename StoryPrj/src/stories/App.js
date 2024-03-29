// Generated by CoffeeScript 2.1.1
var CFX, actions, todosStore;

import {
  storiesOf
} from '@storybook/react';

import {
  prefixDom
} from 'cfx.dom';

import 'antd-mobile/dist/antd-mobile.css';

import List from '../components/list';

import Input from '../components/input';

import {
  Provider
} from 'cfx.react-redux';

import {
  store
} from 'ReduxServ';

todosStore = store.store;

({actions} = store);

CFX = prefixDom({'div': 'div', Input, List, Provider});

export default function() {
  return storiesOf('Todos', module).addDecorator(function(story) {
    var c_Provider;
    ({c_Provider} = CFX);
    return c_Provider({
      store: todosStore
    }, story());
  }).add('Input', () => {
    var c_Input;
    ({c_Input} = CFX);
    return c_Input({});
  }).add('List', () => {
    var c_List;
    ({c_List} = CFX);
    return c_List({});
  }).add('App', () => {
    var c_Input, c_List, c_div;
    ({c_div, c_Input, c_List} = CFX);
    return c_div({}, c_Input({}), c_List({}));
  });
};
