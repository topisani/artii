var User = React.createClass({

  render: ->
      React.DOM.div
        <CoverImage id={this.props.cover_picture_id} />
        <Semantify.Menu className="bottom attached">
          <Semantify.Item>
            <Semantify.Image className="profilepicture" src={'/pictures/' + this.props.avatar_id + '_square_250.jpg'} />
          </Semantify.Item>
          <Semantify.Item>
            <h4>{this.props.username}</h4>
          </Semantify.Item>
        </Semantify.Menu>
        <Semantify.Grid>
          <Semantify.Column className="five wide">
            <Semantify.Segment className="fluid">
              <h1>Artworks</h1>
            </Semantify.Segment>
          </Semantify.Column>
          <Semantify.Column className="eleven wide">
            <Semantify.Segment className="fluid">
              <h1>Posts</h1>
            </Semantify.Segment>
          </Semantify.Column>
        </Semantify.Grid>
      </div>
    );

  }
});
var CoverImage = React.createClass({
  render: function() {
    return (
      <Semantify.Segment className="attached coverimage">
        <FluidImage id={this.props.id} />
      </Semantify.Segment>
    );
  }

});
var FluidImage = React.createClass({
  render: function() {
    return (
      <div className="ui fluid top attached fluid cropped image" style={{backgroundImage: 'url("/pictures/' + this.props.id + '.jpg")'}} ref='image'/>
    );
  }
});
