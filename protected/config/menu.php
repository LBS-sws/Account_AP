<?php

return array(
	'Payment Request'=>array(
		'access'=>'XA',
		'icon'=>'fa-money',
		'items'=>array(
			'Payment Request'=>array(
				'access'=>'XA04',
				'url'=>'/payreq/index',
			),
			'Request Confirmation'=>array(
				'access'=>'XA08',
				'url'=>'/confreq/index',
			),
			'Request Approval'=>array(
				'access'=>'XA05',
				'url'=>'/apprreq/index',
			),
			'Reimbursement'=>array(
				'access'=>'XA06',
				'url'=>'/realize/index',
			),
			'Reimbursement Approval'=>array(
				'access'=>'XA07',
				'url'=>'/signreq/index',
			),
		),
	),
	'Transaction'=>array(
		'access'=>'XE',
		'icon'=>'fa-exchange',
		'items'=>array(
			'Transaction(In)'=>array(
				'access'=>'XE01',
				'url'=>'/transin/index',
			),
			'Transaction(Out)'=>array(
				'access'=>'XE03',
				'url'=>'/transout/index',
			),
			'Transaction Enquiry'=>array(
				'access'=>'XE02',
				'url'=>'/transenq/index',
			),
			'Cash In Check'=>array(
				'access'=>'XE04',
				'url'=>'/cashinaudit/index',
			),
			'T3 Balance Checking'=>array(
				'access'=>'XE05',
				'url'=>'/t3audit/index',
			),
//			'Balance Adjustment'=>array(
//				'access'=>'XE06',
//				'url'=>'/baladj/index',
//			),
			'Bank Balance'=>array(
				'access'=>'XE07',
				'url'=>'/acctfile/index',
			),
		),
	),
	'Report'=>array(
		'access'=>'XB',
		'icon'=>'fa-file-text-o',
		'items'=>array(
			'Reimbursement Form'=>array(
				'access'=>'XB02',
				'url'=>'/report/reimburse',
			),
			'Transaction List'=>array(
				'access'=>'XB03',
				'url'=>'/report/translist',
			),
			'Operation Daily Report'=>array(
				'access'=>'XB04',
				'url'=>'#',
				'hidden'=>true,
			),
			'Report Manager'=>array(
				'access'=>'XB01',
				'url'=>'/queue/index',
			),
			'Daily Receipt Overview Report'=>array(
				'access'=>'XB05',
				'url'=>'#',
				'hidden'=>true,
			),
			'Daily Request Approval Summary'=>array(
				'access'=>'XB06',
				'url'=>'#',
				'hidden'=>true,
			),
			'Daily Reimbursement Approval Summary'=>array(
				'access'=>'XB07',
				'url'=>'#',
				'hidden'=>true,
			),
		),
	),
	'Import'=>array(
		'access'=>'XF',
		'icon'=>'fa-bolt',
		'items'=>array(
			'Import'=>array(
				'access'=>'XF02',
				'url'=>'/import/index',
			),
			'Import Manager'=>array(
				'access'=>'XF01',
				'url'=>'/iqueue/index',
			),
		),
	),

    'Generate Invoice'=>array(
        'access'=>'XI',
        'icon'=>'fa-bolt',
        'items'=>array(
            'Invoice'=>array(
                'access'=>'XI01',
                'url'=>'/invoice/index',
            ),
        ),
    ),


//    'Salary calculation'=>array(
//        'access'=>'XS',
//        'icon'=>'fa-money',
//        'items'=>array(
//            'Sales Commission'=>array(
//                'access'=>'XS01',
//                'url'=>'/commission/index',
//            ),
//            'Sales Commission history'=>array(
//                'access'=>'XS02',
//                'url'=>'/query/index',
//            ),
//            'Sales Commission ladder'=>array(
//                'access'=>'XS03',
//                'url'=>'/srate/index',
//            ),
//            'Prize Vault'=>array(
//                'access'=>'XS04',
//                'url'=>'/bonus/index',
//            ),
//            'Payroll File'=>array(
//                'access'=>'XS05',
//                'url'=>'/payroll/index',
//            ),
//            'Payroll File Approval'=>array(
//                'access'=>'XS06',
//                'url'=>'/payrollappr/index',
//            ),
//        ),
//    ),
	'System Setting'=>array(
		'access'=>'XC',
		'icon'=>'fa-gear',
		'items'=>array(
			'Account Type'=>array(
				'access'=>'XC01',
				'url'=>'/accttype/index',
				'tag'=>'@',
			),
			'Transaction Type'=>array(
				'access'=>'XC03',
				'url'=>'/transtype/index',
				'tag'=>'@',
			),
			'Accounting Item'=>array(
				'access'=>'XC06',
				'url'=>'/acctitem/index',
//				'tag'=>'@',
			),
			'Accounting Code'=>array(
				'access'=>'XC10',
				'url'=>'/acctcode/index',
			),
			'Default Account'=>array(
				'access'=>'XC05',
				'url'=>'/transtypedef/index',
			),
			'Account'=>array(
				'access'=>'XC02',
				'url'=>'/account/index',
			),
			'Approver'=>array(
				'access'=>'XC04',
				'url'=>'/approver/index',
			),
			'Delegation'=>array(
				'access'=>'XC07',
				'url'=>'/delegate/index',
			),
			'Notification Option'=>array(
				'access'=>'XC08',
				'url'=>'/site/notifyopt',
			),
		),
	),
//	'Security'=>array(
//		'access'=>'XD',
//		'items'=>array(
//			'User'=>array(
//				'access'=>'XD01',
//				'url'=>'/user/index',
//				'tag'=>'@',
//			),
//			'Group'=>array(
//				'access'=>'XD02',
//				'url'=>'/group/index',
//				'tag'=>'@',
//			),
//		),
//	),
);
