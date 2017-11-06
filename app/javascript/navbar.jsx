import React from 'react'

export default class Navbar extends React.Component {
  constructor(props, _railsContext){
    super(props)
  }

  render(){
    return(
      <nav className='navbar'>
        <ul className='list-right'>
          <li className='homepage-link'>
          <a href='/'>back to home</a>
          </li>
          <li className='logout'>
          <a data-confirm="Are you sure you want to logout?" data-method="delete" href="/logout" rel="nofollow">logout</a>
          </li>
        </ul>
      </nav>
    )
  }
}
