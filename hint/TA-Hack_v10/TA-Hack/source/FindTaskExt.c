#include <exec/memory.h>
#include <exec/execbase.h>
#define __USE_SYSBASE
#include <proto/exec.h>
#include <dos/dosextens.h>
#include <string.h>

#include "FindTaskExt.h"

#define b2c(bptr,type) ( (type) ((ULONG)(bptr) << 2))

struct Task *FindTaskExt(char *name, BOOL casesensitive, ULONG *type){
	char cname[80], blen;
	struct Process *proc;
	char *bname, i;
	ULONG dummy_type;
	
	if(!type){
		type=&dummy_type;
		*type = FT_TASK | FT_PROCESS | FT_COMMAND;
	}
	
	Forbid();
	for(i=0; i<2; i++){
		if(i)
			proc = (struct Process *) SysBase->TaskWait.lh_Head;
		else
			proc = (struct Process *) SysBase->TaskReady.lh_Head;
		while(proc->pr_Task.tc_Node.ln_Succ){
			if((strcmp(proc->pr_Task.tc_Node.ln_Name, name)==0) || (!casesensitive && stricmp(proc->pr_Task.tc_Node.ln_Name, name)==0)){
				if((*type & FT_TASK) && (proc->pr_Task.tc_Node.ln_Type == NT_TASK)){
					*type = FT_TASK;
					goto exit;
				}else if ((*type & FT_PROCESS) && (proc->pr_Task.tc_Node.ln_Type == NT_PROCESS)){
					*type = FT_PROCESS;
					goto exit;
				}
			}else if((*type & FT_COMMAND) &&
						(proc->pr_Task.tc_Node.ln_Type==NT_PROCESS) &&
				      (proc->pr_CLI) &&
				      (b2c(proc->pr_CLI, struct CommandLineInterface *)->cli_Module) &&
				      (bname = b2c(b2c(proc->pr_CLI, struct CommandLineInterface *)->cli_CommandName, char *))){
		      memcpy(cname, bname+1, blen=*bname);
		      cname[blen]=0;
		      if((strcmp(cname,name)==0) || (!casesensitive && stricmp(cname,name)==0)){
		      	*type = FT_COMMAND;
		      	goto exit;
		      }
		   }
		   proc = (struct Process *) proc->pr_Task.tc_Node.ln_Succ;
		}
	}
	proc = NULL;
	*type = FT_NONE;
	exit:
	Permit();
	return((struct Task *)proc);
}
