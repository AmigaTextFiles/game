#ifndef _VBCCINLINE_EXPAT_H
#define _VBCCINLINE_EXPAT_H

#ifndef EXEC_TYPES_H
#include <exec/types.h>
#endif

void * __XML_ParserCreate(__reg("a6") struct Library *, __reg("a0") const char * encodingName)="\tjsr\t-30(a6)";
#define XML_ParserCreate(encodingName) __XML_ParserCreate(ExpatBase, (encodingName))

void * __XML_ParserCreateNS(__reg("a6") struct Library *, __reg("a0") const char * encodingName, __reg("d0") LONG nsSep)="\tjsr\t-36(a6)";
#define XML_ParserCreateNS(encodingName, nsSep) __XML_ParserCreateNS(ExpatBase, (encodingName), (nsSep))

void * __XML_ParserCreate_MM(__reg("a6") struct Library *, __reg("a0") const char * encoding, __reg("a1") const void * memsuite, __reg("a2") const char * namespaceSeparator)="\tjsr\t-42(a6)";
#define XML_ParserCreate_MM(encoding, memsuite, namespaceSeparator) __XML_ParserCreate_MM(ExpatBase, (encoding), (memsuite), (namespaceSeparator))

void * __XML_ExternalEntityParserCreate(__reg("a6") struct Library *, __reg("a0") void * parser, __reg("a1") const char * context, __reg("a2") const char * encoding)="\tjsr\t-48(a6)";
#define XML_ExternalEntityParserCreate(parser, context, encoding) __XML_ExternalEntityParserCreate(ExpatBase, (parser), (context), (encoding))

void __XML_ParserFree(__reg("a6") struct Library *, __reg("a0") void * parser)="\tjsr\t-54(a6)";
#define XML_ParserFree(parser) __XML_ParserFree(ExpatBase, (parser))

int __XML_Parse(__reg("a6") struct Library *, __reg("a0") void * parser, __reg("a1") const char * s, __reg("d0") LONG len, __reg("d1") LONG isFinal)="\tjsr\t-60(a6)";
#define XML_Parse(parser, s, len, isFinal) __XML_Parse(ExpatBase, (parser), (s), (len), (isFinal))

int __XML_ParseBuffer(__reg("a6") struct Library *, __reg("a0") void * parser, __reg("d0") LONG len, __reg("d1") LONG isFinal)="\tjsr\t-66(a6)";
#define XML_ParseBuffer(parser, len, isFinal) __XML_ParseBuffer(ExpatBase, (parser), (len), (isFinal))

void * __XML_GetBuffer(__reg("a6") struct Library *, __reg("a0") void * parser, __reg("d0") LONG len)="\tjsr\t-72(a6)";
#define XML_GetBuffer(parser, len) __XML_GetBuffer(ExpatBase, (parser), (len))

void __XML_SetStartElementHandler(__reg("a6") struct Library *, __reg("a0") void * parser, __reg("a1") void * start)="\tjsr\t-78(a6)";
#define XML_SetStartElementHandler(parser, start) __XML_SetStartElementHandler(ExpatBase, (parser), (start))

void __XML_SetEndElementHandler(__reg("a6") struct Library *, __reg("a0") void * parser, __reg("a1") void * end)="\tjsr\t-84(a6)";
#define XML_SetEndElementHandler(parser, end) __XML_SetEndElementHandler(ExpatBase, (parser), (end))

void __XML_SetElementHandler(__reg("a6") struct Library *, __reg("a0") void * parser, __reg("a1") void * start, __reg("a2") void * end)="\tjsr\t-90(a6)";
#define XML_SetElementHandler(parser, start, end) __XML_SetElementHandler(ExpatBase, (parser), (start), (end))

void __XML_SetCharacterDataHandler(__reg("a6") struct Library *, __reg("a0") void * parser, __reg("a1") void * handler)="\tjsr\t-96(a6)";
#define XML_SetCharacterDataHandler(parser, handler) __XML_SetCharacterDataHandler(ExpatBase, (parser), (handler))

void __XML_SetProcessingInstructionHandler(__reg("a6") struct Library *, __reg("a0") void * parser, __reg("a1") void * handler)="\tjsr\t-102(a6)";
#define XML_SetProcessingInstructionHandler(parser, handler) __XML_SetProcessingInstructionHandler(ExpatBase, (parser), (handler))

