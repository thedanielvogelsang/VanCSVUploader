import React from 'react'
import PropTypes from 'prop-types'
import _ from 'lodash';

// var style = {
//   background: 'red'
// };

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
    this.storeCSVFile = this.storeCSVFile.bind(this);
    this.uploadCSVFile = this.uploadCSVFile.bind(this);
    this.dragAndDrop = this.dragAndDrop.bind(this);
    this.onDragOver = this.onDragOver.bind(this);
    this.onDragLeave = this.onDragLeave.bind(this);
    this.setOriginalText = this.setOriginalText.bind(this);

	}

	dragAndDrop(e) {
    e.preventDefault();
    if (!this.uploadFile) {
    	return;
    }
    let data = new FormData();
		data.append('recfile', this.uploadFile);
		data.append('user', 'guestUser');

		fetch('/api/uploads/upload/', {
		  method: 'post',
		  body: data
			}).then((res) => {
					this.setState({
	        	status: 'uploading',
            statusMsg: (<p>Uploading...</p>)
	      	});
					return res.json();
			}).then((val) =>{
					if(val.message == 'ok'){
						this.setState({
	        		status: 'done',
              statusMsg: (<p id='checkMark'><i className="fa fa-check"></i></p>)
	      		});
            this.props.updateImages();
            timer = _.delay( this.setOriginalText, 1000);
					};
		});
    this.uploadFile = '';
		this.setState({
        imagePreviewUrl: ''
    });
  }

  setOriginalText(){
    this.setState({status: 'idle', statusMsg: (<p>Click or drop files here to upload...</p>)});
  }

  storeCSVFile(e) {
    e.preventDefault();
    let file = e.target.files[0];
    this.setState({
      body: file
    })
  }

  uploadCSVFile(e) {
    e.preventDefault();
    fetch('/vanCSV_uploader', {
      method: 'post',
      body: file
    }).then( () => {
      console.log('posted the file to controller')
      this.setState({
        message: "CSV uploaded. Click 'Submit' to launch vanCSV_Uploader"
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
    let imagePreview = this.state.statusMsg;
    let message = this.state.message;
    if (imagePreviewUrl) {
      imagePreview = (<img src={imagePreviewUrl} className='dropPreview'/>);
      // message = (<p className='upload_success'>message</p>)
    }
		return (
          <div
            onDragOver={this.onDragOver}
            onDragLeave={this.onDragLeave}
            className='dropZoneContainer'
          >
						<div className='dropZone' id="upload-file-container" style={this.state.style}>{imagePreview}
							<input type='file' name='file-upload' onChange={this.storeCSVFile} />
						</div>
            <div className='upload_message'>
            {message}
            </div>
        		<a href="" onClick={this.dragAndDrop} className="icon-button cloudicon">
              <span><i className="fa fa-cloud-upload"></i></span>
            </a>
          </div>
      );
	}
}

DropZonePlace.propTypes = {

  onDragOver: PropTypes.func,
  onDragLeave: PropTypes.func,
};


export default DropZonePlace;
