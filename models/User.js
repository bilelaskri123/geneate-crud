
	const { DataTypes, Model } = require('sequelize');
	const sequelize = require('../helpers/connect-to-database').sequelize;
	
	class User extends Model {}

	User.init({
		
	}, {
		sequelize,
		tableName: 'Users',
		paranoid: true,
		timestamps: true
	});

	module.exports = User;
	