void __XML_SetCommentHandler(__reg("a6") struct Library *, __reg("a0") void * parser, __reg("a1") void * handler)="\tjsr\t-108(a6)";
#define XML_SetCommentHandler(parser, handler) __XML_SetCommentHandler(ExpatBase, (parser), (handler))

void __XML_SetStartCdataSectionHandler(__reg("a6") struct Library *, __reg("a0") void * parser, __reg("a1") void * start)="\tjsr\t-114(a6)";
#define XML_SetStartCdataSectionHandler(parser, start) __XML_SetStartCdataSectionHandler(ExpatBase, (parser), (start))

void __XML_SetEndCdataSectionHandler(__reg("a6") struct Library *, __reg("a0") void * parser, __reg("a1") void * end)="\tjsr\t-120(a6)";
#define XML_SetEndCdataSectionHandler(parser, end) __XML_SetEndCdataSectionHandler(ExpatBase, (parser), (end))

void __XML_SetCdataSectionHandler(__reg("a6") struct Library *, __reg("a0") void * parser, __reg("a1") void * start, __reg("a2") void * end)="\tjsr\t-126(a6)";
#define XML_SetCdataSectionHandler(parser, start, end) __XML_SetCdataSectionHandler(ExpatBase, (parser), (start), (end))

void __XML_SetDefaultHandler(__reg("a6") struct Library *, __reg("a0") void * parser, __reg("a1") void * handler)="\tjsr\t-132(a6)";
#define XML_SetDefaultHandler(parser, handler) __XML_SetDefaultHandler(ExpatBase, (parser), (handler))

void __XML_SetDefaultHandlerExpand(__reg("a6") struct Library *, __reg("a0") void * parser, __reg("a1") void * handler)="\tjsr\t-138(a6)";
#define XML_SetDefaultHandlerExpand(parser, handler) __XML_SetDefaultHandlerExpand(ExpatBase, (parser), (handler))

void __XML_SetExternalEntityRefHandler(__reg("a6") struct Library *, __reg("a0") void * parser, __reg("a1") void * handler)="\tjsr\t-144(a6)";
#define XML_SetExternalEntityRefHandler(parser, handler) __XML_SetExternalEntityRefHandler(ExpatBase, (parser), (handler))

void __XML_SetExternalEntityRefHandlerArg(__reg("a6") struct Library *, __reg("a0") void * parser, __reg("a1") void * arg)="\tjsr\t-150(a6)";
#define XML_SetExternalEntityRefHandlerArg(parser, arg) __XML_SetExternalEntityRefHandlerArg(ExpatBase, (parser), (arg))

void __XML_SetUnknownEncodingHandler(__reg("a6") struct Library *, __reg("a0") void * parser, __reg("a1") void * handler, __reg("a2") void * data)="\tjsr\t-156(a6)";
#define XML_SetUnknownEncodingHandler(parser, handler, data) __XML_SetUnknownEncodingHandler(ExpatBase, (parser), (handler), (data))

void __XML_SetStartNamespaceDeclHandler(__reg("a6") struct Library *, __reg("a0") void * parser, __reg("a1") void * start)="\tjsr\t-162(a6)";
#define XML_SetStartNamespaceDeclHandler(parser, start) __XML_SetStartNamespaceDeclHandler(ExpatBase, (parser), (start))

void __XML_SetEndNamespaceDeclHandler(__reg("a6") struct Library *, __reg("a0") void * parser, __reg("a1") void * end)="\tjsr\t-168(a6)";
#define XML_SetEndNamespaceDeclHandler(parser, end) __XML_SetEndNamespaceDeclHandler(ExpatBase, (parser), (end))

void __XML_SetNamespaceDeclHandler(__reg("a6") struct Library *, __reg("a0") void * parser, __reg("a1") void * start, __reg("a2") void * end)="\tjsr\t-174(a6)";
#define XML_SetNamespaceDeclHandler(parser, start, end) __XML_SetNamespaceDeclHandler(ExpatBase, (parser), (start), (end))

void __XML_SetXmlDeclHandler(__reg("a6") struct Library *, __reg("a0") void * parser, __reg("a1") void * handler)="\tjsr\t-180(a6)";
#define XML_SetXmlDeclHandler(parser, handler) __XML_SetXmlDeclHandler(ExpatBase, (parser), (handler))

void __XML_SetStartDoctypeDeclHandler(__reg("a6") struct Library *, __reg("a0") void * parser, __reg("a1") void * start)="\tjsr\t-186(a6)";
#define XML_SetStartDoctypeDeclHandler(parser, start) __XML_SetStartDoctypeDeclHandler(ExpatBase, (parser), (start))

