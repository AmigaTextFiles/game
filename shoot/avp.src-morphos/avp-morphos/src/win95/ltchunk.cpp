#include "chunk.hpp"

#include "ltchunk.hpp"


//macro for helping to force inclusion of chunks when using libraries
FORCE_CHUNK_INCLUDE_IMPLEMENT(ltchunk)

////////////////////////////////////////////////////////////////////////////////////
//Class Light_Set_Chunk

RIF_IMPLEMENT_DYNCREATE("LIGHTSET",Light_Set_Chunk)

CHUNK_WITH_CHILDREN_LOADER("LIGHTSET",Light_Set_Chunk)

/*
Children for Light_Set_Chunk :

"LTSETHDR"		Light_Set_Header_Chunk
"STDLIGHT"		Light_Chunk
"AMBIENCE"		Lighting_Ambience_Chunk
"LITSCALE"		Light_Scale_Chunk
"AVPSTRAT"		AVP_Strategy_Chunk
*/

Light_Set_Chunk::Light_Set_Chunk (Chunk_With_Children * parent, char * light_set_name)
: Chunk_With_Children (parent, "LIGHTSET")
{
	new Light_Set_Header_Chunk (this, light_set_name);
}



////////////////////////////////////////////////////////////////////////////////////

RIF_IMPLEMENT_DYNCREATE("LTSETHDR",Light_Set_Header_Chunk)

Light_Set_Header_Chunk::Light_Set_Header_Chunk (Light_Set_Chunk * parent, char l_set_name[8])
: Chunk (parent, "LTSETHDR"), pad (0)
{
	strncpy (light_set_name, l_set_name, 8);
}

void Light_Set_Header_Chunk::fill_data_block ( char * data_start)
{
chunk_implement("Light_Set_Header_Chunk::fill_data_block\n\0");
/*
	strncpy (data_start, identifier, 8);
	data_start += 8;
	*((int *) data_start) = chunk_size;
	data_start += 4;
	strncpy (data_start, light_set_name, 8);
	data_start += 8;
	*((int *) data_start) = pad;
*/	
}

Light_Set_Header_Chunk::Light_Set_Header_Chunk (Chunk_With_Children * parent, const char * data, size_t const /*size*/)
: Chunk (parent, "LTSETHDR")
{
	strncpy (light_set_name, data, 8);
	data += 8;
	pad = *((int *) data);
	BYTESWAP4(pad);
}


////////////////////////////////////////////////////////////////////////////////////

RIF_IMPLEMENT_DYNCREATE("STDLIGHT",Light_Chunk)


void Light_Chunk::fill_data_block ( char * data_start)
{
chunk_implement("Light_Set_Header_Chunk::fill_data_block\n\0");
/*
	strncpy (data_start, identifier, 8);
	data_start += 8;
	*((int *) data_start) = chunk_size;
	data_start += 4;
	*((int *) data_start) = light.light_number;
	data_start += 4;
	*((ChunkVectorInt *) data_start) = light.location;
	data_start += sizeof(ChunkVectorInt);
	*((ChunkMatrix *) data_start) = light.orientation;
	data_start += sizeof(ChunkMatrix);
	*((int *) data_start) = light.brightness;
	data_start += 4;
	*((int *) data_start) = light.spread;
	data_start += 4;
	*((int *) data_start) = light.range;
	data_start += 4;
	*((int *) data_start) = light.colour;
	data_start += 4;
	*((int *) data_start) = light.engine_light_flags;
	data_start += 4;
	*((int *) data_start) = light.local_light_flags;
	data_start += 4;
	*((int *) data_start) = light.pad1;
	data_start += 4;
	*((int *) data_start) = light.pad2;
*/	
}

Light_Chunk::Light_Chunk(Chunk_With_Children * parent, const char * data, size_t const /*size*/)
: Chunk (parent, "STDLIGHT")
{
	light.light_number = *((int *) data);
	BYTESWAP4(light.light_number);
	data += 4;

	light.location = *((ChunkVectorInt *) data);
	light.location.ByteSwap();
	data += sizeof(ChunkVectorInt);
	
	light.orientation = *((ChunkMatrix *) data);
	light.orientation.ByteSwap();
	data += sizeof(ChunkMatrix);

	light.brightness = *((int *) data);
	BYTESWAP4(light.brightness);
	data += 4;
	light.spread = *((int *) data);
	BYTESWAP4(light.spread);
	data += 4;
	light.range = *((int *) data);
	BYTESWAP4(light.range);
	data += 4;

	light.colour = *((int *) data);
	BYTESWAP4(light.colour);
	data += 4;

	light.engine_light_flags = *((int *) data);
	BYTESWAP4(light.engine_light_flags);
	data += 4;
	light.local_light_flags = *((int *) data);
	BYTESWAP4(light.local_light_flags);
	data += 4;

	light.pad1 = *((int *) data);
	BYTESWAP4(light.pad1);
	data += 4;
	light.pad2 = *((int *) data);
	BYTESWAP4(light.pad2);
	
	light_added_to_module = FALSE;
}


