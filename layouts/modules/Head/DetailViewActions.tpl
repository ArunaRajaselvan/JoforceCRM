{*<!--
/*********************************************************************************
** The contents of this file are subject to the vtiger CRM Public License Version 1.0
* ("License"); You may not use this file except in compliance with the License
* The Original Code is: vtiger CRM Open Source
* The Initial Developer of the Original Code is vtiger.
* Portions created by vtiger are Copyright (C) vtiger.
* All Rights Reserved.
* Contributor(s): JoForce.com
********************************************************************************/
-->*}
{strip}
    <div class="col-lg-7 detailViewButtoncontainer">
        <div class="pull-right btn-toolbar joforce-detailview-btn">
            <span class="btn-group">
            {assign var=STARRED value=$RECORD->get('starred')}
            {if $MODULE_MODEL->isStarredEnabled()}
                <button class="btn btn-default markStar {if $STARRED} active {/if}" id="starToggle">
                    <div class='starredStatus' title="{vtranslate('LBL_STARRED', $MODULE)}">
                        <div class='unfollowMessage'>
                            <i class="fa fa-star-o"></i> &nbsp;{vtranslate('LBL_UNFOLLOW',$MODULE)}
                        </div>
                        <div class='followMessage'>
                            <i class="fa fa-star active"></i> &nbsp;{vtranslate('LBL_FOLLOWING',$MODULE)}
                        </div>
                    </div>
                    <div class='unstarredStatus' title="{vtranslate('LBL_NOT_STARRED', $MODULE)}">
                        {vtranslate('LBL_FOLLOW',$MODULE)}
                    </div>
                </button>
            {/if}
            </span>

        {if $MODULE == 'Contacts'}
        {assign var=global_masquerade_permission value=getGlobalMasqueradeUserPermission()}
        {if $global_masquerade_permission}
            {assign var=masquerade_permission value=getMasqueradeUserActionPermission()}
            {if $masquerade_permission}
                <span class="btn-group">
                        <div class="btn btn-default" id="convert-masquerade-user" data-recordid="{$RECORD->getId()}">{vtranslate('LBL_CONVERT_USER', $MODULE)}
                        </div>
                </span>
            {/if}
        {/if}
            {/if}

            {foreach item=DETAIL_VIEW_BASIC_LINK from=$DETAILVIEW_LINKS['DETAILVIEWBASIC']}
            <span class="btn-group">
                <button class="btn btn-default" id="{$MODULE_NAME}_detailView_basicAction_{Head_Util_Helper::replaceSpaceWithUnderScores($DETAIL_VIEW_BASIC_LINK->getLabel())}"
                        {if $DETAIL_VIEW_BASIC_LINK->isPageLoadLink()}
                            onclick="window.location.href = '{if $DETAIL_VIEW_BASIC_LINK->getLabel() eq 'Add Project Task'}{$SITEURL}{/if}{$DETAIL_VIEW_BASIC_LINK->getUrl()}'"
                        {else}
                            onclick="{$DETAIL_VIEW_BASIC_LINK->getUrl()}"
                        {/if}

                        {if $MODULE_NAME eq 'Documents' && $DETAIL_VIEW_BASIC_LINK->getLabel() eq 'LBL_VIEW_FILE'}
                            data-filelocationtype="{$DETAIL_VIEW_BASIC_LINK->get('filelocationtype')}" data-filename="{$DETAIL_VIEW_BASIC_LINK->get('filename')}"
                        {/if}>
                    {vtranslate($DETAIL_VIEW_BASIC_LINK->getLabel(), $MODULE_NAME)}
                </button>
            </span>
            {/foreach}
            {if $DETAILVIEW_LINKS['DETAILVIEW']|@count gt 0}
            <span class="btn-group">
                <button class="btn btn-default dropdown-toggle" data-toggle="dropdown" href="javascript:void(0);">
                   {vtranslate('LBL_MORE', $MODULE_NAME)}&nbsp;&nbsp;<i class="caret"></i>
                </button>
                <ul class="dropdown-menu dropdown-menu-right">
                    {foreach item=DETAIL_VIEW_LINK from=$DETAILVIEW_LINKS['DETAILVIEW']}
                        {if $DETAIL_VIEW_LINK->getLabel() eq ""} 
                            <li class="divider"></li>   
                            {else}
                            <li id="{$MODULE_NAME}_detailView_moreAction_{Head_Util_Helper::replaceSpaceWithUnderScores($DETAIL_VIEW_LINK->getLabel())}">
                                {if $DETAIL_VIEW_LINK->getUrl()|strstr:"javascript"} 
                                    <a href='{$DETAIL_VIEW_LINK->getUrl()}'>{vtranslate($DETAIL_VIEW_LINK->getLabel(), $MODULE_NAME)}</a>
                                {else}
                                    <a href='{$DETAIL_VIEW_LINK->getUrl()}' >{vtranslate($DETAIL_VIEW_LINK->getLabel(), $MODULE_NAME)}</a>
                                {/if}
                            </li>
                        {/if}
                    {/foreach}
                </ul>
            </span>
            {/if}
            
            {if !{$NO_PAGINATION}}
            <div class="btn-group pull-right">
                <button class="btn-paginate" id="detailViewPreviousRecordButton" {if empty($PREVIOUS_RECORD_URL)} disabled="disabled" {else} onclick="window.location.href = '{$PREVIOUS_RECORD_URL}'" {/if} >
                    <i class="fa fa-chevron-left"></i>
                </button>
                <button class="btn-paginate" id="detailViewNextRecordButton"{if empty($NEXT_RECORD_URL)} disabled="disabled" {else} onclick="window.location.href = '{$NEXT_RECORD_URL}'" {/if}>
                    <i class="fa fa-chevron-right"></i>
                </button>
            </div>
            {/if}        
        </div>
        <input type="hidden" name="record_id" value="{$RECORD->getId()}">
    </div>
{strip}