void __XML_SetEndDoctypeDeclHandler(__reg("a6") struct Library *, __reg("a0") void * parser, __reg("a1") void * end)="\tjsr\t-192(a6)";
#define XML_SetEndDoctypeDeclHandler(parser, end) __XML_SetEndDoctypeDeclHandler(ExpatBase, (parser), (end))

void __XML_SetDoctypeDeclHandler(__reg("a6") struct Library *, __reg("a0") void * parser, __reg("a1") void * start, __reg("a2") void * end)="\tjsr\t-198(a6)";
#define XML_SetDoctypeDeclHandler(parser, start, end) __XML_SetDoctypeDeclHandler(ExpatBase, (parser), (start), (end))

void __XML_SetElementDeclHandler(__reg("a6") struct Library *, __reg("a0") void * parser, __reg("a1") void * eldecl)="\tjsr\t-204(a6)";
#define XML_SetElementDeclHandler(parser, eldecl) __XML_SetElementDeclHandler(ExpatBase, (parser), (eldecl))

void __XML_SetAttlistDeclHandler(__reg("a6") struct Library *, __reg("a0") void * parser, __reg("a1") void * attdecl)="\tjsr\t-210(a6)";
#define XML_SetAttlistDeclHandler(parser, attdecl) __XML_SetAttlistDeclHandler(ExpatBase, (parser), (attdecl))

void __XML_SetEntityDeclHandler(__reg("a6") struct Library *, __reg("a0") void * parser, __reg("a1") void * handler)="\tjsr\t-216(a6)";
#define XML_SetEntityDeclHandler(parser, handler) __XML_SetEntityDeclHandler(ExpatBase, (parser), (handler))

void __XML_SetUnparsedEntityDeclHandler(__reg("a6") struct Library *, __reg("a0") void * parser, __reg("a1") void * handler)="\tjsr\t-222(a6)";
#define XML_SetUnparsedEntityDeclHandler(parser, handler) __XML_SetUnparsedEntityDeclHandler(ExpatBase, (parser), (handler))

void __XML_SetNotationDeclHandler(__reg("a6") struct Library *, __reg("a0") void * parser, __reg("a1") void * handler)="\tjsr\t-228(a6)";
#define XML_SetNotationDeclHandler(parser, handler) __XML_SetNotationDeclHandler(ExpatBase, (parser), (handler))

void __XML_SetNotStandaloneHandler(__reg("a6") struct Library *, __reg("a0") void * parser, __reg("a1") void * handler)="\tjsr\t-234(a6)";
#define XML_SetNotStandaloneHandler(parser, handler) __XML_SetNotStandaloneHandler(ExpatBase, (parser), (handler))

int __XML_GetErrorCode(__reg("a6") struct Library *, __reg("a0") void * parser)="\tjsr\t-240(a6)";
#define XML_GetErrorCode(parser) __XML_GetErrorCode(ExpatBase, (parser))

const char * __XML_ErrorString(__reg("a6") struct Library *, __reg("d0") LONG code)="\tjsr\t-246(a6)";
#define XML_ErrorString(code) __XML_ErrorString(ExpatBase, (code))

long __XML_GetCurrentByteIndex(__reg("a6") struct Library *, __reg("a0") void * parser)="\tjsr\t-252(a6)";
#define XML_GetCurrentByteIndex(parser) __XML_GetCurrentByteIndex(ExpatBase, (parser))

int __XML_GetCurrentLineNumber(__reg("a6") struct Library *, __reg("a0") void * parser)="\tjsr\t-258(a6)";
#define XML_GetCurrentLineNumber(parser) __XML_GetCurrentLineNumber(ExpatBase, (parser))

int __XML_GetCurrentColumnNumber(__reg("a6") struct Library *, __reg("a0") void * parser)="\tjsr\t-264(a6)";
#define XML_GetCurrentColumnNumber(parser) __XML_GetCurrentColumnNumber(ExpatBase, (parser))

int __XML_GetCurrentByteCount(__reg("a6") struct Library *, __reg("a0") void * parser)="\tjsr\t-270(a6)";
#define XML_GetCurrentByteCount(parser) __XML_GetCurrentByteCount(ExpatBase, (parser))

const char * __XML_GetInputContext(__reg("a6") struct Library *, __reg("a0") void * parser, __reg("a1") int * offset, __reg("a2") int * size)="\tjsr\t-276(a6)";
#define XML_GetInputContext(parser, offset, size) __XML_GetInputContext(ExpatBase, (parser), (offset), (size))

