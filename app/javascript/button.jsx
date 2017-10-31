import React from 'react';


export default class Button extends React.Component {
  constructor(props, _railsContext){
    super(props)
    
  }
  render(){
    return (
      <button className={this.props.text}>
        <a href={this.props.path} >{this.props.text.capitalize}</a
      </button>
    )
  }
}
