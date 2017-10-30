import React from 'react'
import Dropzone from 'react-dropzone'

export default class Accept extends React.Component {
  constructor() {
    super()
    this.state = {
      accepted: [],
      rejected: []
    }
  }

  render() {
    return (
      <section>
        <div className="dropzone">
          <Dropzone
            accept="image/jpeg, image/png"
            onDrop={(accepted, rejected) => { this.setState({ accepted, rejected }); }}
          >
            <p>Try dropping some files here, or click to select files to upload.</p>
            <p>Only *.jpeg and *.png images will be accepted</p>
          </Dropzone>
        </div>
        <aside>
          <h2>Accepted files</h2>
          <ul>
            {
              this.state.accepted.map(f => <li key={f.name}>{f.name} - {f.size} bytes</li>)
            }
          </ul>
          <h2>Rejected files</h2>
          <ul>
            {
              this.state.rejected.map(f => <li key={f.name}>{f.name} - {f.size} bytes</li>)
            }
          </ul>
        </aside>
        <form enctype="multipart/form-data" action="/vanCSV_uploader" accept-charset="UTF-8" method="post"><input name="utf8" type="hidden" value="✓"><input type="hidden" name="authenticity_token" value="cEPXaGPKr1X+dKpbfMx4wGXJVLBjtEhivYnNMJtTer81uf7xmJlVIUZnozowR+xDy92JXPCXBxYKvISzz3cwDw==">
          <input type="file" name="file" id="file">
          <input type="submit" name="commit" value="Upload CSV to VAN" className="btn btn-warning start-rec" data-disable-with="Upload CSV to VAN"> <!-- add :accept['csv']? -->
        </form>
      </section>
    );
  }
}
