<?php

// This is the configuration for yiic console application.
// Any writable CConsoleApplication properties can be configured here.
return array(
	'basePath'=>dirname(__FILE__).DIRECTORY_SEPARATOR.'..',
	'name'=>'Daily Report System',
	'timeZone'=>'Asia/Hong_Kong',
	'sourceLanguage'=> 'hk',
	'language'=>'en',

	// preloading 'log' component
	'preload'=>array('log'),

	// autoloading model and component classes
	'import'=>array(
		'application.models.*',
		'application.components.*',
		'ext.YiiMailer.YiiMailer',
	),

	// application components
	'components'=>array(
		'db'=>array(
			'connectionString' => 'mysql:host=localhost;dbname=account;timeout=300',
			'emulatePrepare' => true,
			'username' => 'XXXXXXX',
			'password' => 'XXXXXX',
			'charset' => 'utf8',
		),
		'log'=>array(
			'class'=>'CLogRouter',
			'routes'=>array(
				array(
					'class'=>'CFileLogRoute',
					'levels'=>'error, warning',
				),
			),
		),
	),

	// application-level parameters that can be accessed
	// using Yii::app()->params['paramName']
	'params'=>array(
		'systemEmail'=>'XXXXXXX',
		'webroot'=>'https://XXXXXXX',
		'envSuffix'=>'',
	),
);
