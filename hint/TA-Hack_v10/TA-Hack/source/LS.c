#include <string.h>

char *savefile = "AB.save";

char *Load(BOOL force, APTR ga_status){
	FILE *file;
	char i;
	ULONG geslen=40, wrlen=40;
	ULONG buf[5];
	
	if(ga_status){
		set(ga_status, MUIA_Gauge_InfoText, "\0332loading...%ld%%");
		set(ga_status, MUIA_Gauge_Current, 0);
	}else{
		printf("loading...00%"); fflush(stdout);
	}
	
	file = fopen(savefile, "r");
	if(!file)
		goto loaderr;
	if(fread(buf, 1, 20, file) != 20)
		goto loaderr;
	for(i=0; i<5; i++)
		if(len[i] != buf[i]){
			strcpy(err, "Bad SaveFile.");
			goto tloaderr;
		}
	if(fread(buf, 1, 20, file) != 20)
		goto loaderr;
	for(i=0; (i<5) && (addrs[i] == (ULONG *)buf[i]); i++);
	if(i<5 && !force){
		strcpy(err, "Bad Addresses. (Try FORCE)");
		goto tloaderr;
	}
	for(i=0; i<5; i++)
		geslen += len[i];
	if(ga_status){
		set(ga_status, MUIA_Gauge_Current, 1);
	}else{
		printf("\b\b\b01%"); fflush(stdout);
	}
	for(i=0; i<5; i++){
		if(fread(addrs[i], 1, len[i], file) != len[i])
			goto loaderr;
		wrlen += len[i];
		if(ga_status){
			set(ga_status, MUIA_Gauge_Current, (wrlen*100)/geslen);
		}else{
			printf("\b\b\b%02d%%",(wrlen*100)/geslen); fflush(stdout);
		}
	}
	fclose(file);
	if(!ga_status)
		printf("\r");
	return("Game loaded.");
	
	loaderr:
	Fault(IoErr(),"LoadError",err,FAULT_MAX);
	tloaderr:
	if(file){
		fclose(file);
		remove(savefile);
	}
	if(!ga_status)
		printf("\r");
	else
		set(ga_status, MUIA_Gauge_Current, 0);
	return(err);
}

char *Save(APTR ga_status){
	FILE *file;
	char i;
	ULONG geslen=40, wrlen=40;
	
	if(ga_status){
		set(ga_status, MUIA_Gauge_InfoText, "\0332saveing...%ld%%");
		set(ga_status, MUIA_Gauge_Current, 0);
	}else{
		printf("saveing...00%"); fflush(stdout);
	}
	
	file = fopen(savefile, "w");
	if(!file)
		goto saveerr;
	if(fwrite(len, 1, 20, file) != 20)
		goto saveerr;
	if(fwrite(addrs, 1, 20, file) != 20)
		goto saveerr;
	for(i=0; i<5; i++)
		geslen += len[i];
	if(ga_status){
		set(ga_status, MUIA_Gauge_Current, 1);
	}else{
		printf("\b\b\b01%"); fflush(stdout);
	}
	for(i=0; i<5; i++){
		if(fwrite(addrs[i], 1, len[i], file) != len[i])
			goto saveerr;
		wrlen += len[i];
		if(ga_status){
			set(ga_status, MUIA_Gauge_Current, (wrlen*100)/geslen);
		}else{
			printf("\b\b\b%02d%%",(wrlen*100)/geslen); fflush(stdout);
		}
	}
	fclose(file);
	if(!ga_status)
		printf("\r");
	return("Game saved.");
	
	saveerr:
	Fault(IoErr(),"SaveError",err,FAULT_MAX);
	if(file){
		fclose(file);
		remove(savefile);
	}
	if(!ga_status)
		printf("\r");
	else
		set(ga_status, MUIA_Gauge_Current, 0);
	return(err);
}
