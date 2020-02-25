<?php
/* +**********************************************************************************
 * The contents of this file are subject to the JoForce Public License Version 1.0
 * ("License"); You may not use this file except in compliance with the License
 * The Developer of the Original Code is JoForce.
 * All Rights Reserved.
 * ********************************************************************************** */

class DuplicateCheck_UpdateFields_View extends Head_Index_View
{
   	public function __construct()
        {
                parent::__construct();
        }
        public function process(Head_Request $request){
           extract($_POST);
         
        	global $adb;
           
            
            $isenabled=$_POST['isenabled'];
	    $crosscheck=$_POST['ischecked'];
            	if($isenabled == ""){
        	   	 $isenabled = 0;
           	}
		if($ischecked == "")
			$crosscheck = 0;
		else
			$crosscheck = 1;
        	$fieldID=$_POST['fieldID'];
            $modulename=$_POST['modulename'];
           // $fieldIDMerge=$_POST['fieldIDMerge'];            
            $fieldsID = implode(',', $fieldID);
            //$fieldIdToMerge = implode(',',$fieldIDMerge);
        	if(empty($modulename) || trim($modulename) == ''){
                header("location:index.php?module=DuplicateCheck&view=List&sourceModule=$modulename");
        		die('Failure');
                
        	}
           
            if($modulename != ""){
        	$runQuery = $adb->pquery("UPDATE jo_duplicatechecksettings SET fieldstomatch='$fieldsID' ,isenabled='$isenabled' ,crosscheck='$crosscheck' WHERE modulename='$modulename'");
            header("location:index.php?module=DuplicateCheck&view=List&sourceModule=$modulename&notify=1");
        }
            	if($result){
                $response = new Head_Response();
                $response->setEmitType(Head_Response::$EMIT_JSON);
                $response->setResult($result);
                $response->emit();
                die;
        	}
        	die('Failure');

        }
    }

?>
