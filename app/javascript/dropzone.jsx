import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'
import _ from 'lodash'
import Dropzone from 'react-dropzone'
import ReactInterval from 'react-interval'

class DropZonePlace extends React.Component{

	constructor(props){
		super(props);
		this.state = {
      status: 'idle',
      message: '',
      statusMsg: (<p>Click or drop files here to upload...</p>),
      style: {marginTop: '30px'},
      body: {}
    };
    this.uploadCSVFile = this.uploadCSVFile.bind(this);
    this.postCSVFile = this.postCSVFile.bind(this);
    this.dragAndDrop = this.dragAndDrop.bind(this);
    this.onDragOver = this.onDragOver.bind(this);
    this.onDragLeave = this.onDragLeave.bind(this);
    this.onDrop = this.onDrop.bind(this);
    this.timeOut = this.timeOut.bind(this);
	}

	dragAndDrop(e) {
    e.preventDefault();
    let file = e.currentTarget;
    console.log(e)
    this.setState({
      body: file,
      message: "CSV uploaded. Click 'Submit' to launch vanCSV_Uploader",
      statusMsg: ""
    })
    console.log(this.state.message)
  }

  onDrop(acceptedFiles, rejectedFiles) {
    this.setState({
      body: acceptedFiles[0],
      statusMsg: "",
    })
    if(!acceptedFiles[0]){
      // ReactDOM.findDOMNode(this.refs.submitBtn).style = 'placeholder:Submit Another'
      this.setState({
        style: {background: '#e51616',
                  marginTop: '30px'},
        message: "File must be a CSV, try again with the correct file format"
      })
    }else {
      ReactDOM.findDOMNode(this.refs.uploadBtn).style = 'display:none'
      ReactDOM.findDOMNode(this.refs.submitBtn2).style = 'visibility:visible'
      this.setState({
        style: {background: '#F7ACCF',
                  marginTop: '30px'},
        message: "CSV uploaded. Click 'Submit' to launch vanCSV_Uploader"
      })
    }
  }

  uploadCSVFile(e) {
    e.preventDefault();
    let file = e.target.files[0];
    this.setState({
      style: {background: '#F7ACCF',
              marginTop: '30px'},
      body: file,
      message: "CSV uploaded. Click 'Submit' to launch vanCSV_Uploader",
      statusMsg: ""
    })
    ReactDOM.findDOMNode(this.refs.uploadBtn).style = 'display:none'
    ReactDOM.findDOMNode(this.refs.submitBtn).value = 'Submit CSV to VAN'
    ReactDOM.findDOMNode(this.refs.submitBtn2).style = 'visibility:visible'
  }

  postCSVFile(e) {
    e.preventDefault();
    if(this.state.body){
      fetch('/vanCSV_uploader', {
        method: 'post',
        body: this.state.body
      }).then( () => {
        this.setState({
          message: 'Successful Post!'
        })
      })
    }else{
      this.setState({
        message: 'Error. No CSV attached'
      })
    }
  }

  onDragOver(e) {
    e.preventDefault();
    e.stopPropagation();
    this.setState({
        style: {background: '#F7ACCF',
                marginTop: '30px'}
    });
  }

  onDragLeave(e) {
    e.preventDefault();
    this.setState({
        style: {background: ''}
    });
  }

  timeOut() {
    this.setTimeout(console.log('hello'), 6000)
  }

	render(){
    let uploaderStatus = this.state.statusMsg;
    let message = this.state.message;
		return (
      <div>
          <Dropzone
            accept=".csv"
            disableClick
            onDrop={this.onDrop}
            disabled={this.state.disabled}
            onDragOver={this.onDragOver}
            onDragLeave={this.onDragLeave}
            >
              <div style={this.state.style}>{uploaderStatus}
  							<input ref='uploadBtn' type='file' name='file-upload' accept='.csv' onChange={this.uploadCSVFile} />
                <div className='upload_message'>
                  <br/><p>{message}</p>
                </div>
                <input type='submit' onClick={this.postCSVFile} ref='submitBtn'/>
                <input type='submit' onClick={this.uploadCSVFile} ref='submitBtn2' value='Add Another CSV' style={{visibility: 'hidden'}}/>
              </div>
          </Dropzone>
      </div>
      );
	}
}
// callback={() => this.setState({backgroundUrl: this.state.images[this.state.count + 1]})} />

DropZonePlace.propTypes = {
  onDragOver: PropTypes.func,
  onDragLeave: PropTypes.func,
};


export default DropZonePlace;