////////////////////////////////////////////////////////////////////////////////////

RIF_IMPLEMENT_DYNCREATE("SHPVTINT",Shape_Vertex_Intensities_Chunk)


Shape_Vertex_Intensities_Chunk::Shape_Vertex_Intensities_Chunk
(Chunk_With_Children *parent, char *lsn, int num_v, int * i_array)
: Chunk (parent, "SHPVTINT"), pad (0), num_vertices(num_v)
{
	strncpy (light_set_name, lsn, 8);
	
	intensity_array = new int [num_v];
	
	for (int i=0; i<num_v; i++)
	{
		intensity_array[i] = i_array[i];
	}
}


void Shape_Vertex_Intensities_Chunk::fill_data_block ( char * data_start)
{
chunk_implement("Shape_Vertex_Intensities_Chunk::fill_data_block");
/*
	strncpy (data_start, identifier, 8);
	data_start += 8;
	*((int *) data_start) = chunk_size;
	data_start += 4;
	strncpy (data_start, light_set_name,8);
	data_start += 8;
	*((int *) data_start) = pad;
	data_start += 4;
	*((int *) data_start) = num_vertices;
	data_start += 4;
	int * cia = (int *)data_start, * ia = intensity_array;
	for (int i = num_vertices; i; i--)
	{
		*cia++ = *ia++;
	}
*/	
}

Shape_Vertex_Intensities_Chunk::Shape_Vertex_Intensities_Chunk(Chunk_With_Children * parent, const char * data, size_t const /*size*/)
: Chunk (parent, "SHPVTINT")
{
	strncpy (light_set_name, data, 8);
	
	data += 8;
	
	pad = *((int *)data);
	BYTESWAP4(pad);
	data += 4;
	
	num_vertices = *((int *)data);
	BYTESWAP4(num_vertices);
	data += 4;

	intensity_array = new int [num_vertices];

	int * cia = (int *)data, * ia = intensity_array;

	for (int i = num_vertices; i; i--)
	{
		int val = *cia++;
		BYTESWAP4(val);
		*ia++ = val;
	}
}


Shape_Vertex_Intensities_Chunk::~Shape_Vertex_Intensities_Chunk()
{
	if (intensity_array)
		delete [] intensity_array;
}

///////////////////////////////////////////////////////////////////////////

RIF_IMPLEMENT_DYNCREATE("AMBIENCE",Lighting_Ambience_Chunk)

Lighting_Ambience_Chunk::Lighting_Ambience_Chunk (Light_Set_Chunk * parent, int _ambience)
: Chunk (parent, "AMBIENCE"), ambience (_ambience)
{
}

Lighting_Ambience_Chunk::Lighting_Ambience_Chunk (Chunk_With_Children * parent, const char * data, size_t const /*size*/)
: Chunk (parent, "AMBIENCE")
{
	ambience = *((int *)data);
	BYTESWAP4(ambience);
}

void Lighting_Ambience_Chunk::fill_data_block ( char * data_start)
{
chunk_implement("Lighting_Ambience_Chunk::fill_data_block");
/*
	strncpy (data_start, identifier, 8);
	data_start += 8;
	*((int *) data_start) = chunk_size;
	data_start += 4;
	*((int *) data_start) = ambience;
	data_start += 4;
*/	
}



///////////////////////////////////////////////////////////////////////////
RIF_IMPLEMENT_DYNCREATE("LITSCALE",Light_Scale_Chunk)

Light_Scale_Chunk::Light_Scale_Chunk(Light_Set_Chunk* parent,int mode)
:Chunk(parent,"LITSCALE")
{
	LightMode=mode;
	prelight_multiply=runtime_multiply=1;
	prelight_multiply_above=runtime_multiply_above=0;
	prelight_add=runtime_add=0;
	spare1=spare2=spare3=0;
}

