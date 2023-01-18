#!/bin/bash

npm install express mysql2 sequelize --save

if [ ! -d models ] 
then
	echo "create models directory."
	mkdir models
else
	echo "models directory already exists."
fi

if [ ! -f models/$1.js  ]
then
	echo "create $1.js model"
	touch models/$1.js
else
	echo "$1.js model already exists."
fi

echo "
	const { DataTypes, Model } = require('sequelize');
	const sequelize = require('../helpers/connect-to-database').sequelize;
	
	class $1 extends Model {}

	$1.init({
		
	}, {
		sequelize,
		tableName: '$1s',
		paranoid: true,
		timestamps: true
	});

	module.exports = $1;
	" >models/$1.js

if [ ! -d routes  ]
then
	echo "create routes directory."
	mkdir routes
else
	echo "routes already exists."
fi

if [ ! -d controllers ]
then
	echo "create controllers directory."
	mkdir controllers
else
	echo "controllers already exists."
fi

touch controllers/$1.controller.js

# echo routes template
echo "create routes template."
echo "
		const express = require('express');
		const router = express.Router();
		const Controllers = require('../controllers/$1');

		router.post('/$1', Controllers.Add);
		router.get('/$1', Controllers.GetAll);
		router.get('/$1/:id', Controllers.GetOne);
		router.put('/$1/:id', Controllers.UpdateOne);
		router.delete('/$1/:id', Controllers.DeleteOne);

		module.exports = Router;" >routes/$1.routes.js

# echo controllers template
ech "create controllers template."
echo "
		const $1 = require('../models/$1');

		/* Add $1 */
		const Add = async (req, res) => {
			try{
				await $1.create(req.body);
				res.status(201).json({success: true});
			}catch(error) {
				res.status(500).json({error: error.message});
			}
		}

		/* GelAll */
		const GetAll = async (req, res) => {
			try {
				 const data = await $1.findAll();
				 res.status(200).json(data);
			 }catch(error) {
		 	       	res.status(500).json({error: error.message});
		 	 }
		}

		/* GetOne $1 */
		const GetOne = async(req, res) => {
			try {
				const data = await $1.findOne({where: {id: req.params.id}});
				res.status(200).json(data);
			} catch(error) {
				res.status(500).json({error: error.message});
			}
		}

		/* UpdateOne $1  */
		const UpdateOne = async(req, res) => {
			try {
				await $1.update(req.body, {where: {id: req.params.id}});
				res.status(200).json({success: true});
			}catch(error){
				res.status(500).json({error: error.message});
			}
		}	

		/* DeleteOne $1  */
		const DeleteOne = async(req, res)=> {
			try{
				await $1.destroy({where: {id: req.params.id}});
				res.status(200).json({success: true});
			}catch(error) {
				res.status(500).json({error: error.message});
			}
		}	

		module.exports = {
			Add,
			GetAll,
			GetOne,
			UpdateOne,
			DeleteOne
		};
		" >controllers/$1.controller.js


