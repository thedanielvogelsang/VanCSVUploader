import React from 'react'
import Navbar from 'navbar.jsx'
import DropZonePlace from 'dropzone.jsx'

export default class UploadPage extends React.Component {
  constructor(props, _railsContext){
    super(props)
  }
  render(){
    return(
      <div className='upload-body'>
      <div className='csv-headerbar'>
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
