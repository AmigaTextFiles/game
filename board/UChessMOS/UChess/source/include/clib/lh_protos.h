struct LhBuffer;

struct LhBuffer *CreateBuffer(LONG OnlyDecode);
VOID DeleteBuffer(struct LhBuffer *OldBuffer);
ULONG LhEncode(struct LhBuffer *Buffer);
ULONG LhDecode(struct LhBuffer *Buffer);
