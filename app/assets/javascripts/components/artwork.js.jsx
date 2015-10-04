var Artwork = React.createClass({

  propTypes: {

    name: React.PropTypes.string,

    description: React.PropTypes.string,

    finished: React.PropTypes.bool,

    published: React.PropTypes.bool,

    // user: React.PropTypes.instanceOf(User)
    user_id: React.PropTypes.any

  },


  render: function() {

    return (
      <div>
        <SlickCarousel pictures={[57,58,60,61]} style={{height: 60 + 'vh'}} version="p500" />

        <h1>{this.props.name}</h1>
        <Semantify.Segment >{this.props.description}</Semantify.Segment>

      </div>
    );

  }
});
