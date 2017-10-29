import React from 'react';

export default class HomeMessage extends React.Component {
  constructor(props, _railsContext) {
    super(props);
  }

  render() {
    return (
      <h1>{this.props.text}!</h1>
    );
  }
}
