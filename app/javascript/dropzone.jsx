import React from 'react'
import PropTypes from 'prop-types'
import _ from 'lodash';
import Dropzone from 'react-dropzone'

class DropZonePlace extends React.Component{

	constructor(props){
		super(props);
		this.state = {
      imagePreviewUrl: '',
      status: 'idle',
      message: '',
      statusMsg: (<p>Click or drop files here to upload...</p>),
      style: {},
      body: {}
    };
    this.uploadFile = '';
    this.uploadCSVFile = this.uploadCSVFile.bind(this);
    this.postCSVFile = this.postCSVFile.bind(this);
    this.dragAndDrop = this.dragAndDrop.bind(this);
    this.onDragOver = this.onDragOver.bind(this);
    this.onDragLeave = this.onDragLeave.bind(this);
    this.setOriginalText = this.setOriginalText.bind(this);
    this.onDrop = this.onDrop.bind(this);
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
      message: "CSV uploaded. Click 'Submit' to launch vanCSV_Uploader",
      statusMsg: ""
    })
  }

  setOriginalText(){
    this.setState({status: 'idle', statusMsg: (<p>Click or drop files here to upload...</p>)});
  }

  uploadCSVFile(e) {
    e.preventDefault();
    let file = e.target.files[0];
    this.setState({
      body: file,
      message: "CSV uploaded. Click 'Submit' to launch vanCSV_Uploader",
      statusMsg: ""
    })
  }

  postCSVFile(e) {
    e.preventDefault();
    fetch('/vanCSV_uploader', {
      method: 'post',
      body: this.state.body
    }).then( () => {
      console.log('posted the file to controller')
      this.setState({
      })
    });
  }

  onDragOver(e) {
    e.preventDefault();
    e.stopPropagation();
    this.setState({
        style: {background: '#F7ACCF', border: 'solid 3px black'}
    });
  }

  onDragLeave(e) {
    e.preventDefault();
    this.setState({
        style: {background: '', border: 'dashed'}
    });
  }


	render(){
		let {imagePreviewUrl} = this.state;
    let uploaderStatus = this.state.statusMsg;
    let message = this.state.message;
    if (imagePreviewUrl) {
      uploaderStatus = (<img src={imagePreviewUrl} className='dropPreview'/>);
      // message = (<p className='upload_success'>message</p>)
    }
		return (
      <div>
          <Dropzone
            accept=".csv"
            disableClick
            onDrop={this.onDrop}
            disabled={this.state.disabled}
            >
            <div
              onDragOver={this.onDragOver}
              onDragLeave={this.onDragLeave}
              className='dropZoneContainer'
            >
              <div id="upload-file-container" style={this.state.style}>{uploaderStatus}
  							<input type='file' name='file-upload' accept='.csv' onChange={this.uploadCSVFile} />
                <div className='upload_message'>
                  <br/><p>{message}</p>
                </div>
                <input type='submit' onClick={this.postCSVFile} />
              </div>
            </div>
          </Dropzone>
      </div>
      );
	}
}

DropZonePlace.propTypes = {
  onDragOver: PropTypes.func,
  onDragLeave: PropTypes.func,
};


export default DropZonePlace;
