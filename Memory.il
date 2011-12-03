.assembly extern mscorlib { }
.assembly Memory { }
.module Memory.dll

.class public abstract auto ansi sealed Memory {

	.method public static unsigned int32 SizeOf<a> () cil managed {
		.maxstack 1
		sizeof !!a
		ret
	}
	
	.method public static native int AddressOf<a> (!!a & Variable) cil managed {
		.maxstack 1
		ldarg.0
		conv.u
		ret
	}
	
	.method public static native int AddressOf<a> (!!a[] Array, int32 Index) cil managed {
		.maxstack 2
		ldarg.0
		ldarg.1
		ldelema !!a
		conv.u
		ret
	}

	.method public static !!a Read<a> (native int Source) cil managed {
		.maxstack 1
		ldarg.0
		ldobj !!a
		ret
	}
	
	.method public static void Write<a> (native int Destination, !!a Value) cil managed {
		.maxstack 2
		ldarg.0
		ldarg.1
		stobj !!a
		ret
	}
	
	.method public static native int Alloc (unsigned int32 Size) cil managed {
		.maxstack 1
		ldarg.0
		conv.u
		tail.
		call native int [mscorlib]System.Runtime.InteropServices.Marshal::AllocHGlobal (native int)
		ret
	}
	
	.method public static void Free (native int Memory) cil managed {
		.maxstack 1
		ldarg.0
		tail.
		call void [mscorlib]System.Runtime.InteropServices.Marshal::FreeHGlobal (native int)
		ret
	}
	
	.method public static void Copy (native int Source, native int Destination, unsigned int32 Size) cil managed {
		.maxstack 3
		ldarg.1
		ldarg.0
		ldarg.2
		cpblk
		ret
	}

	.method public static void Copy<a> (!!a[] SourceArray, int32 SourceOffset, native int Destination, unsigned int32 Size) cil managed {
		.maxstack 4
		.locals (!!a & pinned source)
		
		// Push destination
		ldarg.2
		
		// Pin source and push base pointer
		ldarg.0
		ldc.i4.0
		ldelema !!a
		dup
		stloc.0
		
		// Add offset
		sizeof !!a
		ldarg.1
		mul
		add
		
		// Copy
		ldarg.3
		cpblk
		ret
	}
	
	.method public static void Copy<a> (native int Source, !!a[] DestinationArray, int32 DestinationOffset, unsigned int32 Size) cil managed {
		.maxstack 3
		.locals (!!a & pinned destination)
		
		// Pin destination and push base pointer
		ldarg.1
		ldc.i4.0
		ldelema !!a
		dup
		stloc.0
		
		// Add offset
		sizeof !!a
		ldarg.2
		mul
		add
		
		// Push source
		ldarg.0
		
		// Copy
		ldarg.3
		cpblk
		ret
	}
	
	.method public static void Copy<a, b> (!!a[] SourceArray, int32 SourceOffset, !!b[] DestinationArray, int32 DestinationOffset, unsigned int32 Size) cil managed {
		.maxstack 4
		.locals (!!a & pinned source, !!b & pinned destination)
		
		// Pin destination and push base pointer
		ldarg.2
		ldc.i4.0
		ldelema !!b
		dup
		stloc.1
		
		// Add offset
		sizeof !!b
		ldarg.3
		mul
		add
		
		// Pin source and push base pointer
		ldarg.0
		ldc.i4.0
		ldelema !!a
		dup
		stloc.0
		
		// Add offset
		sizeof !!a
		ldarg.1
		mul
		add
		
		// Copy
		ldarg.s 4
		cpblk
		ret
	}
	
	.method public static void Fill (native int Destination, unsigned int8 Value, unsigned int32 Size) cil managed {
		.maxstack 3
		ldarg.0
		ldarg.1
		ldarg.2
		initblk
		ret
	}
	
	.method public static void Fill<a> (!!a[] DestinationArray, int32 DestinationOffset, unsigned int8 Value, unsigned int32 Size) cil managed {
		.maxstack 3
		.locals (!!a & pinned destination)
		
		// Pin destination and push base pointer
		ldarg.0
		ldc.i4.0
		ldelema !!a
		dup
		stloc.0
		
		// Add offset
		sizeof !!a
		ldarg.1
		mul
		add
		
		// Fill
		ldarg.2
		ldarg.3
		initblk
		ret
	}
}