import React from 'react';


export default class Button extends React.Component {
  constructor(props, _railsContext){
    super(props);
    this.state = {
      style: {background: 'none',
              border: 'none'}
    };
  }
  render(){
    return (
      <button
        className={this.props.path}
        style={this.state.style}
        >
        <a href={'/'+this.props.path} >{this.props.text}</a>
      </button>
    )
  }
}
