import React from 'react'
import Navbar from 'navbar'
import DropZonePlace from 'dropzone'

export default class UploadPage extends React.Component {
  constructor(props, _railsContext){
    super(props)
  }
  render(){
    return(
      <div>
        <div>
          <Navbar />
        </div>
        <div>
          <DropZonePlace />
        </div>
      </div>
    )
  }
}