void __XML_SetUserData(__reg("a6") struct Library *, __reg("a0") void * parser, __reg("a1") void * userData)="\tjsr\t-282(a6)";
#define XML_SetUserData(parser, userData) __XML_SetUserData(ExpatBase, (parser), (userData))

void __XML_DefaultCurrent(__reg("a6") struct Library *, __reg("a0") void * parser)="\tjsr\t-288(a6)";
#define XML_DefaultCurrent(parser) __XML_DefaultCurrent(ExpatBase, (parser))

void __XML_UseParserAsHandlerArg(__reg("a6") struct Library *, __reg("a0") void * parser)="\tjsr\t-294(a6)";
#define XML_UseParserAsHandlerArg(parser) __XML_UseParserAsHandlerArg(ExpatBase, (parser))

int __XML_SetBase(__reg("a6") struct Library *, __reg("a0") void * parser, __reg("a1") const char * p)="\tjsr\t-300(a6)";
#define XML_SetBase(parser, p) __XML_SetBase(ExpatBase, (parser), (p))

const char * __XML_GetBase(__reg("a6") struct Library *, __reg("a0") void * parser)="\tjsr\t-306(a6)";
#define XML_GetBase(parser) __XML_GetBase(ExpatBase, (parser))

int __XML_GetSpecifiedAttributeCount(__reg("a6") struct Library *, __reg("a0") void * parser)="\tjsr\t-312(a6)";
#define XML_GetSpecifiedAttributeCount(parser) __XML_GetSpecifiedAttributeCount(ExpatBase, (parser))

int __XML_GetIdAttributeIndex(__reg("a6") struct Library *, __reg("a0") void * parser)="\tjsr\t-318(a6)";
#define XML_GetIdAttributeIndex(parser) __XML_GetIdAttributeIndex(ExpatBase, (parser))

int __XML_SetEncoding(__reg("a6") struct Library *, __reg("a0") void * parser, __reg("a1") const char * encoding)="\tjsr\t-324(a6)";
#define XML_SetEncoding(parser, encoding) __XML_SetEncoding(ExpatBase, (parser), (encoding))

int __XML_SetParamEntityParsing(__reg("a6") struct Library *, __reg("a0") void * parser, __reg("a1") void * parsing)="\tjsr\t-330(a6)";
#define XML_SetParamEntityParsing(parser, parsing) __XML_SetParamEntityParsing(ExpatBase, (parser), (void *)(parsing))

void __XML_SetReturnNSTriplet(__reg("a6") struct Library *, __reg("a0") void * parser, __reg("d0") LONG do_nst)="\tjsr\t-336(a6)";
#define XML_SetReturnNSTriplet(parser, do_nst) __XML_SetReturnNSTriplet(ExpatBase, (parser), (do_nst))

const char * __XML_ExpatVersion(__reg("a6") struct Library *)="\tjsr\t-342(a6)";
#define XML_ExpatVersion() __XML_ExpatVersion(ExpatBase)

void * __XML_ExpatVersionInfo(__reg("a6") struct Library *)="\tjsr\t-348(a6)";
#define XML_ExpatVersionInfo() __XML_ExpatVersionInfo(ExpatBase)

int __XML_ParserReset(__reg("a6") struct Library *, __reg("a0") void * parser, __reg("a1") const char * encoding)="\tjsr\t-354(a6)";
#define XML_ParserReset(parser, encoding) __XML_ParserReset(ExpatBase, (parser), (encoding))

void __XML_SetSkippedEntityHandler(__reg("a6") struct Library *, __reg("a0") void * parser, __reg("a1") void * handler)="\tjsr\t-360(a6)";
#define XML_SetSkippedEntityHandler(parser, handler) __XML_SetSkippedEntityHandler(ExpatBase, (parser), (handler))

int __XML_UseForeignDTD(__reg("a6") struct Library *, __reg("a0") void * parser, __reg("d0") ULONG useDTD)="\tjsr\t-366(a6)";
#define XML_UseForeignDTD(parser, useDTD) __XML_UseForeignDTD(ExpatBase, (parser), (useDTD))

const void * __XML_GetFeatureList(__reg("a6") struct Library *)="\tjsr\t-372(a6)";
#define XML_GetFeatureList() __XML_GetFeatureList(ExpatBase)

#endif /*  _VBCCINLINE_EXPAT_H  */
