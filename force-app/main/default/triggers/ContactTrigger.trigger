/**
 * @File Name          : 
 * @Description        :
 * @Author             : bianca.andrade@moldsoft.com.br
 * @Group              :
 * @Last Modified By   : bianca.andrade@moldsoft.com.br
 * @Last Modified On   : 07/02/2021
 * @Modification Log   :
 * Ver       Date            Author      		    Modification
 * 1.0    07/02/2021  bianca.andrade@moldsoft.com.br         Initial Version
**/
trigger ContactTrigger on Contact (
    before insert, 
	before update, 
	before delete, 
	after insert, 
	after update, 
	after delete, 
	after undelete) {
        if (Trigger.isBefore)
            if (Trigger.isUpdate)
                ContactHandler.getInstance().beforeUpdate();
            else if (Trigger.isInsert)
                ContactHandler.getInstance().beforeInsert();
            else
                ContactHandler.getInstance().beforeDelete();
        else
            if (Trigger.isUpdate)
                ContactHandler.getInstance().afterUpdate();
            else if (Trigger.isInsert)
                ContactHandler.getInstance().afterInsert();
            else 
                ContactHandler.getInstance().afterDelete();
}