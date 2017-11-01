import React from 'react'
import Navbar from 'navbar'
import DropZonePlace from 'dropzone'

export default class UploadPage extends React.Component {
  constructor(props, _railsContext){
    super(props)
  }
  render(){
    return(
      <div className='upload-body'>
      <div class='csv-headerbar'>
      </div>
        <div className='upload-nav-div'>
          <Navbar />
        </div>
        <div className='upload-dropzone-div'>
          <DropZonePlace />
        </div>
      </div>
    )
  }
}
