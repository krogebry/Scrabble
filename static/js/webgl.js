/**
 * main()
 */
$(document).ready(function()
{
	var container, stats;
	var camera, scene, renderer;

	var cubes = [];

	init();

	function init()
	{
		container = document.createElement( 'div' );
		document.body.appendChild( container );

		camera = new THREE.OrthographicCamera( 
			window.innerWidth / - 2, 
			window.innerWidth / 2,
			window.innerHeight / 2, 
			window.innerHeight / - 2, 
			-2000, 
			1000 
		);
		camera.position.x = 0;
		camera.position.y = 0;
		camera.position.z = 100;

		scene = new THREE.Scene();

		scene.add( camera );

		var pointLight = new THREE.PointLight( 0xFFFFFF, 1.125 );
		pointLight.position.x = 300;
		pointLight.position.y = 300;
		pointLight.position.z = 300;
		scene.add( pointLight );

		// x-axis ( white )
		var geometry = new THREE.Geometry();
		geometry.vertices.push( new THREE.Vertex( new THREE.Vector3( -500, 0, 0 ) ) );
		geometry.vertices.push( new THREE.Vertex( new THREE.Vector3( 500, 0, 0 ) ) );
		var line = new THREE.Line( geometry, new THREE.LineBasicMaterial( { color: 0xffffff } ) );
		scene.add( line );

		// y-axis ( red )
		var geometry = new THREE.Geometry();
		geometry.vertices.push( new THREE.Vertex( new THREE.Vector3( 0, -500, 0 ) ) );
		geometry.vertices.push( new THREE.Vertex( new THREE.Vector3( 0, 500, 0 ) ) );
		var line = new THREE.Line( geometry, new THREE.LineBasicMaterial({ color: 0xff0000 }) );
		scene.add( line );

		// z-axis ( green )
		var geometry = new THREE.Geometry();
		geometry.vertices.push( new THREE.Vertex( new THREE.Vector3( 0, 0, -500 ) ) );
		geometry.vertices.push( new THREE.Vertex( new THREE.Vector3( 0, 0, 500 ) ) );
		var line = new THREE.Line( geometry, new THREE.LineBasicMaterial({ color: 0x00ff00 }) );
		scene.add( line );

		var offset = ((10 * 70)/2)*-1;

		// Cubes
		var geometry = new THREE.CubeGeometry( 50, 50, 50 );
		var material = new THREE.MeshLambertMaterial( { color: 0xefefef, shading: THREE.FlatShading, overdraw: true, opacity: 0.9 } );
		for( var i = 0; i < 10; i++ )
		{
			var cube = new THREE.Mesh( geometry, material );
			cube.overdraw = true;

			cube.position.x = ( i * 70 )+offset;
			cube.position.y = 0;
			cube.position.z = 0;

			scene.add( cube );
		}

		renderer = new THREE.CanvasRenderer();
		renderer.setSize( window.innerWidth, window.innerHeight );

		container.appendChild( renderer.domElement );

		stats = new Stats();
		stats.domElement.style.position = 'absolute';
		stats.domElement.style.top = '0px';
		container.appendChild( stats.domElement );
	}

	animate();

	function animate() 
	{
		requestAnimationFrame( animate );
		render();
		stats.update();
	}

	function render() 
	{
		var timer = new Date().getTime() * 0.0001;
		//camera.position.x = Math.cos( timer ) * 200;
		//camera.position.z = Math.sin( timer ) * 200;
		camera.lookAt( scene.position );
		renderer.render( scene, camera );
	}
});
