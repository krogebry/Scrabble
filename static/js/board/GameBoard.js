/**
 * Main board object
 */

var tileWidth	= 50;
var tileHeight	= 50;

var boardWidth	= 750;
var boardHeight = 750;

var maxNumVerticalTiles = 15;
var maxNumHorizontalTiles = 15;

var GameBoard = function( cfg ){

	this.elCanvasContainer  = Ext.get( "content" );
	var elCanvas = this.elCanvasContainer.createChild({
		tag: "canvas",
		width: boardWidth,
		height: boardHeight
	});
	this.canvas = elCanvas.dom.getContext( "2d" );

}

GameBoard.prototype.start = function(){
	//console.log( "Starting" );

	this.drawBoard();

	this.drawSpecials();
}

GameBoard.prototype.drawBoard = function(){
	// Vertical bars
	for( var i = 1; i < maxNumVerticalTiles; i++ ){
		this.canvas.beginPath();
		this.canvas.moveTo( (tileWidth*i),0);
		this.canvas.lineTo( (tileWidth*i),boardHeight);
		this.canvas.stroke();
		this.canvas.closePath();
	}

	// Horizontal bars
	for( var i = 1; i < maxNumHorizontalTiles; i++ ){
		this.canvas.beginPath();
		this.canvas.moveTo( 0,(tileHeight*i));
		this.canvas.lineTo( boardWidth,(tileWidth*i) );
		//this.canvas.moveTo( this.graphArea.x-50, this.graphArea.y+(this.cellHeight*i) );
		//this.canvas.lineTo( this.graphArea.x-50+this.graphArea.w, this.graphArea.y+(this.cellHeight*i) );
		this.canvas.stroke();
		this.canvas.closePath();
	}
}

GameBoard.prototype.drawSpecials = function(){

	var center = new Tile({ 
		x: 8, 
		y: 8,
		fill: "rgba( 0,0,200,1 )"
	});
	//console.log( center );
	this.drawTile( center );

	var topLeft = new Tile({
		x: 1,
		y: 1,
		fill: "rgba( 200,0,0,1 )"
	});
	this.drawTile( topLeft );

	var bottomRight = new Tile({
		x: 15,
		y: 15,
		fill: "rgba( 0,200,0,1 )"
	});
	this.drawTile( bottomRight );

}

GameBoard.prototype.drawTile = function( tile ){

	//console.log( tile.fill );

	this.canvas.fillStyle = tile.fill;

	this.canvas.fillRect(
		(tileWidth * (tile.x-1)),
		(tileHeight * (tile.y-1)),
		tileWidth, // width
		tileHeight // height
	)

	/**
	this.canvas.fillRect(
		(boardWidth/2)-(tileWidth/2),
		(boardHeight/2)-(tileHeight/2),
		tileWidth, // width
		tileHeight // height
	)
	*/

}

var Tile = function( cfg ){
	this.x = cfg.x;
	this.y = cfg.y;

	this.fill = cfg.fill;

	this.char_val = "";

}

