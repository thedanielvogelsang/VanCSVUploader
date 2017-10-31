import React from 'react';

export default class HomeMessage extends React.Component {
  constructor(props, _railsContext) {
    super(props);
    this.state = {
      display: ''
    };
    this.checkStatus = this.checkStatus.bind(this);
  }

  render() {
    this.checkStatus
    return (
      <h1 style={{background: this.state.display}}>{this.props.text}</h1>
    );
  }
}
