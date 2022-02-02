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
public class ContactHandler implements TriggerHandlerInterface {

    private static final ContactHandler instance = new ContactHandler ();
    public static ContactHandler getInstance () {
        return instance;
    }

    public void beforeUpdate () {
        ContactUtil.validateMask((List<Contact>) Trigger.new);
    }

    public void beforeInsert () {
        ContactUtil.validateMask((List<Contact>) Trigger.new);
    }

    public void beforeDelete () { 
        String valor  = 'beforeDelete';
        System.debug(valor);
    }

    public void afterUpdate () { 
        String valor  = 'beforeDelete';
        System.debug(valor);
    }

    public void afterInsert () { 
        String valor  = 'afterInsert';
        System.debug(valor);
    }

    public void afterDelete () { 
        String valor  = 'afterDelete';
        System.debug(valor);
    }
}