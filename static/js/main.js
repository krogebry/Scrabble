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
		camera.position.x = 200;
		camera.position.y = 100;
		camera.position.z = 200;

		scene = new THREE.Scene();

		scene.add( camera );

		var geometry = new THREE.Geometry();
		geometry.vertices.push( new THREE.Vertex( new THREE.Vector3( -500, 0, 0 ) ) );
		geometry.vertices.push( new THREE.Vertex( new THREE.Vector3( 500, 0, 0 ) ) );

		for ( var i = 0; i <= 20; i ++ ) {
			var line = new THREE.Line( geometry, new THREE.LineBasicMaterial( { color: 0x000000, opacity: 0.5 } ) );
			line.position.z = ( i * 50 ) - 500;
			scene.add( line );

			var line = new THREE.Line( geometry, new THREE.LineBasicMaterial( { color: 0x000000, opacity: 0.5 } ) );
			line.position.x = ( i * 50 ) - 500;
			line.rotation.y = 90 * Math.PI / 180;
			scene.add( line );
		}

		// Cubes
		var geometry = new THREE.CubeGeometry( 50, 50, 50 );
		var material = new THREE.MeshLambertMaterial( { color: 0xff00ff, shading: THREE.FlatShading, overdraw: true } );

		for ( var i = 0; i < 100; i ++ ) {
			var cube = new THREE.Mesh( geometry, material );
			cube.overdraw = true;

			cube.scale.y = Math.floor( Math.random() * 2 + 1 );

			cube.position.x = Math.floor( ( Math.random() * 1000 - 500 ) / 50 ) * 50 + 25;
			cube.position.y = ( cube.scale.y * 50 ) / 2;
			cube.position.z = Math.floor( ( Math.random() * 1000 - 500 ) / 50 ) * 50 + 25;

			cubes.push( cube );
			scene.add( cube );
		}

		// Lights
		var ambientLight = new THREE.AmbientLight( Math.random() * 0x10 );
		//var ambientLight = new THREE.AmbientLight( 0xffffff );
		scene.add( ambientLight );

		//console.log( Math.random() * 0xffffff );

		var directionalLight = new THREE.DirectionalLight( Math.random() * 0xffffff );
		directionalLight.position.x = Math.random() - 0.5;
		directionalLight.position.y = Math.random() - 0.5;
		directionalLight.position.z = Math.random() - 0.5;
		console.log( directionalLight.position );
		directionalLight.position.normalize();
		scene.add( directionalLight );

		/**
		var directionalLight = new THREE.DirectionalLight( Math.random() * 0xffffff );
		directionalLight.position.x = Math.random() - 0.5;
		directionalLight.position.y = Math.random() - 0.5;
		directionalLight.position.z = Math.random() - 0.5;
		directionalLight.position.normalize();
		scene.add( directionalLight );
		*/

		renderer = new THREE.CanvasRenderer();
		renderer.setSize( window.innerWidth, window.innerHeight );

		container.appendChild( renderer.domElement );

		stats = new Stats();
		stats.domElement.style.position = 'absolute';
		stats.domElement.style.top = '0px';
		container.appendChild( stats.domElement );
	}

	animate();

	function animate() {
		requestAnimationFrame( animate );
		render();
		stats.update();
	}

	function render() {
		var timer = new Date().getTime() * 0.0001;
		//camera.position.x = Math.cos( timer ) * 200;
		//camera.position.z = Math.sin( timer ) * 200;
		camera.lookAt( scene.position );
		cubes.forEach(function( item,idx ){
			//console.log( "Old: "+item.scale.y );
			//cubes[idx].scale.y = Math.floor( Math.random() * 2 + 1 );
			//console.log( "New: "+item.scale.y );
		})
		renderer.render( scene, camera );
	}
});
