import React from 'react';

export default class CsvImporter extends React.Component {
  constructor(props, _raislContext) {
    super(props)
  }

  render(){
    return(
      <div>
        <form enctype="multipart/form-data" action="/vanCSV_uploader" accept-charset="UTF-8" method="post"><input name="utf8" type="hidden" value="✓"><input type="hidden" name="authenticity_token" value="KqhhqJabyNx+02wdqFkgCUHW5M9UfgJd36UhUPDJWzBvUkgxbcgyqMbAZXzk0rSK78I5I8ddTSlokGjTpO0RgA==">
          <input type="file" name="file" id="file">
          <input type="submit" name="commit" value="Upload CSV to VAN" class="btn btn-warning start-rec" data-disable-with="Upload CSV to VAN"> <!-- add :accept['csv']? -->
        </form>
      </div>
    )
  }
}