Light_Scale_Chunk::Light_Scale_Chunk(Chunk_With_Children* parent,const char* data,size_t)
:Chunk(parent,"LITSCALE")
{
	LightMode=*(int*)data;
	BYTESWAP4(LightMode);
	data+=4;
	prelight_multiply=*(float*)data;
	BYTESWAP4(prelight_multiply);
	data+=4;
	prelight_multiply_above= (int) *(float*)data;
	BYTESWAP4(prelight_multiply_above);
	data+=4;
	prelight_add= (int) *(float*)data;
	BYTESWAP4(prelight_add);
	data+=4;
	
	runtime_multiply=*(float*)data;
	BYTESWAP4(runtime_multiply);
	data+=4;
	runtime_multiply_above= (int) *(float*)data;
	BYTESWAP4(runtime_multiply_above);
	data+=4;
	runtime_add= (int) *(float*)data;
	BYTESWAP4(runtime_add);
	data+=4;

	spare1=*(int*)data;
	BYTESWAP4(spare1);
	data+=4;
	spare2=*(int*)data;
	BYTESWAP4(spare2);
	data+=4;
	spare3=*(int*)data;
	BYTESWAP4(spare3);
	data+=4;

}

void Light_Scale_Chunk::fill_data_block(char* data_start)
{
chunk_implement("Light_Scale_Chunk::fill_data_block");
/*
	strncpy(data_start,identifier,8);
	data_start+=8;
	*((int *) data_start) = chunk_size;
	data_start += 4;

	*(int*)data_start=LightMode;
	data_start+=4;

	*(float*)data_start=prelight_multiply;
	data_start+=4;
	*(float*)data_start= (float) prelight_multiply_above;
	data_start+=4;
	*(float*)data_start= (float) prelight_add;
	data_start+=4;

	*(float*)data_start=runtime_multiply;
	data_start+=4;
	*(float*)data_start= (float) runtime_multiply_above;
	data_start+=4;
	*(float*)data_start= (float) runtime_add;
	data_start+=4;

	*(int*)data_start=spare1;
	data_start+=4;
	*(int*)data_start=spare2;
	data_start+=4;
	*(int*)data_start=spare3;
	data_start+=4;
*/
}

int Light_Scale_Chunk::ApplyPrelightScale(int l)
{
	if(l<prelight_multiply_above)return l;
	l+=(prelight_add-prelight_multiply_above);
	l= (int)(l*prelight_multiply);
	l+=prelight_multiply_above;
	l=min(l,255);
	return max(l,prelight_multiply_above);
}
int Light_Scale_Chunk::ApplyRuntimeScale(int l)
{
	if(l<runtime_multiply_above)return l;
	l+=(runtime_add-runtime_multiply_above);
	l=(int)( l*runtime_multiply);
	l+=runtime_multiply_above;
	l=min(l,255);
	return max(l,runtime_multiply_above);
}
////////////////////////////////////////////////////////////////////////////////////
RIF_IMPLEMENT_DYNCREATE("PLOBJLIT",Placed_Object_Light_Chunk)

Placed_Object_Light_Chunk::Placed_Object_Light_Chunk(Chunk_With_Children * parent, const char * data, size_t const /*size*/)
: Chunk (parent, "PLOBJLIT")
{
	light=*(Placed_Object_Light_Data*) data;
	BYTESWAP4(light.brightness);
	BYTESWAP4(light.spread);
	BYTESWAP4(light.range);
	BYTESWAP4(light.up_colour);
	BYTESWAP4(light.down_colour);
	BYTESWAP4(light.engine_light_flags);
	BYTESWAP4(light.local_light_flags);
	BYTESWAP4(light.fade_up_time);
	BYTESWAP4(light.fade_down_time);
	BYTESWAP4(light.up_time);
	BYTESWAP4(light.down_time);
	BYTESWAP4(light.start_time);
	BYTESWAP4(light.light_type);
	BYTESWAP4(light.on_off_type);
	BYTESWAP4(light.flags);	
	data+=sizeof(Placed_Object_Light_Data);

	num_extra_data=*(int*)data;
	BYTESWAP4(num_extra_data);
	data+=4;
	
	if(num_extra_data)
	{
		extra_data=new int[num_extra_data];
		for(int i=0;i<num_extra_data;i++)
		{
			extra_data[i]=*(int*)data;
			BYTESWAP4(extra_data[i]);
			data+=4;
		}
	} 
	else
	{
		extra_data=0;
	}
}

Placed_Object_Light_Chunk::~Placed_Object_Light_Chunk()
{
	if(extra_data)
	{
		delete [] extra_data;
	}
}

void Placed_Object_Light_Chunk::fill_data_block(char* data)
{
chunk_implement("Placed_Object_Light_Chunk::fill_data_block");
/*
	strncpy (data, identifier, 8);

	data += 8;

	*((int *) data) = chunk_size;

	data += 4;

	*(Placed_Object_Light_Data*)data=light;
	data+=sizeof(Placed_Object_Light_Data);

	*(int*)data=num_extra_data;
	data+=4;
	
	for(int i=0;i<num_extra_data;i++)
	{
		*(int*)data=extra_data[i];
		data+=4;
	}
*/	
}


////////////////////////////////////////////////////////////////////////////////////
