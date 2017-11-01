import React from 'react';
import Button from 'button';

export default class HomeMessage extends React.Component {
  constructor(props, _railsContext) {
    super(props);

  }

  render() {
    return (
      <div className='homepage-body'>
       <div className='homepage-container-1'>
        <h1>{this.props.text}</h1>
        <Button text='Sign Up' path='sign-up'/>
        <Button text='Sign In' path='login'/>
       </div>
      </div>
    );
  }
}
