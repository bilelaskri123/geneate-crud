#!/bin/bash

npm install express mysql2 sequelize --save

case $1 in
	"make")
		mkdir routes
		mkdir controllers
		touch controllers/$2.js

		# echo script
		echo "
		const express = require('express');
		const router = express.Router();
		const Controllers = require('../Controllers/$2');

		router.post('/$2', Controllers.Add);
		router.get('/$2', Controllers.GetAll);
		router.get('/$2/:id', Controllers.GetOne);
		router.put('/$2/:id', Controllers.UpdateOne);
		router.delete('/$2/:id', Controllers.DeleteOne);

		module.exports = Router;"> routes/router$2.js

		# echo script
		echo "
		const $2 = require('../models/$2');

		/* Add $2 */
		const Add = async (req, res) => {
			try{
				await $2.create(req.body);
				res.status(201).json({success: true});
			}catch(error) {
				res.status(500).json({error: error.message});
			}
		}

		/* GelAll */
		const GetAll = async (req, res) => {
			try {
				 const data = await $2.findAll();
				 res.status(200).json(data);
			 }catch(error) {
		 	       	res.status(500).json({error: error.message});
		 	 }
		}

		/* GetOne $2 */

		const GetOne = async(req, res) => {
			try {
				const data = await $2.findOne({where: {id: req.params.id}});
				res.status(200).json(data);
			} catch(error) {
				res.status(500).json({error: error.message});
			}
		}

		/* UpdateOne $2  */

		const UpdateOne = async(req, res) => {
			try {
				await $2.update(req.body, {where: {id: req.params.id}});
				res.status(200).json({success: true});
			}catch(error){
				res.status(500).json({error: error.message});
			}
		}	

		/* DeleteOne $2  */

		const DeleteOne = async(req, res)=> {
			try{
				await $2.destroy({where: {id: req.params.id}});
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
		">controllers/$2.js
		;;
"models")
	mkdir models
	touch models/$2.js


	echo "
	const { DataTypes, Model } = require('sequelize');
	const sequelize = require('../helpers/connect-to-database').sequelize;
	
	class $2 extends Model {}

	$2.init({
		
	}, {
		sequelize,
		tableName: '$2s',
		paranoid: true,
		timestamps: true
	});

	module.exports = $2;
	"> models/$2.js
	;;
esac
