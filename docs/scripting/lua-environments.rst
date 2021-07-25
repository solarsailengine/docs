Lua Environments
================

A nifty feature of lua is the ability to have more than one environment.  Each environment can have its own set of variables and functions.  Each environment is separate from one another.  There are four kinds of lua environments available in SolarSail. Minimally, every SolarSail program will have an Engine environment.

- Engine
- Scene
- Sprite Atlas Loader
- Default (for lack of a better name)

Engine Environment
------------------

Once any instance of the engine starts, it creates a dedicated lua environment for itself.  All of the contents of the program.lua are executed in this environment.  

From this envrionment, you can interact with the following data types:

- engine
- display
- vector2/3/4
- window
- viewport
- camera
- texture2d
- aabb
- system
- rect
- transform
- scene

In addition, the following global function groups are available:

- engine
- engine.debug
- engine.displays
- engine.resources
- engine.scenes

Scene Environment
-----------------

Every scene has its own lua environment.  Whatever you code you add to a scene environment will stay local to that scene.  It will not be accessible by any other scene. The scene environment is created when a scene is created.  The scene's main lua file is executed in this environent.  All script components are also executed in this environment.

The scene environment contains everything from the Engine environment and the following additional data types:

- spriterenderer
- rigidbody2d
- script
- scripts
- deferred
- deferreds
- animatedsprite
- staticsprite
- particlesystem
- particlesystememitter
- core
- audio

In addition, the following global functions are available:

- createentity
- releaseentity
- addcomponent
- getcomponent
- cloneentity
- broadcastmessage
- sendmessage
- findentitybytag
- findentitybyname
- getentitybyname
- getcurrentscene
- getcurrententity

Sprite Atlas Environment
------------------------

Each time a sprite atlas is loaded, it is done so in a short-lived lua environment that exists only long enough to load the sprite atlas into the engine instance.  During the time it exists, the following the sprite atlas lua environment contains everything from the Engine environment and the following additional data types:

- spriteatlas
- sprite
- spritesequence

In addition, the following global functions are available:

- addsprite
- addsequence
- addframe
- getatlas
- atlas

Default Environment
-------------------

SolarSail was built with lua in mind.  It is possible to use the lua executable to create an instance of the engine.

In this environment only the engine type is available.  The library exposes a single method `create_engine`.

.. code-block:: lua

	local solarsail = require("libengine")
	local e = solarsail.create_engine()
	assert(e:init())
	assert(e:automount())
	assert(e:start())

	for i = 1, 10 do
		assert(e:pump())
	end

	assert(e:shutdown())
	e:deinit()

