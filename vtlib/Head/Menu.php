<?php
/*+**********************************************************************************
 * The contents of this file are subject to the vtiger CRM Public License Version 1.0
 * ("License"); You may not use this file except in compliance with the License
 * The Original Code is:  vtiger CRM Open Source
 * The Initial Developer of the Original Code is vtiger.
 * Portions created by vtiger are Copyright (C) vtiger.
 * All Rights Reserved.
 * Contributor(s): JoForce.com
 ************************************************************************************/
include_once('vtlib/Head/Utils.php');

/**
 * Provides API to work with vtiger CRM Menu
 * @package vtlib
 */
class Head_Menu {
	/** ID of this menu instance */
	var $id = false;
	var $label = false;
	var $sequence = false;
	var $visible = 0;

	/**
	 * Constructor
	 */
	function __construct() {
	}

	/**
	 * Initialize this instance
	 * @param Array Map 
	 * @access private
	 */
	function initialize($valuemap) {
		$this->id       = $valuemap[parenttabid];
		$this->label    = $valuemap[parenttab_label];
		$this->sequence = $valuemap[sequence];
		$this->visible  = $valuemap[visible];
	}

	/**
	 * Get relation sequence to use
	 * @access private
	 */
	function __getNextRelSequence() {
		global $adb;
		$result = $adb->pquery("SELECT MAX(sequence) AS max_seq FROM jo_parenttabrel WHERE parenttabid=?", 
			Array($this->id));
		$maxseq = $adb->query_result($result, 0, 'max_seq');
		return ++$maxseq;
	}

	/**
	 * Add module to this menu instance
	 * @param Head_Module Instance of the module
	 */
	function addModule($moduleInstance) {
		if($this->id) {
			global $adb;
			$relsequence = $this->__getNextRelSequence();
			$adb->pquery("INSERT INTO jo_parenttabrel (parenttabid,tabid,sequence) VALUES(?,?,?)",
					Array($this->id, $moduleInstance->id, $relsequence));
			self::log("Added to menu $this->label ... DONE");
		} else {
			self::log("Menu could not be found!");
		}
		self::syncfile();
	}
	//No requirement of removeModule api()
        //Confirmed by (http://trac.vtiger.com/cgi-bin/trac.cgi/ticket/7477)
        
	/**
	 * Detach module from menu
	 * @param Head_Module Instance of the module
	 */
	static function detachModule($moduleInstance) {
		global $adb;
		$adb->pquery("DELETE FROM jo_parenttabrel WHERE tabid=?", Array($moduleInstance->id));
		self::log("Detaching from menu ... DONE");
		self::syncfile();
	}

	/**
	 * Get instance of menu by label
	 * @param String Menu label
	 */
	static function getInstance($value) {
		global $adb;
		$query = false;
		$instance = false;
		if(Head_Utils::isNumber($value)) {
			$query = "SELECT * FROM jo_parenttab WHERE parenttabid=?";
		} else {
			$query = "SELECT * FROM jo_parenttab WHERE parenttab_label=?";
		}
		$result = $adb->pquery($query, Array($value));
		if($adb->num_rows($result)) {
			$instance = new self();
			$instance->initialize($adb->fetch_array($result));
		}
		return $instance;
	}

	/**
	 * Helper function to log messages
	 * @param String Message to log
	 * @param Boolean true appends linebreak, false to avoid it
	 * @access private
	 */
	static function log($message, $delim=true) {
		Head_Utils::Log($message, $delim);
	}

	/**
	 * Synchronize the menu information to flat file
	 * @access private
	 */
	static function syncfile() {
		self::log("Updating parent_tabdata file ... STARTED");
		self::log("Updating parent_tabdata file ... DONE");
	}
}
?>
