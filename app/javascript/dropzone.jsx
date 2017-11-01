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
    this.onDragOver = this.onDragOver.bind(this);
    this.onDragLeave = this.onDragLeave.bind(this);
    this.onDrop = this.onDrop.bind(this);
    this.timeOut = this.timeOut.bind(this);
		this.restartReact = this.restartReact.bind(this);
	}

	restartReact(){
		ReactDOM.findDOMNode(this.refs.fileSelector).value = ''
		ReactDOM.findDOMNode(this.refs.submitBtn).style = 'display:none'
		ReactDOM.findDOMNode(this.refs.fileSelector).style = 'display:block'
		ReactDOM.findDOMNode(this.refs.restartBtn).style = 'display:none'
		ReactDOM.findDOMNode(this.refs.reloadBtn).style = 'display:none'
		ReactDOM.findDOMNode(this.refs.success).style = 'font-size:1em'
		this.setState({
			status: 'idle',
			message: '',
			statusMsg: (<p>Click or drop files here to upload...</p>),
			style: {marginTop: '30px', borderRadius: '15px' },
			body: []
		})
	}

  onDrop(acceptedFiles, rejectedFiles) {
    this.setState({
      body: acceptedFiles[0],
      statusMsg: "",
    })
    if(!acceptedFiles[0]){
      // ReactDOM.findDOMNode(this.refs.submitBtn).style = 'placeholder:Submit Another'
      this.setState({
        style: {background: 'rgb(243,247,243)',
								marginTop: '30px'},
        message: "File must be a CSV, try again with the correct file format"
      })
    }else {
      this.setState({
        style: {background: '#F7ACCF',
                marginTop: '30px'},
        message: "CSV uploaded! Click 'Submit' to launch vanCSV_Uploader"
      })
			ReactDOM.findDOMNode(this.refs.fileSelector).style = 'display:none'
			ReactDOM.findDOMNode(this.refs.submitBtn).style = 'display:block'
			ReactDOM.findDOMNode(this.refs.reloadBtn).style = 'display:block'
    }
  }

  uploadCSVFile(e) {
    e.preventDefault();
    let file = e.target.files[0];
    this.setState({
      style: {background: 'rgb(243,247,243)',
							padding: '12px'},
      body: file,
      message: "CSV uploaded! Click 'Submit' to launch vanCSV_Uploader.",
      statusMsg: ""
    })
    ReactDOM.findDOMNode(this.refs.fileSelector).style = 'display:none'
    ReactDOM.findDOMNode(this.refs.submitBtn).style = 'display:block'
    ReactDOM.findDOMNode(this.refs.reloadBtn).style = 'display:block'
  }

  postCSVFile(e) {
    e.preventDefault();
    if(this.state.body){
      fetch('/vanCSV_uploader', {
        method: 'post',
        body: this.state.body
      }).then( () => {
				ReactDOM.findDOMNode(this.refs.submitBtn).style = 'display:none'
				ReactDOM.findDOMNode(this.refs.restartBtn).style = 'display:block'
				ReactDOM.findDOMNode(this.refs.reloadBtn).style = 'display:none'
				ReactDOM.findDOMNode(this.refs.success).style = 'font-size:1.5em'
        this.setState({
					style: {marginTop: '30px'},
          message: 'Successful Post!',
					body: []
        })
      })
    }else{
      this.setState({
        message: 'Error. No CSV attached.'
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
      <div className='dropzone-div'>
          <Dropzone
						id="dropzone"
            accept=".csv"
            disableClick
						acceptClassName='csv-active'
            onDrop={this.onDrop}
            disabled={this.state.disabled}
            onDragOver={this.onDragOver}
            onDragLeave={this.onDragLeave}
            >
              <div style={this.state.style}>{uploaderStatus}
  							<input ref='fileSelector' type='file' name='file-upload' accept='.csv' onChange={this.uploadCSVFile} />
                <div className='upload_message'>
                  <p ref='success'>{message}</p>
                </div>
                <input className='submitBtn' type='submit' value='submit' onClick={this.postCSVFile} ref='submitBtn' style={{display: 'none'}}/>
                <input className='restartBtn' value='upload another' type='submit' onClick={this.restartReact} ref='restartBtn' style={{display: 'none'}}/>
                <input className='reloadBtn' value='load a different file' type='submit' onClick={this.restartReact} ref='reloadBtn' style={{display: 'none'}}/>
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
