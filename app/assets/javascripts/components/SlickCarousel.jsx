var SlickCarousel = React.createClass({
  componentDidMount: function() {
    var settings = $.extend({
      dots: true,
      infinite: true,
      speed: 2000,
      slidesToShow: 1,
      centerMode: true,
      slidesToScroll: 1,
      autoplay: true,
      autoplaySpeed: 2000,
      fade: false,
      cssEase: 'ease',
      pauseOnHover: false,
      variableWidth: true,
    }, this.props.slick_settings );
    $(this.refs.root.getDOMNode()).slick( settings );
  },
  componentWillUnmount: function() {
    $(this.refs.root).off('hidden', this.handleHidden);
  },
  render: function() {
    var version = this.props.version ? "_" + this.props.version : "";
    var items = [];
    this.props.pictures.forEach( function(picture) {
      items.push(<SlickImgItem key={picture} picture={picture} version={version}/>);
    });
    return(
      <div className="ui fluid bottom attached segment slick" data-slick="57,58,60,61" style={{height: 60 + 'vh'}} ref="root">
        {items}
      </div>
    )
  }
})
var SlickImgItem = React.createClass({
  render: function() {
    return (
      <div className='slick-item'>
        <img className='ui image' src={'/pictures/' + this.props.picture + this.props.version + '.jpg'}/>
      </div>
    )
  }
})
