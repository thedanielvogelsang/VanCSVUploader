import React from 'react';
import ReactDOM from 'react-dom'
import Button from 'button';

export default class HomeMessage extends React.Component {
  constructor(props, _railsContext) {
    super(props);
    this.scrollListener = this.scrollListener.bind(this)
  }

  componentDidMount() {
    window.addEventListener('scroll', this.scrollListener)
  }

  scrollListener() {
    if (window.pageYOffset > 550) {
      ReactDOM.findDOMNode(this.refs.upArrow).style = "display:block";
      ReactDOM.findDOMNode(this.refs.downArrow).style = "display:none";
      ReactDOM.findDOMNode(this.refs.extraSpace).style = "display:block";
    } else if(window.pageYOffset < 550) {
      ReactDOM.findDOMNode(this.refs.downArrow).style = "display:block";
      ReactDOM.findDOMNode(this.refs.upArrow).style = "display:none";
      ReactDOM.findDOMNode(this.refs.extraSpace).style = "display:none";
    }
  }

  render() {
    return (
      <div className='homepage-body' ref='homepageBody'>
      <div className='page-headerbar'>
      </div>
       <div className='homepage-container-1'>
        <div className='header-div'>
          <h1>{this.props.header}</h1>
        </div>
        <div className='subheader-div'>
          <h3 id='downArrow' ref='downArrow' style={{display:'block'}}><span>	&#9660; </span></h3>
          <br/>
          <br ref='extraSpace' style={{display:none}}/>
          <h3>{this.props.sub1}</h3>
          <h2>{this.props.logo}</h2>
          <h3>{this.props.sub2}</h3>
          <h3 id='upArrow' ref='upArrow' style={{display: 'none'}}><span>	&#9650; </span></h3>
        </div>
        <div className='button-div'>
          <Button text='Sign Up' path='sign-up'/>
          <Button text='Sign In' path='login'/>
        </div>
       </div>

      </div>
    );
  }
}
