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
        <h1>{this.props.header}</h1>
        <div className='subheader-div'>
          <h3>{this.props.sub1}</h3>
          <h2>{this.props.logo}</h2>
          <h3>{this.props.sub2}</h3>
        </div>
        <Button text='Sign Up' path='sign-up'/>
        <Button text='Sign In' path='login'/>
       </div>
      </div>
    );
  }
}
