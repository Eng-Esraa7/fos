
obj/user/ef_tst_sharing_4:     file format elf32-i386


Disassembly of section .text:

00800020 <_start>:
// starts us running when we are initially loaded into a new environment.
.text
.globl _start
_start:
	// See if we were started with arguments on the stack
	mov $0, %eax
  800020:	b8 00 00 00 00       	mov    $0x0,%eax
	cmpl $USTACKTOP, %esp
  800025:	81 fc 00 e0 bf ee    	cmp    $0xeebfe000,%esp
	jne args_exist
  80002b:	75 04                	jne    800031 <args_exist>

	// If not, push dummy argc/argv arguments.
	// This happens when we are loaded by the kernel,
	// because the kernel does not know about passing arguments.
	pushl $0
  80002d:	6a 00                	push   $0x0
	pushl $0
  80002f:	6a 00                	push   $0x0

00800031 <args_exist>:

args_exist:
	call libmain
  800031:	e8 57 05 00 00       	call   80058d <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
// Test the free of shared variables (create_shared_memory)
#include <inc/lib.h>

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	53                   	push   %ebx
  80003c:	83 ec 44             	sub    $0x44,%esp
	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
  80003f:	c6 45 f7 01          	movb   $0x1,-0x9(%ebp)
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  800043:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80004a:	eb 23                	jmp    80006f <_main+0x37>
		{
			if (myEnv->__uptr_pws[i].empty)
  80004c:	a1 20 30 80 00       	mov    0x803020,%eax
  800051:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800057:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80005a:	c1 e2 04             	shl    $0x4,%edx
  80005d:	01 d0                	add    %edx,%eax
  80005f:	8a 40 04             	mov    0x4(%eax),%al
  800062:	84 c0                	test   %al,%al
  800064:	74 06                	je     80006c <_main+0x34>
			{
				fullWS = 0;
  800066:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
				break;
  80006a:	eb 12                	jmp    80007e <_main+0x46>
_main(void)
{
	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  80006c:	ff 45 f0             	incl   -0x10(%ebp)
  80006f:	a1 20 30 80 00       	mov    0x803020,%eax
  800074:	8b 50 74             	mov    0x74(%eax),%edx
  800077:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80007a:	39 c2                	cmp    %eax,%edx
  80007c:	77 ce                	ja     80004c <_main+0x14>
			{
				fullWS = 0;
				break;
			}
		}
		if (fullWS) panic("Please increase the WS size");
  80007e:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  800082:	74 14                	je     800098 <_main+0x60>
  800084:	83 ec 04             	sub    $0x4,%esp
  800087:	68 80 24 80 00       	push   $0x802480
  80008c:	6a 12                	push   $0x12
  80008e:	68 9c 24 80 00       	push   $0x80249c
  800093:	e8 3a 06 00 00       	call   8006d2 <_panic>
	}

	cprintf("************************************************\n");
  800098:	83 ec 0c             	sub    $0xc,%esp
  80009b:	68 b4 24 80 00       	push   $0x8024b4
  8000a0:	e8 cf 08 00 00       	call   800974 <cprintf>
  8000a5:	83 c4 10             	add    $0x10,%esp
	cprintf("MAKE SURE to have a FRESH RUN for this test\n(i.e. don't run any program/test before it)\n");
  8000a8:	83 ec 0c             	sub    $0xc,%esp
  8000ab:	68 e8 24 80 00       	push   $0x8024e8
  8000b0:	e8 bf 08 00 00       	call   800974 <cprintf>
  8000b5:	83 c4 10             	add    $0x10,%esp
	cprintf("************************************************\n\n\n");
  8000b8:	83 ec 0c             	sub    $0xc,%esp
  8000bb:	68 44 25 80 00       	push   $0x802544
  8000c0:	e8 af 08 00 00       	call   800974 <cprintf>
  8000c5:	83 c4 10             	add    $0x10,%esp

	int Mega = 1024*1024;
  8000c8:	c7 45 ec 00 00 10 00 	movl   $0x100000,-0x14(%ebp)
	int kilo = 1024;
  8000cf:	c7 45 e8 00 04 00 00 	movl   $0x400,-0x18(%ebp)
	int envID = sys_getenvid();
  8000d6:	e8 65 1b 00 00       	call   801c40 <sys_getenvid>
  8000db:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	cprintf("STEP A: checking free of a shared object ... \n");
  8000de:	83 ec 0c             	sub    $0xc,%esp
  8000e1:	68 78 25 80 00       	push   $0x802578
  8000e6:	e8 89 08 00 00       	call   800974 <cprintf>
  8000eb:	83 c4 10             	add    $0x10,%esp
	{
		uint32 *x;
		int freeFrames = sys_calculate_free_frames() ;
  8000ee:	e8 31 1c 00 00       	call   801d24 <sys_calculate_free_frames>
  8000f3:	89 45 e0             	mov    %eax,-0x20(%ebp)
		x = smalloc("x", PAGE_SIZE, 1);
  8000f6:	83 ec 04             	sub    $0x4,%esp
  8000f9:	6a 01                	push   $0x1
  8000fb:	68 00 10 00 00       	push   $0x1000
  800100:	68 a7 25 80 00       	push   $0x8025a7
  800105:	e8 6a 19 00 00       	call   801a74 <smalloc>
  80010a:	83 c4 10             	add    $0x10,%esp
  80010d:	89 45 dc             	mov    %eax,-0x24(%ebp)
		if (x != (uint32*)USER_HEAP_START) panic("Returned address is not correct. check the setting of it and/or the updating of the shared_mem_free_address");
  800110:	81 7d dc 00 00 00 80 	cmpl   $0x80000000,-0x24(%ebp)
  800117:	74 14                	je     80012d <_main+0xf5>
  800119:	83 ec 04             	sub    $0x4,%esp
  80011c:	68 ac 25 80 00       	push   $0x8025ac
  800121:	6a 21                	push   $0x21
  800123:	68 9c 24 80 00       	push   $0x80249c
  800128:	e8 a5 05 00 00       	call   8006d2 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) !=  1+1+2) panic("Wrong allocation: make sure that you allocate the required space in the user environment and add its frames to frames_storage");
  80012d:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  800130:	e8 ef 1b 00 00       	call   801d24 <sys_calculate_free_frames>
  800135:	29 c3                	sub    %eax,%ebx
  800137:	89 d8                	mov    %ebx,%eax
  800139:	83 f8 04             	cmp    $0x4,%eax
  80013c:	74 14                	je     800152 <_main+0x11a>
  80013e:	83 ec 04             	sub    $0x4,%esp
  800141:	68 18 26 80 00       	push   $0x802618
  800146:	6a 22                	push   $0x22
  800148:	68 9c 24 80 00       	push   $0x80249c
  80014d:	e8 80 05 00 00       	call   8006d2 <_panic>

		sfree(x);
  800152:	83 ec 0c             	sub    $0xc,%esp
  800155:	ff 75 dc             	pushl  -0x24(%ebp)
  800158:	e8 57 19 00 00       	call   801ab4 <sfree>
  80015d:	83 c4 10             	add    $0x10,%esp
		if ((freeFrames - sys_calculate_free_frames()) ==  0+0+2) panic("Wrong free: make sure that you free the shared object by calling free_share_object()");
  800160:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  800163:	e8 bc 1b 00 00       	call   801d24 <sys_calculate_free_frames>
  800168:	29 c3                	sub    %eax,%ebx
  80016a:	89 d8                	mov    %ebx,%eax
  80016c:	83 f8 02             	cmp    $0x2,%eax
  80016f:	75 14                	jne    800185 <_main+0x14d>
  800171:	83 ec 04             	sub    $0x4,%esp
  800174:	68 98 26 80 00       	push   $0x802698
  800179:	6a 25                	push   $0x25
  80017b:	68 9c 24 80 00       	push   $0x80249c
  800180:	e8 4d 05 00 00       	call   8006d2 <_panic>
		else if ((freeFrames - sys_calculate_free_frames()) !=  0) panic("Wrong free: revise your freeSharedObject logic");
  800185:	e8 9a 1b 00 00       	call   801d24 <sys_calculate_free_frames>
  80018a:	89 c2                	mov    %eax,%edx
  80018c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80018f:	39 c2                	cmp    %eax,%edx
  800191:	74 14                	je     8001a7 <_main+0x16f>
  800193:	83 ec 04             	sub    $0x4,%esp
  800196:	68 f0 26 80 00       	push   $0x8026f0
  80019b:	6a 26                	push   $0x26
  80019d:	68 9c 24 80 00       	push   $0x80249c
  8001a2:	e8 2b 05 00 00       	call   8006d2 <_panic>
	}
	cprintf("Step A completed successfully!!\n\n\n");
  8001a7:	83 ec 0c             	sub    $0xc,%esp
  8001aa:	68 20 27 80 00       	push   $0x802720
  8001af:	e8 c0 07 00 00       	call   800974 <cprintf>
  8001b4:	83 c4 10             	add    $0x10,%esp


	cprintf("STEP B: checking free of 2 shared objects ... \n");
  8001b7:	83 ec 0c             	sub    $0xc,%esp
  8001ba:	68 44 27 80 00       	push   $0x802744
  8001bf:	e8 b0 07 00 00       	call   800974 <cprintf>
  8001c4:	83 c4 10             	add    $0x10,%esp
	{
		uint32 *x, *z ;
		int freeFrames = sys_calculate_free_frames() ;
  8001c7:	e8 58 1b 00 00       	call   801d24 <sys_calculate_free_frames>
  8001cc:	89 45 d8             	mov    %eax,-0x28(%ebp)
		z = smalloc("z", PAGE_SIZE, 1);
  8001cf:	83 ec 04             	sub    $0x4,%esp
  8001d2:	6a 01                	push   $0x1
  8001d4:	68 00 10 00 00       	push   $0x1000
  8001d9:	68 74 27 80 00       	push   $0x802774
  8001de:	e8 91 18 00 00       	call   801a74 <smalloc>
  8001e3:	83 c4 10             	add    $0x10,%esp
  8001e6:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		x = smalloc("x", PAGE_SIZE, 1);
  8001e9:	83 ec 04             	sub    $0x4,%esp
  8001ec:	6a 01                	push   $0x1
  8001ee:	68 00 10 00 00       	push   $0x1000
  8001f3:	68 a7 25 80 00       	push   $0x8025a7
  8001f8:	e8 77 18 00 00       	call   801a74 <smalloc>
  8001fd:	83 c4 10             	add    $0x10,%esp
  800200:	89 45 d0             	mov    %eax,-0x30(%ebp)

		if(x == NULL) panic("Wrong free: make sure that you free the shared object by calling free_share_object()");
  800203:	83 7d d0 00          	cmpl   $0x0,-0x30(%ebp)
  800207:	75 14                	jne    80021d <_main+0x1e5>
  800209:	83 ec 04             	sub    $0x4,%esp
  80020c:	68 98 26 80 00       	push   $0x802698
  800211:	6a 32                	push   $0x32
  800213:	68 9c 24 80 00       	push   $0x80249c
  800218:	e8 b5 04 00 00       	call   8006d2 <_panic>

		if ((freeFrames - sys_calculate_free_frames()) !=  2+1+4) panic("Wrong previous free: make sure that you correctly free shared object before (Step A)");
  80021d:	8b 5d d8             	mov    -0x28(%ebp),%ebx
  800220:	e8 ff 1a 00 00       	call   801d24 <sys_calculate_free_frames>
  800225:	29 c3                	sub    %eax,%ebx
  800227:	89 d8                	mov    %ebx,%eax
  800229:	83 f8 07             	cmp    $0x7,%eax
  80022c:	74 14                	je     800242 <_main+0x20a>
  80022e:	83 ec 04             	sub    $0x4,%esp
  800231:	68 78 27 80 00       	push   $0x802778
  800236:	6a 34                	push   $0x34
  800238:	68 9c 24 80 00       	push   $0x80249c
  80023d:	e8 90 04 00 00       	call   8006d2 <_panic>

		sfree(z);
  800242:	83 ec 0c             	sub    $0xc,%esp
  800245:	ff 75 d4             	pushl  -0x2c(%ebp)
  800248:	e8 67 18 00 00       	call   801ab4 <sfree>
  80024d:	83 c4 10             	add    $0x10,%esp
		if ((freeFrames - sys_calculate_free_frames()) !=  1+1+2) panic("Wrong free: check your logic");
  800250:	8b 5d d8             	mov    -0x28(%ebp),%ebx
  800253:	e8 cc 1a 00 00       	call   801d24 <sys_calculate_free_frames>
  800258:	29 c3                	sub    %eax,%ebx
  80025a:	89 d8                	mov    %ebx,%eax
  80025c:	83 f8 04             	cmp    $0x4,%eax
  80025f:	74 14                	je     800275 <_main+0x23d>
  800261:	83 ec 04             	sub    $0x4,%esp
  800264:	68 cd 27 80 00       	push   $0x8027cd
  800269:	6a 37                	push   $0x37
  80026b:	68 9c 24 80 00       	push   $0x80249c
  800270:	e8 5d 04 00 00       	call   8006d2 <_panic>

		sfree(x);
  800275:	83 ec 0c             	sub    $0xc,%esp
  800278:	ff 75 d0             	pushl  -0x30(%ebp)
  80027b:	e8 34 18 00 00       	call   801ab4 <sfree>
  800280:	83 c4 10             	add    $0x10,%esp
		if ((freeFrames - sys_calculate_free_frames()) !=  0) panic("Wrong free: check your logic");
  800283:	e8 9c 1a 00 00       	call   801d24 <sys_calculate_free_frames>
  800288:	89 c2                	mov    %eax,%edx
  80028a:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80028d:	39 c2                	cmp    %eax,%edx
  80028f:	74 14                	je     8002a5 <_main+0x26d>
  800291:	83 ec 04             	sub    $0x4,%esp
  800294:	68 cd 27 80 00       	push   $0x8027cd
  800299:	6a 3a                	push   $0x3a
  80029b:	68 9c 24 80 00       	push   $0x80249c
  8002a0:	e8 2d 04 00 00       	call   8006d2 <_panic>

	}
	cprintf("Step B completed successfully!!\n\n\n");
  8002a5:	83 ec 0c             	sub    $0xc,%esp
  8002a8:	68 ec 27 80 00       	push   $0x8027ec
  8002ad:	e8 c2 06 00 00       	call   800974 <cprintf>
  8002b2:	83 c4 10             	add    $0x10,%esp

	cprintf("STEP C: checking range of loop during free... \n");
  8002b5:	83 ec 0c             	sub    $0xc,%esp
  8002b8:	68 10 28 80 00       	push   $0x802810
  8002bd:	e8 b2 06 00 00       	call   800974 <cprintf>
  8002c2:	83 c4 10             	add    $0x10,%esp
	{
		uint32 *w, *u;
		int freeFrames = sys_calculate_free_frames() ;
  8002c5:	e8 5a 1a 00 00       	call   801d24 <sys_calculate_free_frames>
  8002ca:	89 45 cc             	mov    %eax,-0x34(%ebp)
		w = smalloc("w", 3 * PAGE_SIZE+1, 1);
  8002cd:	83 ec 04             	sub    $0x4,%esp
  8002d0:	6a 01                	push   $0x1
  8002d2:	68 01 30 00 00       	push   $0x3001
  8002d7:	68 40 28 80 00       	push   $0x802840
  8002dc:	e8 93 17 00 00       	call   801a74 <smalloc>
  8002e1:	83 c4 10             	add    $0x10,%esp
  8002e4:	89 45 c8             	mov    %eax,-0x38(%ebp)
		u = smalloc("u", PAGE_SIZE, 1);
  8002e7:	83 ec 04             	sub    $0x4,%esp
  8002ea:	6a 01                	push   $0x1
  8002ec:	68 00 10 00 00       	push   $0x1000
  8002f1:	68 42 28 80 00       	push   $0x802842
  8002f6:	e8 79 17 00 00       	call   801a74 <smalloc>
  8002fb:	83 c4 10             	add    $0x10,%esp
  8002fe:	89 45 c4             	mov    %eax,-0x3c(%ebp)

		if ((freeFrames - sys_calculate_free_frames()) != 5+1+4) panic("Wrong allocation: make sure that you allocate the required space in the user environment and add its frames to frames_storage");
  800301:	8b 5d cc             	mov    -0x34(%ebp),%ebx
  800304:	e8 1b 1a 00 00       	call   801d24 <sys_calculate_free_frames>
  800309:	29 c3                	sub    %eax,%ebx
  80030b:	89 d8                	mov    %ebx,%eax
  80030d:	83 f8 0a             	cmp    $0xa,%eax
  800310:	74 14                	je     800326 <_main+0x2ee>
  800312:	83 ec 04             	sub    $0x4,%esp
  800315:	68 18 26 80 00       	push   $0x802618
  80031a:	6a 46                	push   $0x46
  80031c:	68 9c 24 80 00       	push   $0x80249c
  800321:	e8 ac 03 00 00       	call   8006d2 <_panic>

		sfree(w);
  800326:	83 ec 0c             	sub    $0xc,%esp
  800329:	ff 75 c8             	pushl  -0x38(%ebp)
  80032c:	e8 83 17 00 00       	call   801ab4 <sfree>
  800331:	83 c4 10             	add    $0x10,%esp
		if ((freeFrames - sys_calculate_free_frames()) !=  1+1+2) panic("Wrong free: check your logic");
  800334:	8b 5d cc             	mov    -0x34(%ebp),%ebx
  800337:	e8 e8 19 00 00       	call   801d24 <sys_calculate_free_frames>
  80033c:	29 c3                	sub    %eax,%ebx
  80033e:	89 d8                	mov    %ebx,%eax
  800340:	83 f8 04             	cmp    $0x4,%eax
  800343:	74 14                	je     800359 <_main+0x321>
  800345:	83 ec 04             	sub    $0x4,%esp
  800348:	68 cd 27 80 00       	push   $0x8027cd
  80034d:	6a 49                	push   $0x49
  80034f:	68 9c 24 80 00       	push   $0x80249c
  800354:	e8 79 03 00 00       	call   8006d2 <_panic>

		uint32 *o;
		o = smalloc("o", 2 * PAGE_SIZE-1,1);
  800359:	83 ec 04             	sub    $0x4,%esp
  80035c:	6a 01                	push   $0x1
  80035e:	68 ff 1f 00 00       	push   $0x1fff
  800363:	68 44 28 80 00       	push   $0x802844
  800368:	e8 07 17 00 00       	call   801a74 <smalloc>
  80036d:	83 c4 10             	add    $0x10,%esp
  800370:	89 45 c0             	mov    %eax,-0x40(%ebp)

		if ((freeFrames - sys_calculate_free_frames()) != 3+1+4) panic("Wrong allocation: make sure that you allocate the required space in the user environment and add its frames to frames_storage");
  800373:	8b 5d cc             	mov    -0x34(%ebp),%ebx
  800376:	e8 a9 19 00 00       	call   801d24 <sys_calculate_free_frames>
  80037b:	29 c3                	sub    %eax,%ebx
  80037d:	89 d8                	mov    %ebx,%eax
  80037f:	83 f8 08             	cmp    $0x8,%eax
  800382:	74 14                	je     800398 <_main+0x360>
  800384:	83 ec 04             	sub    $0x4,%esp
  800387:	68 18 26 80 00       	push   $0x802618
  80038c:	6a 4e                	push   $0x4e
  80038e:	68 9c 24 80 00       	push   $0x80249c
  800393:	e8 3a 03 00 00       	call   8006d2 <_panic>

		sfree(o);
  800398:	83 ec 0c             	sub    $0xc,%esp
  80039b:	ff 75 c0             	pushl  -0x40(%ebp)
  80039e:	e8 11 17 00 00       	call   801ab4 <sfree>
  8003a3:	83 c4 10             	add    $0x10,%esp
		if ((freeFrames - sys_calculate_free_frames()) !=  1+1+2) panic("Wrong free: check your logic");
  8003a6:	8b 5d cc             	mov    -0x34(%ebp),%ebx
  8003a9:	e8 76 19 00 00       	call   801d24 <sys_calculate_free_frames>
  8003ae:	29 c3                	sub    %eax,%ebx
  8003b0:	89 d8                	mov    %ebx,%eax
  8003b2:	83 f8 04             	cmp    $0x4,%eax
  8003b5:	74 14                	je     8003cb <_main+0x393>
  8003b7:	83 ec 04             	sub    $0x4,%esp
  8003ba:	68 cd 27 80 00       	push   $0x8027cd
  8003bf:	6a 51                	push   $0x51
  8003c1:	68 9c 24 80 00       	push   $0x80249c
  8003c6:	e8 07 03 00 00       	call   8006d2 <_panic>

		sfree(u);
  8003cb:	83 ec 0c             	sub    $0xc,%esp
  8003ce:	ff 75 c4             	pushl  -0x3c(%ebp)
  8003d1:	e8 de 16 00 00       	call   801ab4 <sfree>
  8003d6:	83 c4 10             	add    $0x10,%esp
		if ((freeFrames - sys_calculate_free_frames()) !=  0) panic("Wrong free: check your logic");
  8003d9:	e8 46 19 00 00       	call   801d24 <sys_calculate_free_frames>
  8003de:	89 c2                	mov    %eax,%edx
  8003e0:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8003e3:	39 c2                	cmp    %eax,%edx
  8003e5:	74 14                	je     8003fb <_main+0x3c3>
  8003e7:	83 ec 04             	sub    $0x4,%esp
  8003ea:	68 cd 27 80 00       	push   $0x8027cd
  8003ef:	6a 54                	push   $0x54
  8003f1:	68 9c 24 80 00       	push   $0x80249c
  8003f6:	e8 d7 02 00 00       	call   8006d2 <_panic>


		//Checking boundaries of page tables
		freeFrames = sys_calculate_free_frames() ;
  8003fb:	e8 24 19 00 00       	call   801d24 <sys_calculate_free_frames>
  800400:	89 45 cc             	mov    %eax,-0x34(%ebp)
		w = smalloc("w", 3 * Mega - 1*kilo, 1);
  800403:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800406:	89 c2                	mov    %eax,%edx
  800408:	01 d2                	add    %edx,%edx
  80040a:	01 d0                	add    %edx,%eax
  80040c:	2b 45 e8             	sub    -0x18(%ebp),%eax
  80040f:	83 ec 04             	sub    $0x4,%esp
  800412:	6a 01                	push   $0x1
  800414:	50                   	push   %eax
  800415:	68 40 28 80 00       	push   $0x802840
  80041a:	e8 55 16 00 00       	call   801a74 <smalloc>
  80041f:	83 c4 10             	add    $0x10,%esp
  800422:	89 45 c8             	mov    %eax,-0x38(%ebp)
		u = smalloc("u", 7 * Mega - 1*kilo, 1);
  800425:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800428:	89 d0                	mov    %edx,%eax
  80042a:	01 c0                	add    %eax,%eax
  80042c:	01 d0                	add    %edx,%eax
  80042e:	01 c0                	add    %eax,%eax
  800430:	01 d0                	add    %edx,%eax
  800432:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800435:	83 ec 04             	sub    $0x4,%esp
  800438:	6a 01                	push   $0x1
  80043a:	50                   	push   %eax
  80043b:	68 42 28 80 00       	push   $0x802842
  800440:	e8 2f 16 00 00       	call   801a74 <smalloc>
  800445:	83 c4 10             	add    $0x10,%esp
  800448:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		o = smalloc("o", 2 * Mega + 1*kilo, 1);
  80044b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80044e:	01 c0                	add    %eax,%eax
  800450:	89 c2                	mov    %eax,%edx
  800452:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800455:	01 d0                	add    %edx,%eax
  800457:	83 ec 04             	sub    $0x4,%esp
  80045a:	6a 01                	push   $0x1
  80045c:	50                   	push   %eax
  80045d:	68 44 28 80 00       	push   $0x802844
  800462:	e8 0d 16 00 00       	call   801a74 <smalloc>
  800467:	83 c4 10             	add    $0x10,%esp
  80046a:	89 45 c0             	mov    %eax,-0x40(%ebp)

		if ((freeFrames - sys_calculate_free_frames()) != 3073+4+7) panic("Wrong allocation: make sure that you allocate the required space in the user environment and add its frames to frames_storage");
  80046d:	8b 5d cc             	mov    -0x34(%ebp),%ebx
  800470:	e8 af 18 00 00       	call   801d24 <sys_calculate_free_frames>
  800475:	29 c3                	sub    %eax,%ebx
  800477:	89 d8                	mov    %ebx,%eax
  800479:	3d 0c 0c 00 00       	cmp    $0xc0c,%eax
  80047e:	74 14                	je     800494 <_main+0x45c>
  800480:	83 ec 04             	sub    $0x4,%esp
  800483:	68 18 26 80 00       	push   $0x802618
  800488:	6a 5d                	push   $0x5d
  80048a:	68 9c 24 80 00       	push   $0x80249c
  80048f:	e8 3e 02 00 00       	call   8006d2 <_panic>

		sfree(o);
  800494:	83 ec 0c             	sub    $0xc,%esp
  800497:	ff 75 c0             	pushl  -0x40(%ebp)
  80049a:	e8 15 16 00 00       	call   801ab4 <sfree>
  80049f:	83 c4 10             	add    $0x10,%esp
		if ((freeFrames - sys_calculate_free_frames()) !=  2560+3+5) panic("Wrong free: check your logic");
  8004a2:	8b 5d cc             	mov    -0x34(%ebp),%ebx
  8004a5:	e8 7a 18 00 00       	call   801d24 <sys_calculate_free_frames>
  8004aa:	29 c3                	sub    %eax,%ebx
  8004ac:	89 d8                	mov    %ebx,%eax
  8004ae:	3d 08 0a 00 00       	cmp    $0xa08,%eax
  8004b3:	74 14                	je     8004c9 <_main+0x491>
  8004b5:	83 ec 04             	sub    $0x4,%esp
  8004b8:	68 cd 27 80 00       	push   $0x8027cd
  8004bd:	6a 60                	push   $0x60
  8004bf:	68 9c 24 80 00       	push   $0x80249c
  8004c4:	e8 09 02 00 00       	call   8006d2 <_panic>

		sfree(w);
  8004c9:	83 ec 0c             	sub    $0xc,%esp
  8004cc:	ff 75 c8             	pushl  -0x38(%ebp)
  8004cf:	e8 e0 15 00 00       	call   801ab4 <sfree>
  8004d4:	83 c4 10             	add    $0x10,%esp
		if ((freeFrames - sys_calculate_free_frames()) !=  1792+3+3) panic("Wrong free: check your logic");
  8004d7:	8b 5d cc             	mov    -0x34(%ebp),%ebx
  8004da:	e8 45 18 00 00       	call   801d24 <sys_calculate_free_frames>
  8004df:	29 c3                	sub    %eax,%ebx
  8004e1:	89 d8                	mov    %ebx,%eax
  8004e3:	3d 06 07 00 00       	cmp    $0x706,%eax
  8004e8:	74 14                	je     8004fe <_main+0x4c6>
  8004ea:	83 ec 04             	sub    $0x4,%esp
  8004ed:	68 cd 27 80 00       	push   $0x8027cd
  8004f2:	6a 63                	push   $0x63
  8004f4:	68 9c 24 80 00       	push   $0x80249c
  8004f9:	e8 d4 01 00 00       	call   8006d2 <_panic>

		sfree(u);
  8004fe:	83 ec 0c             	sub    $0xc,%esp
  800501:	ff 75 c4             	pushl  -0x3c(%ebp)
  800504:	e8 ab 15 00 00       	call   801ab4 <sfree>
  800509:	83 c4 10             	add    $0x10,%esp
		if ((freeFrames - sys_calculate_free_frames()) !=  0) panic("Wrong free: check your logic");
  80050c:	e8 13 18 00 00       	call   801d24 <sys_calculate_free_frames>
  800511:	89 c2                	mov    %eax,%edx
  800513:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800516:	39 c2                	cmp    %eax,%edx
  800518:	74 14                	je     80052e <_main+0x4f6>
  80051a:	83 ec 04             	sub    $0x4,%esp
  80051d:	68 cd 27 80 00       	push   $0x8027cd
  800522:	6a 66                	push   $0x66
  800524:	68 9c 24 80 00       	push   $0x80249c
  800529:	e8 a4 01 00 00       	call   8006d2 <_panic>
	}
	cprintf("Step C completed successfully!!\n\n\n");
  80052e:	83 ec 0c             	sub    $0xc,%esp
  800531:	68 48 28 80 00       	push   $0x802848
  800536:	e8 39 04 00 00       	call   800974 <cprintf>
  80053b:	83 c4 10             	add    $0x10,%esp

	cprintf("Congratulations!! Test of freeSharedObjects [4] completed successfully!!\n\n\n");
  80053e:	83 ec 0c             	sub    $0xc,%esp
  800541:	68 6c 28 80 00       	push   $0x80286c
  800546:	e8 29 04 00 00       	call   800974 <cprintf>
  80054b:	83 c4 10             	add    $0x10,%esp

	int32 parentenvID = sys_getparentenvid();
  80054e:	e8 1f 17 00 00       	call   801c72 <sys_getparentenvid>
  800553:	89 45 bc             	mov    %eax,-0x44(%ebp)
	if(parentenvID > 0)
  800556:	83 7d bc 00          	cmpl   $0x0,-0x44(%ebp)
  80055a:	7e 2b                	jle    800587 <_main+0x54f>
	{
		//Get the check-finishing counter
		int *finishedCount = NULL;
  80055c:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%ebp)
		finishedCount = sget(parentenvID, "finishedCount") ;
  800563:	83 ec 08             	sub    $0x8,%esp
  800566:	68 b8 28 80 00       	push   $0x8028b8
  80056b:	ff 75 bc             	pushl  -0x44(%ebp)
  80056e:	e8 24 15 00 00       	call   801a97 <sget>
  800573:	83 c4 10             	add    $0x10,%esp
  800576:	89 45 b8             	mov    %eax,-0x48(%ebp)
		(*finishedCount)++ ;
  800579:	8b 45 b8             	mov    -0x48(%ebp),%eax
  80057c:	8b 00                	mov    (%eax),%eax
  80057e:	8d 50 01             	lea    0x1(%eax),%edx
  800581:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800584:	89 10                	mov    %edx,(%eax)
	}
	return;
  800586:	90                   	nop
  800587:	90                   	nop
}
  800588:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80058b:	c9                   	leave  
  80058c:	c3                   	ret    

0080058d <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80058d:	55                   	push   %ebp
  80058e:	89 e5                	mov    %esp,%ebp
  800590:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800593:	e8 c1 16 00 00       	call   801c59 <sys_getenvindex>
  800598:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  80059b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80059e:	89 d0                	mov    %edx,%eax
  8005a0:	c1 e0 03             	shl    $0x3,%eax
  8005a3:	01 d0                	add    %edx,%eax
  8005a5:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8005ac:	01 c8                	add    %ecx,%eax
  8005ae:	01 c0                	add    %eax,%eax
  8005b0:	01 d0                	add    %edx,%eax
  8005b2:	01 c0                	add    %eax,%eax
  8005b4:	01 d0                	add    %edx,%eax
  8005b6:	89 c2                	mov    %eax,%edx
  8005b8:	c1 e2 05             	shl    $0x5,%edx
  8005bb:	29 c2                	sub    %eax,%edx
  8005bd:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  8005c4:	89 c2                	mov    %eax,%edx
  8005c6:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  8005cc:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8005d1:	a1 20 30 80 00       	mov    0x803020,%eax
  8005d6:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  8005dc:	84 c0                	test   %al,%al
  8005de:	74 0f                	je     8005ef <libmain+0x62>
		binaryname = myEnv->prog_name;
  8005e0:	a1 20 30 80 00       	mov    0x803020,%eax
  8005e5:	05 40 3c 01 00       	add    $0x13c40,%eax
  8005ea:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8005ef:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8005f3:	7e 0a                	jle    8005ff <libmain+0x72>
		binaryname = argv[0];
  8005f5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005f8:	8b 00                	mov    (%eax),%eax
  8005fa:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8005ff:	83 ec 08             	sub    $0x8,%esp
  800602:	ff 75 0c             	pushl  0xc(%ebp)
  800605:	ff 75 08             	pushl  0x8(%ebp)
  800608:	e8 2b fa ff ff       	call   800038 <_main>
  80060d:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800610:	e8 df 17 00 00       	call   801df4 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800615:	83 ec 0c             	sub    $0xc,%esp
  800618:	68 e0 28 80 00       	push   $0x8028e0
  80061d:	e8 52 03 00 00       	call   800974 <cprintf>
  800622:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800625:	a1 20 30 80 00       	mov    0x803020,%eax
  80062a:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  800630:	a1 20 30 80 00       	mov    0x803020,%eax
  800635:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  80063b:	83 ec 04             	sub    $0x4,%esp
  80063e:	52                   	push   %edx
  80063f:	50                   	push   %eax
  800640:	68 08 29 80 00       	push   $0x802908
  800645:	e8 2a 03 00 00       	call   800974 <cprintf>
  80064a:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  80064d:	a1 20 30 80 00       	mov    0x803020,%eax
  800652:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800658:	a1 20 30 80 00       	mov    0x803020,%eax
  80065d:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  800663:	83 ec 04             	sub    $0x4,%esp
  800666:	52                   	push   %edx
  800667:	50                   	push   %eax
  800668:	68 30 29 80 00       	push   $0x802930
  80066d:	e8 02 03 00 00       	call   800974 <cprintf>
  800672:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800675:	a1 20 30 80 00       	mov    0x803020,%eax
  80067a:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  800680:	83 ec 08             	sub    $0x8,%esp
  800683:	50                   	push   %eax
  800684:	68 71 29 80 00       	push   $0x802971
  800689:	e8 e6 02 00 00       	call   800974 <cprintf>
  80068e:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800691:	83 ec 0c             	sub    $0xc,%esp
  800694:	68 e0 28 80 00       	push   $0x8028e0
  800699:	e8 d6 02 00 00       	call   800974 <cprintf>
  80069e:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8006a1:	e8 68 17 00 00       	call   801e0e <sys_enable_interrupt>

	// exit gracefully
	exit();
  8006a6:	e8 19 00 00 00       	call   8006c4 <exit>
}
  8006ab:	90                   	nop
  8006ac:	c9                   	leave  
  8006ad:	c3                   	ret    

008006ae <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8006ae:	55                   	push   %ebp
  8006af:	89 e5                	mov    %esp,%ebp
  8006b1:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8006b4:	83 ec 0c             	sub    $0xc,%esp
  8006b7:	6a 00                	push   $0x0
  8006b9:	e8 67 15 00 00       	call   801c25 <sys_env_destroy>
  8006be:	83 c4 10             	add    $0x10,%esp
}
  8006c1:	90                   	nop
  8006c2:	c9                   	leave  
  8006c3:	c3                   	ret    

008006c4 <exit>:

void
exit(void)
{
  8006c4:	55                   	push   %ebp
  8006c5:	89 e5                	mov    %esp,%ebp
  8006c7:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8006ca:	e8 bc 15 00 00       	call   801c8b <sys_env_exit>
}
  8006cf:	90                   	nop
  8006d0:	c9                   	leave  
  8006d1:	c3                   	ret    

008006d2 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8006d2:	55                   	push   %ebp
  8006d3:	89 e5                	mov    %esp,%ebp
  8006d5:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8006d8:	8d 45 10             	lea    0x10(%ebp),%eax
  8006db:	83 c0 04             	add    $0x4,%eax
  8006de:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8006e1:	a1 18 31 80 00       	mov    0x803118,%eax
  8006e6:	85 c0                	test   %eax,%eax
  8006e8:	74 16                	je     800700 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8006ea:	a1 18 31 80 00       	mov    0x803118,%eax
  8006ef:	83 ec 08             	sub    $0x8,%esp
  8006f2:	50                   	push   %eax
  8006f3:	68 88 29 80 00       	push   $0x802988
  8006f8:	e8 77 02 00 00       	call   800974 <cprintf>
  8006fd:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800700:	a1 00 30 80 00       	mov    0x803000,%eax
  800705:	ff 75 0c             	pushl  0xc(%ebp)
  800708:	ff 75 08             	pushl  0x8(%ebp)
  80070b:	50                   	push   %eax
  80070c:	68 8d 29 80 00       	push   $0x80298d
  800711:	e8 5e 02 00 00       	call   800974 <cprintf>
  800716:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800719:	8b 45 10             	mov    0x10(%ebp),%eax
  80071c:	83 ec 08             	sub    $0x8,%esp
  80071f:	ff 75 f4             	pushl  -0xc(%ebp)
  800722:	50                   	push   %eax
  800723:	e8 e1 01 00 00       	call   800909 <vcprintf>
  800728:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80072b:	83 ec 08             	sub    $0x8,%esp
  80072e:	6a 00                	push   $0x0
  800730:	68 a9 29 80 00       	push   $0x8029a9
  800735:	e8 cf 01 00 00       	call   800909 <vcprintf>
  80073a:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80073d:	e8 82 ff ff ff       	call   8006c4 <exit>

	// should not return here
	while (1) ;
  800742:	eb fe                	jmp    800742 <_panic+0x70>

00800744 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800744:	55                   	push   %ebp
  800745:	89 e5                	mov    %esp,%ebp
  800747:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80074a:	a1 20 30 80 00       	mov    0x803020,%eax
  80074f:	8b 50 74             	mov    0x74(%eax),%edx
  800752:	8b 45 0c             	mov    0xc(%ebp),%eax
  800755:	39 c2                	cmp    %eax,%edx
  800757:	74 14                	je     80076d <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800759:	83 ec 04             	sub    $0x4,%esp
  80075c:	68 ac 29 80 00       	push   $0x8029ac
  800761:	6a 26                	push   $0x26
  800763:	68 f8 29 80 00       	push   $0x8029f8
  800768:	e8 65 ff ff ff       	call   8006d2 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80076d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800774:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80077b:	e9 b6 00 00 00       	jmp    800836 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  800780:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800783:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80078a:	8b 45 08             	mov    0x8(%ebp),%eax
  80078d:	01 d0                	add    %edx,%eax
  80078f:	8b 00                	mov    (%eax),%eax
  800791:	85 c0                	test   %eax,%eax
  800793:	75 08                	jne    80079d <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800795:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800798:	e9 96 00 00 00       	jmp    800833 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  80079d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8007a4:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8007ab:	eb 5d                	jmp    80080a <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8007ad:	a1 20 30 80 00       	mov    0x803020,%eax
  8007b2:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8007b8:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8007bb:	c1 e2 04             	shl    $0x4,%edx
  8007be:	01 d0                	add    %edx,%eax
  8007c0:	8a 40 04             	mov    0x4(%eax),%al
  8007c3:	84 c0                	test   %al,%al
  8007c5:	75 40                	jne    800807 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8007c7:	a1 20 30 80 00       	mov    0x803020,%eax
  8007cc:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8007d2:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8007d5:	c1 e2 04             	shl    $0x4,%edx
  8007d8:	01 d0                	add    %edx,%eax
  8007da:	8b 00                	mov    (%eax),%eax
  8007dc:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8007df:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8007e2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8007e7:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8007e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007ec:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8007f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f6:	01 c8                	add    %ecx,%eax
  8007f8:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8007fa:	39 c2                	cmp    %eax,%edx
  8007fc:	75 09                	jne    800807 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  8007fe:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800805:	eb 12                	jmp    800819 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800807:	ff 45 e8             	incl   -0x18(%ebp)
  80080a:	a1 20 30 80 00       	mov    0x803020,%eax
  80080f:	8b 50 74             	mov    0x74(%eax),%edx
  800812:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800815:	39 c2                	cmp    %eax,%edx
  800817:	77 94                	ja     8007ad <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800819:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80081d:	75 14                	jne    800833 <CheckWSWithoutLastIndex+0xef>
			panic(
  80081f:	83 ec 04             	sub    $0x4,%esp
  800822:	68 04 2a 80 00       	push   $0x802a04
  800827:	6a 3a                	push   $0x3a
  800829:	68 f8 29 80 00       	push   $0x8029f8
  80082e:	e8 9f fe ff ff       	call   8006d2 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800833:	ff 45 f0             	incl   -0x10(%ebp)
  800836:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800839:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80083c:	0f 8c 3e ff ff ff    	jl     800780 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800842:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800849:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800850:	eb 20                	jmp    800872 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800852:	a1 20 30 80 00       	mov    0x803020,%eax
  800857:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80085d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800860:	c1 e2 04             	shl    $0x4,%edx
  800863:	01 d0                	add    %edx,%eax
  800865:	8a 40 04             	mov    0x4(%eax),%al
  800868:	3c 01                	cmp    $0x1,%al
  80086a:	75 03                	jne    80086f <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  80086c:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80086f:	ff 45 e0             	incl   -0x20(%ebp)
  800872:	a1 20 30 80 00       	mov    0x803020,%eax
  800877:	8b 50 74             	mov    0x74(%eax),%edx
  80087a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80087d:	39 c2                	cmp    %eax,%edx
  80087f:	77 d1                	ja     800852 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800881:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800884:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800887:	74 14                	je     80089d <CheckWSWithoutLastIndex+0x159>
		panic(
  800889:	83 ec 04             	sub    $0x4,%esp
  80088c:	68 58 2a 80 00       	push   $0x802a58
  800891:	6a 44                	push   $0x44
  800893:	68 f8 29 80 00       	push   $0x8029f8
  800898:	e8 35 fe ff ff       	call   8006d2 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  80089d:	90                   	nop
  80089e:	c9                   	leave  
  80089f:	c3                   	ret    

008008a0 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8008a0:	55                   	push   %ebp
  8008a1:	89 e5                	mov    %esp,%ebp
  8008a3:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8008a6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008a9:	8b 00                	mov    (%eax),%eax
  8008ab:	8d 48 01             	lea    0x1(%eax),%ecx
  8008ae:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008b1:	89 0a                	mov    %ecx,(%edx)
  8008b3:	8b 55 08             	mov    0x8(%ebp),%edx
  8008b6:	88 d1                	mov    %dl,%cl
  8008b8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008bb:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8008bf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008c2:	8b 00                	mov    (%eax),%eax
  8008c4:	3d ff 00 00 00       	cmp    $0xff,%eax
  8008c9:	75 2c                	jne    8008f7 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8008cb:	a0 24 30 80 00       	mov    0x803024,%al
  8008d0:	0f b6 c0             	movzbl %al,%eax
  8008d3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008d6:	8b 12                	mov    (%edx),%edx
  8008d8:	89 d1                	mov    %edx,%ecx
  8008da:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008dd:	83 c2 08             	add    $0x8,%edx
  8008e0:	83 ec 04             	sub    $0x4,%esp
  8008e3:	50                   	push   %eax
  8008e4:	51                   	push   %ecx
  8008e5:	52                   	push   %edx
  8008e6:	e8 f8 12 00 00       	call   801be3 <sys_cputs>
  8008eb:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8008ee:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008f1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8008f7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008fa:	8b 40 04             	mov    0x4(%eax),%eax
  8008fd:	8d 50 01             	lea    0x1(%eax),%edx
  800900:	8b 45 0c             	mov    0xc(%ebp),%eax
  800903:	89 50 04             	mov    %edx,0x4(%eax)
}
  800906:	90                   	nop
  800907:	c9                   	leave  
  800908:	c3                   	ret    

00800909 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800909:	55                   	push   %ebp
  80090a:	89 e5                	mov    %esp,%ebp
  80090c:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800912:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800919:	00 00 00 
	b.cnt = 0;
  80091c:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800923:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800926:	ff 75 0c             	pushl  0xc(%ebp)
  800929:	ff 75 08             	pushl  0x8(%ebp)
  80092c:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800932:	50                   	push   %eax
  800933:	68 a0 08 80 00       	push   $0x8008a0
  800938:	e8 11 02 00 00       	call   800b4e <vprintfmt>
  80093d:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800940:	a0 24 30 80 00       	mov    0x803024,%al
  800945:	0f b6 c0             	movzbl %al,%eax
  800948:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80094e:	83 ec 04             	sub    $0x4,%esp
  800951:	50                   	push   %eax
  800952:	52                   	push   %edx
  800953:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800959:	83 c0 08             	add    $0x8,%eax
  80095c:	50                   	push   %eax
  80095d:	e8 81 12 00 00       	call   801be3 <sys_cputs>
  800962:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800965:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  80096c:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800972:	c9                   	leave  
  800973:	c3                   	ret    

00800974 <cprintf>:

int cprintf(const char *fmt, ...) {
  800974:	55                   	push   %ebp
  800975:	89 e5                	mov    %esp,%ebp
  800977:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80097a:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800981:	8d 45 0c             	lea    0xc(%ebp),%eax
  800984:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800987:	8b 45 08             	mov    0x8(%ebp),%eax
  80098a:	83 ec 08             	sub    $0x8,%esp
  80098d:	ff 75 f4             	pushl  -0xc(%ebp)
  800990:	50                   	push   %eax
  800991:	e8 73 ff ff ff       	call   800909 <vcprintf>
  800996:	83 c4 10             	add    $0x10,%esp
  800999:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80099c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80099f:	c9                   	leave  
  8009a0:	c3                   	ret    

008009a1 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8009a1:	55                   	push   %ebp
  8009a2:	89 e5                	mov    %esp,%ebp
  8009a4:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8009a7:	e8 48 14 00 00       	call   801df4 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8009ac:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009af:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b5:	83 ec 08             	sub    $0x8,%esp
  8009b8:	ff 75 f4             	pushl  -0xc(%ebp)
  8009bb:	50                   	push   %eax
  8009bc:	e8 48 ff ff ff       	call   800909 <vcprintf>
  8009c1:	83 c4 10             	add    $0x10,%esp
  8009c4:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8009c7:	e8 42 14 00 00       	call   801e0e <sys_enable_interrupt>
	return cnt;
  8009cc:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009cf:	c9                   	leave  
  8009d0:	c3                   	ret    

008009d1 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8009d1:	55                   	push   %ebp
  8009d2:	89 e5                	mov    %esp,%ebp
  8009d4:	53                   	push   %ebx
  8009d5:	83 ec 14             	sub    $0x14,%esp
  8009d8:	8b 45 10             	mov    0x10(%ebp),%eax
  8009db:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009de:	8b 45 14             	mov    0x14(%ebp),%eax
  8009e1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8009e4:	8b 45 18             	mov    0x18(%ebp),%eax
  8009e7:	ba 00 00 00 00       	mov    $0x0,%edx
  8009ec:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8009ef:	77 55                	ja     800a46 <printnum+0x75>
  8009f1:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8009f4:	72 05                	jb     8009fb <printnum+0x2a>
  8009f6:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8009f9:	77 4b                	ja     800a46 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8009fb:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8009fe:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800a01:	8b 45 18             	mov    0x18(%ebp),%eax
  800a04:	ba 00 00 00 00       	mov    $0x0,%edx
  800a09:	52                   	push   %edx
  800a0a:	50                   	push   %eax
  800a0b:	ff 75 f4             	pushl  -0xc(%ebp)
  800a0e:	ff 75 f0             	pushl  -0x10(%ebp)
  800a11:	e8 02 18 00 00       	call   802218 <__udivdi3>
  800a16:	83 c4 10             	add    $0x10,%esp
  800a19:	83 ec 04             	sub    $0x4,%esp
  800a1c:	ff 75 20             	pushl  0x20(%ebp)
  800a1f:	53                   	push   %ebx
  800a20:	ff 75 18             	pushl  0x18(%ebp)
  800a23:	52                   	push   %edx
  800a24:	50                   	push   %eax
  800a25:	ff 75 0c             	pushl  0xc(%ebp)
  800a28:	ff 75 08             	pushl  0x8(%ebp)
  800a2b:	e8 a1 ff ff ff       	call   8009d1 <printnum>
  800a30:	83 c4 20             	add    $0x20,%esp
  800a33:	eb 1a                	jmp    800a4f <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800a35:	83 ec 08             	sub    $0x8,%esp
  800a38:	ff 75 0c             	pushl  0xc(%ebp)
  800a3b:	ff 75 20             	pushl  0x20(%ebp)
  800a3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800a41:	ff d0                	call   *%eax
  800a43:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800a46:	ff 4d 1c             	decl   0x1c(%ebp)
  800a49:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800a4d:	7f e6                	jg     800a35 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800a4f:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800a52:	bb 00 00 00 00       	mov    $0x0,%ebx
  800a57:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a5a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a5d:	53                   	push   %ebx
  800a5e:	51                   	push   %ecx
  800a5f:	52                   	push   %edx
  800a60:	50                   	push   %eax
  800a61:	e8 c2 18 00 00       	call   802328 <__umoddi3>
  800a66:	83 c4 10             	add    $0x10,%esp
  800a69:	05 d4 2c 80 00       	add    $0x802cd4,%eax
  800a6e:	8a 00                	mov    (%eax),%al
  800a70:	0f be c0             	movsbl %al,%eax
  800a73:	83 ec 08             	sub    $0x8,%esp
  800a76:	ff 75 0c             	pushl  0xc(%ebp)
  800a79:	50                   	push   %eax
  800a7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a7d:	ff d0                	call   *%eax
  800a7f:	83 c4 10             	add    $0x10,%esp
}
  800a82:	90                   	nop
  800a83:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800a86:	c9                   	leave  
  800a87:	c3                   	ret    

00800a88 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800a88:	55                   	push   %ebp
  800a89:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800a8b:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800a8f:	7e 1c                	jle    800aad <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800a91:	8b 45 08             	mov    0x8(%ebp),%eax
  800a94:	8b 00                	mov    (%eax),%eax
  800a96:	8d 50 08             	lea    0x8(%eax),%edx
  800a99:	8b 45 08             	mov    0x8(%ebp),%eax
  800a9c:	89 10                	mov    %edx,(%eax)
  800a9e:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa1:	8b 00                	mov    (%eax),%eax
  800aa3:	83 e8 08             	sub    $0x8,%eax
  800aa6:	8b 50 04             	mov    0x4(%eax),%edx
  800aa9:	8b 00                	mov    (%eax),%eax
  800aab:	eb 40                	jmp    800aed <getuint+0x65>
	else if (lflag)
  800aad:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ab1:	74 1e                	je     800ad1 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800ab3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab6:	8b 00                	mov    (%eax),%eax
  800ab8:	8d 50 04             	lea    0x4(%eax),%edx
  800abb:	8b 45 08             	mov    0x8(%ebp),%eax
  800abe:	89 10                	mov    %edx,(%eax)
  800ac0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac3:	8b 00                	mov    (%eax),%eax
  800ac5:	83 e8 04             	sub    $0x4,%eax
  800ac8:	8b 00                	mov    (%eax),%eax
  800aca:	ba 00 00 00 00       	mov    $0x0,%edx
  800acf:	eb 1c                	jmp    800aed <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800ad1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad4:	8b 00                	mov    (%eax),%eax
  800ad6:	8d 50 04             	lea    0x4(%eax),%edx
  800ad9:	8b 45 08             	mov    0x8(%ebp),%eax
  800adc:	89 10                	mov    %edx,(%eax)
  800ade:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae1:	8b 00                	mov    (%eax),%eax
  800ae3:	83 e8 04             	sub    $0x4,%eax
  800ae6:	8b 00                	mov    (%eax),%eax
  800ae8:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800aed:	5d                   	pop    %ebp
  800aee:	c3                   	ret    

00800aef <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800aef:	55                   	push   %ebp
  800af0:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800af2:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800af6:	7e 1c                	jle    800b14 <getint+0x25>
		return va_arg(*ap, long long);
  800af8:	8b 45 08             	mov    0x8(%ebp),%eax
  800afb:	8b 00                	mov    (%eax),%eax
  800afd:	8d 50 08             	lea    0x8(%eax),%edx
  800b00:	8b 45 08             	mov    0x8(%ebp),%eax
  800b03:	89 10                	mov    %edx,(%eax)
  800b05:	8b 45 08             	mov    0x8(%ebp),%eax
  800b08:	8b 00                	mov    (%eax),%eax
  800b0a:	83 e8 08             	sub    $0x8,%eax
  800b0d:	8b 50 04             	mov    0x4(%eax),%edx
  800b10:	8b 00                	mov    (%eax),%eax
  800b12:	eb 38                	jmp    800b4c <getint+0x5d>
	else if (lflag)
  800b14:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b18:	74 1a                	je     800b34 <getint+0x45>
		return va_arg(*ap, long);
  800b1a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1d:	8b 00                	mov    (%eax),%eax
  800b1f:	8d 50 04             	lea    0x4(%eax),%edx
  800b22:	8b 45 08             	mov    0x8(%ebp),%eax
  800b25:	89 10                	mov    %edx,(%eax)
  800b27:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2a:	8b 00                	mov    (%eax),%eax
  800b2c:	83 e8 04             	sub    $0x4,%eax
  800b2f:	8b 00                	mov    (%eax),%eax
  800b31:	99                   	cltd   
  800b32:	eb 18                	jmp    800b4c <getint+0x5d>
	else
		return va_arg(*ap, int);
  800b34:	8b 45 08             	mov    0x8(%ebp),%eax
  800b37:	8b 00                	mov    (%eax),%eax
  800b39:	8d 50 04             	lea    0x4(%eax),%edx
  800b3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3f:	89 10                	mov    %edx,(%eax)
  800b41:	8b 45 08             	mov    0x8(%ebp),%eax
  800b44:	8b 00                	mov    (%eax),%eax
  800b46:	83 e8 04             	sub    $0x4,%eax
  800b49:	8b 00                	mov    (%eax),%eax
  800b4b:	99                   	cltd   
}
  800b4c:	5d                   	pop    %ebp
  800b4d:	c3                   	ret    

00800b4e <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800b4e:	55                   	push   %ebp
  800b4f:	89 e5                	mov    %esp,%ebp
  800b51:	56                   	push   %esi
  800b52:	53                   	push   %ebx
  800b53:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b56:	eb 17                	jmp    800b6f <vprintfmt+0x21>
			if (ch == '\0')
  800b58:	85 db                	test   %ebx,%ebx
  800b5a:	0f 84 af 03 00 00    	je     800f0f <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800b60:	83 ec 08             	sub    $0x8,%esp
  800b63:	ff 75 0c             	pushl  0xc(%ebp)
  800b66:	53                   	push   %ebx
  800b67:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6a:	ff d0                	call   *%eax
  800b6c:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b6f:	8b 45 10             	mov    0x10(%ebp),%eax
  800b72:	8d 50 01             	lea    0x1(%eax),%edx
  800b75:	89 55 10             	mov    %edx,0x10(%ebp)
  800b78:	8a 00                	mov    (%eax),%al
  800b7a:	0f b6 d8             	movzbl %al,%ebx
  800b7d:	83 fb 25             	cmp    $0x25,%ebx
  800b80:	75 d6                	jne    800b58 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800b82:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800b86:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800b8d:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800b94:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800b9b:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800ba2:	8b 45 10             	mov    0x10(%ebp),%eax
  800ba5:	8d 50 01             	lea    0x1(%eax),%edx
  800ba8:	89 55 10             	mov    %edx,0x10(%ebp)
  800bab:	8a 00                	mov    (%eax),%al
  800bad:	0f b6 d8             	movzbl %al,%ebx
  800bb0:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800bb3:	83 f8 55             	cmp    $0x55,%eax
  800bb6:	0f 87 2b 03 00 00    	ja     800ee7 <vprintfmt+0x399>
  800bbc:	8b 04 85 f8 2c 80 00 	mov    0x802cf8(,%eax,4),%eax
  800bc3:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800bc5:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800bc9:	eb d7                	jmp    800ba2 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800bcb:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800bcf:	eb d1                	jmp    800ba2 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800bd1:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800bd8:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800bdb:	89 d0                	mov    %edx,%eax
  800bdd:	c1 e0 02             	shl    $0x2,%eax
  800be0:	01 d0                	add    %edx,%eax
  800be2:	01 c0                	add    %eax,%eax
  800be4:	01 d8                	add    %ebx,%eax
  800be6:	83 e8 30             	sub    $0x30,%eax
  800be9:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800bec:	8b 45 10             	mov    0x10(%ebp),%eax
  800bef:	8a 00                	mov    (%eax),%al
  800bf1:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800bf4:	83 fb 2f             	cmp    $0x2f,%ebx
  800bf7:	7e 3e                	jle    800c37 <vprintfmt+0xe9>
  800bf9:	83 fb 39             	cmp    $0x39,%ebx
  800bfc:	7f 39                	jg     800c37 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800bfe:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800c01:	eb d5                	jmp    800bd8 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800c03:	8b 45 14             	mov    0x14(%ebp),%eax
  800c06:	83 c0 04             	add    $0x4,%eax
  800c09:	89 45 14             	mov    %eax,0x14(%ebp)
  800c0c:	8b 45 14             	mov    0x14(%ebp),%eax
  800c0f:	83 e8 04             	sub    $0x4,%eax
  800c12:	8b 00                	mov    (%eax),%eax
  800c14:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800c17:	eb 1f                	jmp    800c38 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800c19:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c1d:	79 83                	jns    800ba2 <vprintfmt+0x54>
				width = 0;
  800c1f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800c26:	e9 77 ff ff ff       	jmp    800ba2 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800c2b:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800c32:	e9 6b ff ff ff       	jmp    800ba2 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800c37:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800c38:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c3c:	0f 89 60 ff ff ff    	jns    800ba2 <vprintfmt+0x54>
				width = precision, precision = -1;
  800c42:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800c45:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800c48:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800c4f:	e9 4e ff ff ff       	jmp    800ba2 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800c54:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800c57:	e9 46 ff ff ff       	jmp    800ba2 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800c5c:	8b 45 14             	mov    0x14(%ebp),%eax
  800c5f:	83 c0 04             	add    $0x4,%eax
  800c62:	89 45 14             	mov    %eax,0x14(%ebp)
  800c65:	8b 45 14             	mov    0x14(%ebp),%eax
  800c68:	83 e8 04             	sub    $0x4,%eax
  800c6b:	8b 00                	mov    (%eax),%eax
  800c6d:	83 ec 08             	sub    $0x8,%esp
  800c70:	ff 75 0c             	pushl  0xc(%ebp)
  800c73:	50                   	push   %eax
  800c74:	8b 45 08             	mov    0x8(%ebp),%eax
  800c77:	ff d0                	call   *%eax
  800c79:	83 c4 10             	add    $0x10,%esp
			break;
  800c7c:	e9 89 02 00 00       	jmp    800f0a <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800c81:	8b 45 14             	mov    0x14(%ebp),%eax
  800c84:	83 c0 04             	add    $0x4,%eax
  800c87:	89 45 14             	mov    %eax,0x14(%ebp)
  800c8a:	8b 45 14             	mov    0x14(%ebp),%eax
  800c8d:	83 e8 04             	sub    $0x4,%eax
  800c90:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800c92:	85 db                	test   %ebx,%ebx
  800c94:	79 02                	jns    800c98 <vprintfmt+0x14a>
				err = -err;
  800c96:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800c98:	83 fb 64             	cmp    $0x64,%ebx
  800c9b:	7f 0b                	jg     800ca8 <vprintfmt+0x15a>
  800c9d:	8b 34 9d 40 2b 80 00 	mov    0x802b40(,%ebx,4),%esi
  800ca4:	85 f6                	test   %esi,%esi
  800ca6:	75 19                	jne    800cc1 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800ca8:	53                   	push   %ebx
  800ca9:	68 e5 2c 80 00       	push   $0x802ce5
  800cae:	ff 75 0c             	pushl  0xc(%ebp)
  800cb1:	ff 75 08             	pushl  0x8(%ebp)
  800cb4:	e8 5e 02 00 00       	call   800f17 <printfmt>
  800cb9:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800cbc:	e9 49 02 00 00       	jmp    800f0a <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800cc1:	56                   	push   %esi
  800cc2:	68 ee 2c 80 00       	push   $0x802cee
  800cc7:	ff 75 0c             	pushl  0xc(%ebp)
  800cca:	ff 75 08             	pushl  0x8(%ebp)
  800ccd:	e8 45 02 00 00       	call   800f17 <printfmt>
  800cd2:	83 c4 10             	add    $0x10,%esp
			break;
  800cd5:	e9 30 02 00 00       	jmp    800f0a <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800cda:	8b 45 14             	mov    0x14(%ebp),%eax
  800cdd:	83 c0 04             	add    $0x4,%eax
  800ce0:	89 45 14             	mov    %eax,0x14(%ebp)
  800ce3:	8b 45 14             	mov    0x14(%ebp),%eax
  800ce6:	83 e8 04             	sub    $0x4,%eax
  800ce9:	8b 30                	mov    (%eax),%esi
  800ceb:	85 f6                	test   %esi,%esi
  800ced:	75 05                	jne    800cf4 <vprintfmt+0x1a6>
				p = "(null)";
  800cef:	be f1 2c 80 00       	mov    $0x802cf1,%esi
			if (width > 0 && padc != '-')
  800cf4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800cf8:	7e 6d                	jle    800d67 <vprintfmt+0x219>
  800cfa:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800cfe:	74 67                	je     800d67 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800d00:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d03:	83 ec 08             	sub    $0x8,%esp
  800d06:	50                   	push   %eax
  800d07:	56                   	push   %esi
  800d08:	e8 0c 03 00 00       	call   801019 <strnlen>
  800d0d:	83 c4 10             	add    $0x10,%esp
  800d10:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800d13:	eb 16                	jmp    800d2b <vprintfmt+0x1dd>
					putch(padc, putdat);
  800d15:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800d19:	83 ec 08             	sub    $0x8,%esp
  800d1c:	ff 75 0c             	pushl  0xc(%ebp)
  800d1f:	50                   	push   %eax
  800d20:	8b 45 08             	mov    0x8(%ebp),%eax
  800d23:	ff d0                	call   *%eax
  800d25:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800d28:	ff 4d e4             	decl   -0x1c(%ebp)
  800d2b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d2f:	7f e4                	jg     800d15 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d31:	eb 34                	jmp    800d67 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800d33:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800d37:	74 1c                	je     800d55 <vprintfmt+0x207>
  800d39:	83 fb 1f             	cmp    $0x1f,%ebx
  800d3c:	7e 05                	jle    800d43 <vprintfmt+0x1f5>
  800d3e:	83 fb 7e             	cmp    $0x7e,%ebx
  800d41:	7e 12                	jle    800d55 <vprintfmt+0x207>
					putch('?', putdat);
  800d43:	83 ec 08             	sub    $0x8,%esp
  800d46:	ff 75 0c             	pushl  0xc(%ebp)
  800d49:	6a 3f                	push   $0x3f
  800d4b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4e:	ff d0                	call   *%eax
  800d50:	83 c4 10             	add    $0x10,%esp
  800d53:	eb 0f                	jmp    800d64 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800d55:	83 ec 08             	sub    $0x8,%esp
  800d58:	ff 75 0c             	pushl  0xc(%ebp)
  800d5b:	53                   	push   %ebx
  800d5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5f:	ff d0                	call   *%eax
  800d61:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d64:	ff 4d e4             	decl   -0x1c(%ebp)
  800d67:	89 f0                	mov    %esi,%eax
  800d69:	8d 70 01             	lea    0x1(%eax),%esi
  800d6c:	8a 00                	mov    (%eax),%al
  800d6e:	0f be d8             	movsbl %al,%ebx
  800d71:	85 db                	test   %ebx,%ebx
  800d73:	74 24                	je     800d99 <vprintfmt+0x24b>
  800d75:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800d79:	78 b8                	js     800d33 <vprintfmt+0x1e5>
  800d7b:	ff 4d e0             	decl   -0x20(%ebp)
  800d7e:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800d82:	79 af                	jns    800d33 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800d84:	eb 13                	jmp    800d99 <vprintfmt+0x24b>
				putch(' ', putdat);
  800d86:	83 ec 08             	sub    $0x8,%esp
  800d89:	ff 75 0c             	pushl  0xc(%ebp)
  800d8c:	6a 20                	push   $0x20
  800d8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d91:	ff d0                	call   *%eax
  800d93:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800d96:	ff 4d e4             	decl   -0x1c(%ebp)
  800d99:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d9d:	7f e7                	jg     800d86 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800d9f:	e9 66 01 00 00       	jmp    800f0a <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800da4:	83 ec 08             	sub    $0x8,%esp
  800da7:	ff 75 e8             	pushl  -0x18(%ebp)
  800daa:	8d 45 14             	lea    0x14(%ebp),%eax
  800dad:	50                   	push   %eax
  800dae:	e8 3c fd ff ff       	call   800aef <getint>
  800db3:	83 c4 10             	add    $0x10,%esp
  800db6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800db9:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800dbc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800dbf:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800dc2:	85 d2                	test   %edx,%edx
  800dc4:	79 23                	jns    800de9 <vprintfmt+0x29b>
				putch('-', putdat);
  800dc6:	83 ec 08             	sub    $0x8,%esp
  800dc9:	ff 75 0c             	pushl  0xc(%ebp)
  800dcc:	6a 2d                	push   $0x2d
  800dce:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd1:	ff d0                	call   *%eax
  800dd3:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800dd6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800dd9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ddc:	f7 d8                	neg    %eax
  800dde:	83 d2 00             	adc    $0x0,%edx
  800de1:	f7 da                	neg    %edx
  800de3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800de6:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800de9:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800df0:	e9 bc 00 00 00       	jmp    800eb1 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800df5:	83 ec 08             	sub    $0x8,%esp
  800df8:	ff 75 e8             	pushl  -0x18(%ebp)
  800dfb:	8d 45 14             	lea    0x14(%ebp),%eax
  800dfe:	50                   	push   %eax
  800dff:	e8 84 fc ff ff       	call   800a88 <getuint>
  800e04:	83 c4 10             	add    $0x10,%esp
  800e07:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e0a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800e0d:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e14:	e9 98 00 00 00       	jmp    800eb1 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800e19:	83 ec 08             	sub    $0x8,%esp
  800e1c:	ff 75 0c             	pushl  0xc(%ebp)
  800e1f:	6a 58                	push   $0x58
  800e21:	8b 45 08             	mov    0x8(%ebp),%eax
  800e24:	ff d0                	call   *%eax
  800e26:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e29:	83 ec 08             	sub    $0x8,%esp
  800e2c:	ff 75 0c             	pushl  0xc(%ebp)
  800e2f:	6a 58                	push   $0x58
  800e31:	8b 45 08             	mov    0x8(%ebp),%eax
  800e34:	ff d0                	call   *%eax
  800e36:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e39:	83 ec 08             	sub    $0x8,%esp
  800e3c:	ff 75 0c             	pushl  0xc(%ebp)
  800e3f:	6a 58                	push   $0x58
  800e41:	8b 45 08             	mov    0x8(%ebp),%eax
  800e44:	ff d0                	call   *%eax
  800e46:	83 c4 10             	add    $0x10,%esp
			break;
  800e49:	e9 bc 00 00 00       	jmp    800f0a <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800e4e:	83 ec 08             	sub    $0x8,%esp
  800e51:	ff 75 0c             	pushl  0xc(%ebp)
  800e54:	6a 30                	push   $0x30
  800e56:	8b 45 08             	mov    0x8(%ebp),%eax
  800e59:	ff d0                	call   *%eax
  800e5b:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800e5e:	83 ec 08             	sub    $0x8,%esp
  800e61:	ff 75 0c             	pushl  0xc(%ebp)
  800e64:	6a 78                	push   $0x78
  800e66:	8b 45 08             	mov    0x8(%ebp),%eax
  800e69:	ff d0                	call   *%eax
  800e6b:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800e6e:	8b 45 14             	mov    0x14(%ebp),%eax
  800e71:	83 c0 04             	add    $0x4,%eax
  800e74:	89 45 14             	mov    %eax,0x14(%ebp)
  800e77:	8b 45 14             	mov    0x14(%ebp),%eax
  800e7a:	83 e8 04             	sub    $0x4,%eax
  800e7d:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800e7f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e82:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800e89:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800e90:	eb 1f                	jmp    800eb1 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800e92:	83 ec 08             	sub    $0x8,%esp
  800e95:	ff 75 e8             	pushl  -0x18(%ebp)
  800e98:	8d 45 14             	lea    0x14(%ebp),%eax
  800e9b:	50                   	push   %eax
  800e9c:	e8 e7 fb ff ff       	call   800a88 <getuint>
  800ea1:	83 c4 10             	add    $0x10,%esp
  800ea4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ea7:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800eaa:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800eb1:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800eb5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800eb8:	83 ec 04             	sub    $0x4,%esp
  800ebb:	52                   	push   %edx
  800ebc:	ff 75 e4             	pushl  -0x1c(%ebp)
  800ebf:	50                   	push   %eax
  800ec0:	ff 75 f4             	pushl  -0xc(%ebp)
  800ec3:	ff 75 f0             	pushl  -0x10(%ebp)
  800ec6:	ff 75 0c             	pushl  0xc(%ebp)
  800ec9:	ff 75 08             	pushl  0x8(%ebp)
  800ecc:	e8 00 fb ff ff       	call   8009d1 <printnum>
  800ed1:	83 c4 20             	add    $0x20,%esp
			break;
  800ed4:	eb 34                	jmp    800f0a <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800ed6:	83 ec 08             	sub    $0x8,%esp
  800ed9:	ff 75 0c             	pushl  0xc(%ebp)
  800edc:	53                   	push   %ebx
  800edd:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee0:	ff d0                	call   *%eax
  800ee2:	83 c4 10             	add    $0x10,%esp
			break;
  800ee5:	eb 23                	jmp    800f0a <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800ee7:	83 ec 08             	sub    $0x8,%esp
  800eea:	ff 75 0c             	pushl  0xc(%ebp)
  800eed:	6a 25                	push   $0x25
  800eef:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef2:	ff d0                	call   *%eax
  800ef4:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800ef7:	ff 4d 10             	decl   0x10(%ebp)
  800efa:	eb 03                	jmp    800eff <vprintfmt+0x3b1>
  800efc:	ff 4d 10             	decl   0x10(%ebp)
  800eff:	8b 45 10             	mov    0x10(%ebp),%eax
  800f02:	48                   	dec    %eax
  800f03:	8a 00                	mov    (%eax),%al
  800f05:	3c 25                	cmp    $0x25,%al
  800f07:	75 f3                	jne    800efc <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800f09:	90                   	nop
		}
	}
  800f0a:	e9 47 fc ff ff       	jmp    800b56 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800f0f:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800f10:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800f13:	5b                   	pop    %ebx
  800f14:	5e                   	pop    %esi
  800f15:	5d                   	pop    %ebp
  800f16:	c3                   	ret    

00800f17 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800f17:	55                   	push   %ebp
  800f18:	89 e5                	mov    %esp,%ebp
  800f1a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800f1d:	8d 45 10             	lea    0x10(%ebp),%eax
  800f20:	83 c0 04             	add    $0x4,%eax
  800f23:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800f26:	8b 45 10             	mov    0x10(%ebp),%eax
  800f29:	ff 75 f4             	pushl  -0xc(%ebp)
  800f2c:	50                   	push   %eax
  800f2d:	ff 75 0c             	pushl  0xc(%ebp)
  800f30:	ff 75 08             	pushl  0x8(%ebp)
  800f33:	e8 16 fc ff ff       	call   800b4e <vprintfmt>
  800f38:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800f3b:	90                   	nop
  800f3c:	c9                   	leave  
  800f3d:	c3                   	ret    

00800f3e <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800f3e:	55                   	push   %ebp
  800f3f:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800f41:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f44:	8b 40 08             	mov    0x8(%eax),%eax
  800f47:	8d 50 01             	lea    0x1(%eax),%edx
  800f4a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f4d:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800f50:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f53:	8b 10                	mov    (%eax),%edx
  800f55:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f58:	8b 40 04             	mov    0x4(%eax),%eax
  800f5b:	39 c2                	cmp    %eax,%edx
  800f5d:	73 12                	jae    800f71 <sprintputch+0x33>
		*b->buf++ = ch;
  800f5f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f62:	8b 00                	mov    (%eax),%eax
  800f64:	8d 48 01             	lea    0x1(%eax),%ecx
  800f67:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f6a:	89 0a                	mov    %ecx,(%edx)
  800f6c:	8b 55 08             	mov    0x8(%ebp),%edx
  800f6f:	88 10                	mov    %dl,(%eax)
}
  800f71:	90                   	nop
  800f72:	5d                   	pop    %ebp
  800f73:	c3                   	ret    

00800f74 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800f74:	55                   	push   %ebp
  800f75:	89 e5                	mov    %esp,%ebp
  800f77:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800f7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800f80:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f83:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f86:	8b 45 08             	mov    0x8(%ebp),%eax
  800f89:	01 d0                	add    %edx,%eax
  800f8b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f8e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800f95:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800f99:	74 06                	je     800fa1 <vsnprintf+0x2d>
  800f9b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800f9f:	7f 07                	jg     800fa8 <vsnprintf+0x34>
		return -E_INVAL;
  800fa1:	b8 03 00 00 00       	mov    $0x3,%eax
  800fa6:	eb 20                	jmp    800fc8 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800fa8:	ff 75 14             	pushl  0x14(%ebp)
  800fab:	ff 75 10             	pushl  0x10(%ebp)
  800fae:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800fb1:	50                   	push   %eax
  800fb2:	68 3e 0f 80 00       	push   $0x800f3e
  800fb7:	e8 92 fb ff ff       	call   800b4e <vprintfmt>
  800fbc:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800fbf:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800fc2:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800fc5:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800fc8:	c9                   	leave  
  800fc9:	c3                   	ret    

00800fca <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800fca:	55                   	push   %ebp
  800fcb:	89 e5                	mov    %esp,%ebp
  800fcd:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800fd0:	8d 45 10             	lea    0x10(%ebp),%eax
  800fd3:	83 c0 04             	add    $0x4,%eax
  800fd6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800fd9:	8b 45 10             	mov    0x10(%ebp),%eax
  800fdc:	ff 75 f4             	pushl  -0xc(%ebp)
  800fdf:	50                   	push   %eax
  800fe0:	ff 75 0c             	pushl  0xc(%ebp)
  800fe3:	ff 75 08             	pushl  0x8(%ebp)
  800fe6:	e8 89 ff ff ff       	call   800f74 <vsnprintf>
  800feb:	83 c4 10             	add    $0x10,%esp
  800fee:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800ff1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ff4:	c9                   	leave  
  800ff5:	c3                   	ret    

00800ff6 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800ff6:	55                   	push   %ebp
  800ff7:	89 e5                	mov    %esp,%ebp
  800ff9:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800ffc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801003:	eb 06                	jmp    80100b <strlen+0x15>
		n++;
  801005:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801008:	ff 45 08             	incl   0x8(%ebp)
  80100b:	8b 45 08             	mov    0x8(%ebp),%eax
  80100e:	8a 00                	mov    (%eax),%al
  801010:	84 c0                	test   %al,%al
  801012:	75 f1                	jne    801005 <strlen+0xf>
		n++;
	return n;
  801014:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801017:	c9                   	leave  
  801018:	c3                   	ret    

00801019 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801019:	55                   	push   %ebp
  80101a:	89 e5                	mov    %esp,%ebp
  80101c:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80101f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801026:	eb 09                	jmp    801031 <strnlen+0x18>
		n++;
  801028:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80102b:	ff 45 08             	incl   0x8(%ebp)
  80102e:	ff 4d 0c             	decl   0xc(%ebp)
  801031:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801035:	74 09                	je     801040 <strnlen+0x27>
  801037:	8b 45 08             	mov    0x8(%ebp),%eax
  80103a:	8a 00                	mov    (%eax),%al
  80103c:	84 c0                	test   %al,%al
  80103e:	75 e8                	jne    801028 <strnlen+0xf>
		n++;
	return n;
  801040:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801043:	c9                   	leave  
  801044:	c3                   	ret    

00801045 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801045:	55                   	push   %ebp
  801046:	89 e5                	mov    %esp,%ebp
  801048:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  80104b:	8b 45 08             	mov    0x8(%ebp),%eax
  80104e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801051:	90                   	nop
  801052:	8b 45 08             	mov    0x8(%ebp),%eax
  801055:	8d 50 01             	lea    0x1(%eax),%edx
  801058:	89 55 08             	mov    %edx,0x8(%ebp)
  80105b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80105e:	8d 4a 01             	lea    0x1(%edx),%ecx
  801061:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801064:	8a 12                	mov    (%edx),%dl
  801066:	88 10                	mov    %dl,(%eax)
  801068:	8a 00                	mov    (%eax),%al
  80106a:	84 c0                	test   %al,%al
  80106c:	75 e4                	jne    801052 <strcpy+0xd>
		/* do nothing */;
	return ret;
  80106e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801071:	c9                   	leave  
  801072:	c3                   	ret    

00801073 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801073:	55                   	push   %ebp
  801074:	89 e5                	mov    %esp,%ebp
  801076:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801079:	8b 45 08             	mov    0x8(%ebp),%eax
  80107c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  80107f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801086:	eb 1f                	jmp    8010a7 <strncpy+0x34>
		*dst++ = *src;
  801088:	8b 45 08             	mov    0x8(%ebp),%eax
  80108b:	8d 50 01             	lea    0x1(%eax),%edx
  80108e:	89 55 08             	mov    %edx,0x8(%ebp)
  801091:	8b 55 0c             	mov    0xc(%ebp),%edx
  801094:	8a 12                	mov    (%edx),%dl
  801096:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801098:	8b 45 0c             	mov    0xc(%ebp),%eax
  80109b:	8a 00                	mov    (%eax),%al
  80109d:	84 c0                	test   %al,%al
  80109f:	74 03                	je     8010a4 <strncpy+0x31>
			src++;
  8010a1:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8010a4:	ff 45 fc             	incl   -0x4(%ebp)
  8010a7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010aa:	3b 45 10             	cmp    0x10(%ebp),%eax
  8010ad:	72 d9                	jb     801088 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8010af:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8010b2:	c9                   	leave  
  8010b3:	c3                   	ret    

008010b4 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8010b4:	55                   	push   %ebp
  8010b5:	89 e5                	mov    %esp,%ebp
  8010b7:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8010ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8010bd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8010c0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010c4:	74 30                	je     8010f6 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8010c6:	eb 16                	jmp    8010de <strlcpy+0x2a>
			*dst++ = *src++;
  8010c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8010cb:	8d 50 01             	lea    0x1(%eax),%edx
  8010ce:	89 55 08             	mov    %edx,0x8(%ebp)
  8010d1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010d4:	8d 4a 01             	lea    0x1(%edx),%ecx
  8010d7:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8010da:	8a 12                	mov    (%edx),%dl
  8010dc:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8010de:	ff 4d 10             	decl   0x10(%ebp)
  8010e1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010e5:	74 09                	je     8010f0 <strlcpy+0x3c>
  8010e7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ea:	8a 00                	mov    (%eax),%al
  8010ec:	84 c0                	test   %al,%al
  8010ee:	75 d8                	jne    8010c8 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8010f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f3:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8010f6:	8b 55 08             	mov    0x8(%ebp),%edx
  8010f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010fc:	29 c2                	sub    %eax,%edx
  8010fe:	89 d0                	mov    %edx,%eax
}
  801100:	c9                   	leave  
  801101:	c3                   	ret    

00801102 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801102:	55                   	push   %ebp
  801103:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801105:	eb 06                	jmp    80110d <strcmp+0xb>
		p++, q++;
  801107:	ff 45 08             	incl   0x8(%ebp)
  80110a:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  80110d:	8b 45 08             	mov    0x8(%ebp),%eax
  801110:	8a 00                	mov    (%eax),%al
  801112:	84 c0                	test   %al,%al
  801114:	74 0e                	je     801124 <strcmp+0x22>
  801116:	8b 45 08             	mov    0x8(%ebp),%eax
  801119:	8a 10                	mov    (%eax),%dl
  80111b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80111e:	8a 00                	mov    (%eax),%al
  801120:	38 c2                	cmp    %al,%dl
  801122:	74 e3                	je     801107 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801124:	8b 45 08             	mov    0x8(%ebp),%eax
  801127:	8a 00                	mov    (%eax),%al
  801129:	0f b6 d0             	movzbl %al,%edx
  80112c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80112f:	8a 00                	mov    (%eax),%al
  801131:	0f b6 c0             	movzbl %al,%eax
  801134:	29 c2                	sub    %eax,%edx
  801136:	89 d0                	mov    %edx,%eax
}
  801138:	5d                   	pop    %ebp
  801139:	c3                   	ret    

0080113a <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  80113a:	55                   	push   %ebp
  80113b:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  80113d:	eb 09                	jmp    801148 <strncmp+0xe>
		n--, p++, q++;
  80113f:	ff 4d 10             	decl   0x10(%ebp)
  801142:	ff 45 08             	incl   0x8(%ebp)
  801145:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801148:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80114c:	74 17                	je     801165 <strncmp+0x2b>
  80114e:	8b 45 08             	mov    0x8(%ebp),%eax
  801151:	8a 00                	mov    (%eax),%al
  801153:	84 c0                	test   %al,%al
  801155:	74 0e                	je     801165 <strncmp+0x2b>
  801157:	8b 45 08             	mov    0x8(%ebp),%eax
  80115a:	8a 10                	mov    (%eax),%dl
  80115c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80115f:	8a 00                	mov    (%eax),%al
  801161:	38 c2                	cmp    %al,%dl
  801163:	74 da                	je     80113f <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801165:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801169:	75 07                	jne    801172 <strncmp+0x38>
		return 0;
  80116b:	b8 00 00 00 00       	mov    $0x0,%eax
  801170:	eb 14                	jmp    801186 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801172:	8b 45 08             	mov    0x8(%ebp),%eax
  801175:	8a 00                	mov    (%eax),%al
  801177:	0f b6 d0             	movzbl %al,%edx
  80117a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80117d:	8a 00                	mov    (%eax),%al
  80117f:	0f b6 c0             	movzbl %al,%eax
  801182:	29 c2                	sub    %eax,%edx
  801184:	89 d0                	mov    %edx,%eax
}
  801186:	5d                   	pop    %ebp
  801187:	c3                   	ret    

00801188 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801188:	55                   	push   %ebp
  801189:	89 e5                	mov    %esp,%ebp
  80118b:	83 ec 04             	sub    $0x4,%esp
  80118e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801191:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801194:	eb 12                	jmp    8011a8 <strchr+0x20>
		if (*s == c)
  801196:	8b 45 08             	mov    0x8(%ebp),%eax
  801199:	8a 00                	mov    (%eax),%al
  80119b:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80119e:	75 05                	jne    8011a5 <strchr+0x1d>
			return (char *) s;
  8011a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a3:	eb 11                	jmp    8011b6 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8011a5:	ff 45 08             	incl   0x8(%ebp)
  8011a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ab:	8a 00                	mov    (%eax),%al
  8011ad:	84 c0                	test   %al,%al
  8011af:	75 e5                	jne    801196 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8011b1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8011b6:	c9                   	leave  
  8011b7:	c3                   	ret    

008011b8 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8011b8:	55                   	push   %ebp
  8011b9:	89 e5                	mov    %esp,%ebp
  8011bb:	83 ec 04             	sub    $0x4,%esp
  8011be:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011c1:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8011c4:	eb 0d                	jmp    8011d3 <strfind+0x1b>
		if (*s == c)
  8011c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c9:	8a 00                	mov    (%eax),%al
  8011cb:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8011ce:	74 0e                	je     8011de <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8011d0:	ff 45 08             	incl   0x8(%ebp)
  8011d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d6:	8a 00                	mov    (%eax),%al
  8011d8:	84 c0                	test   %al,%al
  8011da:	75 ea                	jne    8011c6 <strfind+0xe>
  8011dc:	eb 01                	jmp    8011df <strfind+0x27>
		if (*s == c)
			break;
  8011de:	90                   	nop
	return (char *) s;
  8011df:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8011e2:	c9                   	leave  
  8011e3:	c3                   	ret    

008011e4 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8011e4:	55                   	push   %ebp
  8011e5:	89 e5                	mov    %esp,%ebp
  8011e7:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8011ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ed:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8011f0:	8b 45 10             	mov    0x10(%ebp),%eax
  8011f3:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8011f6:	eb 0e                	jmp    801206 <memset+0x22>
		*p++ = c;
  8011f8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011fb:	8d 50 01             	lea    0x1(%eax),%edx
  8011fe:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801201:	8b 55 0c             	mov    0xc(%ebp),%edx
  801204:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801206:	ff 4d f8             	decl   -0x8(%ebp)
  801209:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  80120d:	79 e9                	jns    8011f8 <memset+0x14>
		*p++ = c;

	return v;
  80120f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801212:	c9                   	leave  
  801213:	c3                   	ret    

00801214 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801214:	55                   	push   %ebp
  801215:	89 e5                	mov    %esp,%ebp
  801217:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80121a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80121d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801220:	8b 45 08             	mov    0x8(%ebp),%eax
  801223:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801226:	eb 16                	jmp    80123e <memcpy+0x2a>
		*d++ = *s++;
  801228:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80122b:	8d 50 01             	lea    0x1(%eax),%edx
  80122e:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801231:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801234:	8d 4a 01             	lea    0x1(%edx),%ecx
  801237:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80123a:	8a 12                	mov    (%edx),%dl
  80123c:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  80123e:	8b 45 10             	mov    0x10(%ebp),%eax
  801241:	8d 50 ff             	lea    -0x1(%eax),%edx
  801244:	89 55 10             	mov    %edx,0x10(%ebp)
  801247:	85 c0                	test   %eax,%eax
  801249:	75 dd                	jne    801228 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  80124b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80124e:	c9                   	leave  
  80124f:	c3                   	ret    

00801250 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801250:	55                   	push   %ebp
  801251:	89 e5                	mov    %esp,%ebp
  801253:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801256:	8b 45 0c             	mov    0xc(%ebp),%eax
  801259:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80125c:	8b 45 08             	mov    0x8(%ebp),%eax
  80125f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801262:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801265:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801268:	73 50                	jae    8012ba <memmove+0x6a>
  80126a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80126d:	8b 45 10             	mov    0x10(%ebp),%eax
  801270:	01 d0                	add    %edx,%eax
  801272:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801275:	76 43                	jbe    8012ba <memmove+0x6a>
		s += n;
  801277:	8b 45 10             	mov    0x10(%ebp),%eax
  80127a:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  80127d:	8b 45 10             	mov    0x10(%ebp),%eax
  801280:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801283:	eb 10                	jmp    801295 <memmove+0x45>
			*--d = *--s;
  801285:	ff 4d f8             	decl   -0x8(%ebp)
  801288:	ff 4d fc             	decl   -0x4(%ebp)
  80128b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80128e:	8a 10                	mov    (%eax),%dl
  801290:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801293:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801295:	8b 45 10             	mov    0x10(%ebp),%eax
  801298:	8d 50 ff             	lea    -0x1(%eax),%edx
  80129b:	89 55 10             	mov    %edx,0x10(%ebp)
  80129e:	85 c0                	test   %eax,%eax
  8012a0:	75 e3                	jne    801285 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8012a2:	eb 23                	jmp    8012c7 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8012a4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012a7:	8d 50 01             	lea    0x1(%eax),%edx
  8012aa:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8012ad:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012b0:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012b3:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8012b6:	8a 12                	mov    (%edx),%dl
  8012b8:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8012ba:	8b 45 10             	mov    0x10(%ebp),%eax
  8012bd:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012c0:	89 55 10             	mov    %edx,0x10(%ebp)
  8012c3:	85 c0                	test   %eax,%eax
  8012c5:	75 dd                	jne    8012a4 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8012c7:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8012ca:	c9                   	leave  
  8012cb:	c3                   	ret    

008012cc <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8012cc:	55                   	push   %ebp
  8012cd:	89 e5                	mov    %esp,%ebp
  8012cf:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8012d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8012d8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012db:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8012de:	eb 2a                	jmp    80130a <memcmp+0x3e>
		if (*s1 != *s2)
  8012e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012e3:	8a 10                	mov    (%eax),%dl
  8012e5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012e8:	8a 00                	mov    (%eax),%al
  8012ea:	38 c2                	cmp    %al,%dl
  8012ec:	74 16                	je     801304 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8012ee:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012f1:	8a 00                	mov    (%eax),%al
  8012f3:	0f b6 d0             	movzbl %al,%edx
  8012f6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012f9:	8a 00                	mov    (%eax),%al
  8012fb:	0f b6 c0             	movzbl %al,%eax
  8012fe:	29 c2                	sub    %eax,%edx
  801300:	89 d0                	mov    %edx,%eax
  801302:	eb 18                	jmp    80131c <memcmp+0x50>
		s1++, s2++;
  801304:	ff 45 fc             	incl   -0x4(%ebp)
  801307:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80130a:	8b 45 10             	mov    0x10(%ebp),%eax
  80130d:	8d 50 ff             	lea    -0x1(%eax),%edx
  801310:	89 55 10             	mov    %edx,0x10(%ebp)
  801313:	85 c0                	test   %eax,%eax
  801315:	75 c9                	jne    8012e0 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801317:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80131c:	c9                   	leave  
  80131d:	c3                   	ret    

0080131e <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80131e:	55                   	push   %ebp
  80131f:	89 e5                	mov    %esp,%ebp
  801321:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801324:	8b 55 08             	mov    0x8(%ebp),%edx
  801327:	8b 45 10             	mov    0x10(%ebp),%eax
  80132a:	01 d0                	add    %edx,%eax
  80132c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80132f:	eb 15                	jmp    801346 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801331:	8b 45 08             	mov    0x8(%ebp),%eax
  801334:	8a 00                	mov    (%eax),%al
  801336:	0f b6 d0             	movzbl %al,%edx
  801339:	8b 45 0c             	mov    0xc(%ebp),%eax
  80133c:	0f b6 c0             	movzbl %al,%eax
  80133f:	39 c2                	cmp    %eax,%edx
  801341:	74 0d                	je     801350 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801343:	ff 45 08             	incl   0x8(%ebp)
  801346:	8b 45 08             	mov    0x8(%ebp),%eax
  801349:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80134c:	72 e3                	jb     801331 <memfind+0x13>
  80134e:	eb 01                	jmp    801351 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801350:	90                   	nop
	return (void *) s;
  801351:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801354:	c9                   	leave  
  801355:	c3                   	ret    

00801356 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801356:	55                   	push   %ebp
  801357:	89 e5                	mov    %esp,%ebp
  801359:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80135c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801363:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80136a:	eb 03                	jmp    80136f <strtol+0x19>
		s++;
  80136c:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80136f:	8b 45 08             	mov    0x8(%ebp),%eax
  801372:	8a 00                	mov    (%eax),%al
  801374:	3c 20                	cmp    $0x20,%al
  801376:	74 f4                	je     80136c <strtol+0x16>
  801378:	8b 45 08             	mov    0x8(%ebp),%eax
  80137b:	8a 00                	mov    (%eax),%al
  80137d:	3c 09                	cmp    $0x9,%al
  80137f:	74 eb                	je     80136c <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801381:	8b 45 08             	mov    0x8(%ebp),%eax
  801384:	8a 00                	mov    (%eax),%al
  801386:	3c 2b                	cmp    $0x2b,%al
  801388:	75 05                	jne    80138f <strtol+0x39>
		s++;
  80138a:	ff 45 08             	incl   0x8(%ebp)
  80138d:	eb 13                	jmp    8013a2 <strtol+0x4c>
	else if (*s == '-')
  80138f:	8b 45 08             	mov    0x8(%ebp),%eax
  801392:	8a 00                	mov    (%eax),%al
  801394:	3c 2d                	cmp    $0x2d,%al
  801396:	75 0a                	jne    8013a2 <strtol+0x4c>
		s++, neg = 1;
  801398:	ff 45 08             	incl   0x8(%ebp)
  80139b:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8013a2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013a6:	74 06                	je     8013ae <strtol+0x58>
  8013a8:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8013ac:	75 20                	jne    8013ce <strtol+0x78>
  8013ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b1:	8a 00                	mov    (%eax),%al
  8013b3:	3c 30                	cmp    $0x30,%al
  8013b5:	75 17                	jne    8013ce <strtol+0x78>
  8013b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ba:	40                   	inc    %eax
  8013bb:	8a 00                	mov    (%eax),%al
  8013bd:	3c 78                	cmp    $0x78,%al
  8013bf:	75 0d                	jne    8013ce <strtol+0x78>
		s += 2, base = 16;
  8013c1:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8013c5:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8013cc:	eb 28                	jmp    8013f6 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8013ce:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013d2:	75 15                	jne    8013e9 <strtol+0x93>
  8013d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d7:	8a 00                	mov    (%eax),%al
  8013d9:	3c 30                	cmp    $0x30,%al
  8013db:	75 0c                	jne    8013e9 <strtol+0x93>
		s++, base = 8;
  8013dd:	ff 45 08             	incl   0x8(%ebp)
  8013e0:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8013e7:	eb 0d                	jmp    8013f6 <strtol+0xa0>
	else if (base == 0)
  8013e9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013ed:	75 07                	jne    8013f6 <strtol+0xa0>
		base = 10;
  8013ef:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8013f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f9:	8a 00                	mov    (%eax),%al
  8013fb:	3c 2f                	cmp    $0x2f,%al
  8013fd:	7e 19                	jle    801418 <strtol+0xc2>
  8013ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801402:	8a 00                	mov    (%eax),%al
  801404:	3c 39                	cmp    $0x39,%al
  801406:	7f 10                	jg     801418 <strtol+0xc2>
			dig = *s - '0';
  801408:	8b 45 08             	mov    0x8(%ebp),%eax
  80140b:	8a 00                	mov    (%eax),%al
  80140d:	0f be c0             	movsbl %al,%eax
  801410:	83 e8 30             	sub    $0x30,%eax
  801413:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801416:	eb 42                	jmp    80145a <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801418:	8b 45 08             	mov    0x8(%ebp),%eax
  80141b:	8a 00                	mov    (%eax),%al
  80141d:	3c 60                	cmp    $0x60,%al
  80141f:	7e 19                	jle    80143a <strtol+0xe4>
  801421:	8b 45 08             	mov    0x8(%ebp),%eax
  801424:	8a 00                	mov    (%eax),%al
  801426:	3c 7a                	cmp    $0x7a,%al
  801428:	7f 10                	jg     80143a <strtol+0xe4>
			dig = *s - 'a' + 10;
  80142a:	8b 45 08             	mov    0x8(%ebp),%eax
  80142d:	8a 00                	mov    (%eax),%al
  80142f:	0f be c0             	movsbl %al,%eax
  801432:	83 e8 57             	sub    $0x57,%eax
  801435:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801438:	eb 20                	jmp    80145a <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80143a:	8b 45 08             	mov    0x8(%ebp),%eax
  80143d:	8a 00                	mov    (%eax),%al
  80143f:	3c 40                	cmp    $0x40,%al
  801441:	7e 39                	jle    80147c <strtol+0x126>
  801443:	8b 45 08             	mov    0x8(%ebp),%eax
  801446:	8a 00                	mov    (%eax),%al
  801448:	3c 5a                	cmp    $0x5a,%al
  80144a:	7f 30                	jg     80147c <strtol+0x126>
			dig = *s - 'A' + 10;
  80144c:	8b 45 08             	mov    0x8(%ebp),%eax
  80144f:	8a 00                	mov    (%eax),%al
  801451:	0f be c0             	movsbl %al,%eax
  801454:	83 e8 37             	sub    $0x37,%eax
  801457:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80145a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80145d:	3b 45 10             	cmp    0x10(%ebp),%eax
  801460:	7d 19                	jge    80147b <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801462:	ff 45 08             	incl   0x8(%ebp)
  801465:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801468:	0f af 45 10          	imul   0x10(%ebp),%eax
  80146c:	89 c2                	mov    %eax,%edx
  80146e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801471:	01 d0                	add    %edx,%eax
  801473:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801476:	e9 7b ff ff ff       	jmp    8013f6 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80147b:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80147c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801480:	74 08                	je     80148a <strtol+0x134>
		*endptr = (char *) s;
  801482:	8b 45 0c             	mov    0xc(%ebp),%eax
  801485:	8b 55 08             	mov    0x8(%ebp),%edx
  801488:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80148a:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80148e:	74 07                	je     801497 <strtol+0x141>
  801490:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801493:	f7 d8                	neg    %eax
  801495:	eb 03                	jmp    80149a <strtol+0x144>
  801497:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80149a:	c9                   	leave  
  80149b:	c3                   	ret    

0080149c <ltostr>:

void
ltostr(long value, char *str)
{
  80149c:	55                   	push   %ebp
  80149d:	89 e5                	mov    %esp,%ebp
  80149f:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8014a2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8014a9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8014b0:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8014b4:	79 13                	jns    8014c9 <ltostr+0x2d>
	{
		neg = 1;
  8014b6:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8014bd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014c0:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8014c3:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8014c6:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8014c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8014cc:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8014d1:	99                   	cltd   
  8014d2:	f7 f9                	idiv   %ecx
  8014d4:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8014d7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014da:	8d 50 01             	lea    0x1(%eax),%edx
  8014dd:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8014e0:	89 c2                	mov    %eax,%edx
  8014e2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014e5:	01 d0                	add    %edx,%eax
  8014e7:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8014ea:	83 c2 30             	add    $0x30,%edx
  8014ed:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8014ef:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8014f2:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8014f7:	f7 e9                	imul   %ecx
  8014f9:	c1 fa 02             	sar    $0x2,%edx
  8014fc:	89 c8                	mov    %ecx,%eax
  8014fe:	c1 f8 1f             	sar    $0x1f,%eax
  801501:	29 c2                	sub    %eax,%edx
  801503:	89 d0                	mov    %edx,%eax
  801505:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801508:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80150b:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801510:	f7 e9                	imul   %ecx
  801512:	c1 fa 02             	sar    $0x2,%edx
  801515:	89 c8                	mov    %ecx,%eax
  801517:	c1 f8 1f             	sar    $0x1f,%eax
  80151a:	29 c2                	sub    %eax,%edx
  80151c:	89 d0                	mov    %edx,%eax
  80151e:	c1 e0 02             	shl    $0x2,%eax
  801521:	01 d0                	add    %edx,%eax
  801523:	01 c0                	add    %eax,%eax
  801525:	29 c1                	sub    %eax,%ecx
  801527:	89 ca                	mov    %ecx,%edx
  801529:	85 d2                	test   %edx,%edx
  80152b:	75 9c                	jne    8014c9 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80152d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801534:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801537:	48                   	dec    %eax
  801538:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80153b:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80153f:	74 3d                	je     80157e <ltostr+0xe2>
		start = 1 ;
  801541:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801548:	eb 34                	jmp    80157e <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80154a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80154d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801550:	01 d0                	add    %edx,%eax
  801552:	8a 00                	mov    (%eax),%al
  801554:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801557:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80155a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80155d:	01 c2                	add    %eax,%edx
  80155f:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801562:	8b 45 0c             	mov    0xc(%ebp),%eax
  801565:	01 c8                	add    %ecx,%eax
  801567:	8a 00                	mov    (%eax),%al
  801569:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80156b:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80156e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801571:	01 c2                	add    %eax,%edx
  801573:	8a 45 eb             	mov    -0x15(%ebp),%al
  801576:	88 02                	mov    %al,(%edx)
		start++ ;
  801578:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80157b:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80157e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801581:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801584:	7c c4                	jl     80154a <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801586:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801589:	8b 45 0c             	mov    0xc(%ebp),%eax
  80158c:	01 d0                	add    %edx,%eax
  80158e:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801591:	90                   	nop
  801592:	c9                   	leave  
  801593:	c3                   	ret    

00801594 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801594:	55                   	push   %ebp
  801595:	89 e5                	mov    %esp,%ebp
  801597:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80159a:	ff 75 08             	pushl  0x8(%ebp)
  80159d:	e8 54 fa ff ff       	call   800ff6 <strlen>
  8015a2:	83 c4 04             	add    $0x4,%esp
  8015a5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8015a8:	ff 75 0c             	pushl  0xc(%ebp)
  8015ab:	e8 46 fa ff ff       	call   800ff6 <strlen>
  8015b0:	83 c4 04             	add    $0x4,%esp
  8015b3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8015b6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8015bd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8015c4:	eb 17                	jmp    8015dd <strcconcat+0x49>
		final[s] = str1[s] ;
  8015c6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015c9:	8b 45 10             	mov    0x10(%ebp),%eax
  8015cc:	01 c2                	add    %eax,%edx
  8015ce:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8015d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d4:	01 c8                	add    %ecx,%eax
  8015d6:	8a 00                	mov    (%eax),%al
  8015d8:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8015da:	ff 45 fc             	incl   -0x4(%ebp)
  8015dd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015e0:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8015e3:	7c e1                	jl     8015c6 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8015e5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8015ec:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8015f3:	eb 1f                	jmp    801614 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8015f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015f8:	8d 50 01             	lea    0x1(%eax),%edx
  8015fb:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8015fe:	89 c2                	mov    %eax,%edx
  801600:	8b 45 10             	mov    0x10(%ebp),%eax
  801603:	01 c2                	add    %eax,%edx
  801605:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801608:	8b 45 0c             	mov    0xc(%ebp),%eax
  80160b:	01 c8                	add    %ecx,%eax
  80160d:	8a 00                	mov    (%eax),%al
  80160f:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801611:	ff 45 f8             	incl   -0x8(%ebp)
  801614:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801617:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80161a:	7c d9                	jl     8015f5 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80161c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80161f:	8b 45 10             	mov    0x10(%ebp),%eax
  801622:	01 d0                	add    %edx,%eax
  801624:	c6 00 00             	movb   $0x0,(%eax)
}
  801627:	90                   	nop
  801628:	c9                   	leave  
  801629:	c3                   	ret    

0080162a <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80162a:	55                   	push   %ebp
  80162b:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80162d:	8b 45 14             	mov    0x14(%ebp),%eax
  801630:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801636:	8b 45 14             	mov    0x14(%ebp),%eax
  801639:	8b 00                	mov    (%eax),%eax
  80163b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801642:	8b 45 10             	mov    0x10(%ebp),%eax
  801645:	01 d0                	add    %edx,%eax
  801647:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80164d:	eb 0c                	jmp    80165b <strsplit+0x31>
			*string++ = 0;
  80164f:	8b 45 08             	mov    0x8(%ebp),%eax
  801652:	8d 50 01             	lea    0x1(%eax),%edx
  801655:	89 55 08             	mov    %edx,0x8(%ebp)
  801658:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80165b:	8b 45 08             	mov    0x8(%ebp),%eax
  80165e:	8a 00                	mov    (%eax),%al
  801660:	84 c0                	test   %al,%al
  801662:	74 18                	je     80167c <strsplit+0x52>
  801664:	8b 45 08             	mov    0x8(%ebp),%eax
  801667:	8a 00                	mov    (%eax),%al
  801669:	0f be c0             	movsbl %al,%eax
  80166c:	50                   	push   %eax
  80166d:	ff 75 0c             	pushl  0xc(%ebp)
  801670:	e8 13 fb ff ff       	call   801188 <strchr>
  801675:	83 c4 08             	add    $0x8,%esp
  801678:	85 c0                	test   %eax,%eax
  80167a:	75 d3                	jne    80164f <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  80167c:	8b 45 08             	mov    0x8(%ebp),%eax
  80167f:	8a 00                	mov    (%eax),%al
  801681:	84 c0                	test   %al,%al
  801683:	74 5a                	je     8016df <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801685:	8b 45 14             	mov    0x14(%ebp),%eax
  801688:	8b 00                	mov    (%eax),%eax
  80168a:	83 f8 0f             	cmp    $0xf,%eax
  80168d:	75 07                	jne    801696 <strsplit+0x6c>
		{
			return 0;
  80168f:	b8 00 00 00 00       	mov    $0x0,%eax
  801694:	eb 66                	jmp    8016fc <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801696:	8b 45 14             	mov    0x14(%ebp),%eax
  801699:	8b 00                	mov    (%eax),%eax
  80169b:	8d 48 01             	lea    0x1(%eax),%ecx
  80169e:	8b 55 14             	mov    0x14(%ebp),%edx
  8016a1:	89 0a                	mov    %ecx,(%edx)
  8016a3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016aa:	8b 45 10             	mov    0x10(%ebp),%eax
  8016ad:	01 c2                	add    %eax,%edx
  8016af:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b2:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8016b4:	eb 03                	jmp    8016b9 <strsplit+0x8f>
			string++;
  8016b6:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8016b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8016bc:	8a 00                	mov    (%eax),%al
  8016be:	84 c0                	test   %al,%al
  8016c0:	74 8b                	je     80164d <strsplit+0x23>
  8016c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c5:	8a 00                	mov    (%eax),%al
  8016c7:	0f be c0             	movsbl %al,%eax
  8016ca:	50                   	push   %eax
  8016cb:	ff 75 0c             	pushl  0xc(%ebp)
  8016ce:	e8 b5 fa ff ff       	call   801188 <strchr>
  8016d3:	83 c4 08             	add    $0x8,%esp
  8016d6:	85 c0                	test   %eax,%eax
  8016d8:	74 dc                	je     8016b6 <strsplit+0x8c>
			string++;
	}
  8016da:	e9 6e ff ff ff       	jmp    80164d <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8016df:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8016e0:	8b 45 14             	mov    0x14(%ebp),%eax
  8016e3:	8b 00                	mov    (%eax),%eax
  8016e5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016ec:	8b 45 10             	mov    0x10(%ebp),%eax
  8016ef:	01 d0                	add    %edx,%eax
  8016f1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8016f7:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8016fc:	c9                   	leave  
  8016fd:	c3                   	ret    

008016fe <malloc>:
struct page pages[(USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE];
uint32 be_space,be_address,first_empty_space,index,ad,
emp_space,find,array_size=0;
int nump,si,ind;
void* malloc(uint32 size)
{
  8016fe:	55                   	push   %ebp
  8016ff:	89 e5                	mov    %esp,%ebp
  801701:	83 ec 18             	sub    $0x18,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	//panic("malloc() is not implemented yet...!!");

	//BOOL VARIABLE COUNT FREE SPACES IN MEM
	free_mem_count=0;
  801704:	c7 05 4c 31 80 00 00 	movl   $0x0,0x80314c
  80170b:	00 00 00 
	//BOOL VARIABLE check is there suitable space or not
	find=0;
  80170e:	c7 05 48 31 80 00 00 	movl   $0x0,0x803148
  801715:	00 00 00 
	// Initialize user heap memory (1GB = 2^30)->MAX_NUM
	if(intialize_mem==0)
  801718:	a1 28 30 80 00       	mov    0x803028,%eax
  80171d:	85 c0                	test   %eax,%eax
  80171f:	75 65                	jne    801786 <malloc+0x88>
	{
		for(j=USER_HEAP_START;j<USER_HEAP_MAX;j+=PAGE_SIZE)
  801721:	c7 05 2c 31 80 00 00 	movl   $0x80000000,0x80312c
  801728:	00 00 80 
  80172b:	eb 43                	jmp    801770 <malloc+0x72>
		{
			pages[array_size].address=j; // store start address of each 4k(Page_size)
  80172d:	8b 15 2c 30 80 00    	mov    0x80302c,%edx
  801733:	a1 2c 31 80 00       	mov    0x80312c,%eax
  801738:	c1 e2 04             	shl    $0x4,%edx
  80173b:	81 c2 60 31 80 00    	add    $0x803160,%edx
  801741:	89 02                	mov    %eax,(%edx)
			pages[array_size].used=0;//not used
  801743:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801748:	c1 e0 04             	shl    $0x4,%eax
  80174b:	05 64 31 80 00       	add    $0x803164,%eax
  801750:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
			array_size+=1;
  801756:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80175b:	40                   	inc    %eax
  80175c:	a3 2c 30 80 00       	mov    %eax,0x80302c
	//BOOL VARIABLE check is there suitable space or not
	find=0;
	// Initialize user heap memory (1GB = 2^30)->MAX_NUM
	if(intialize_mem==0)
	{
		for(j=USER_HEAP_START;j<USER_HEAP_MAX;j+=PAGE_SIZE)
  801761:	a1 2c 31 80 00       	mov    0x80312c,%eax
  801766:	05 00 10 00 00       	add    $0x1000,%eax
  80176b:	a3 2c 31 80 00       	mov    %eax,0x80312c
  801770:	a1 2c 31 80 00       	mov    0x80312c,%eax
  801775:	3d ff ff ff 9f       	cmp    $0x9fffffff,%eax
  80177a:	76 b1                	jbe    80172d <malloc+0x2f>
		{
			pages[array_size].address=j; // store start address of each 4k(Page_size)
			pages[array_size].used=0;//not used
			array_size+=1;
		}
		intialize_mem=1;
  80177c:	c7 05 28 30 80 00 01 	movl   $0x1,0x803028
  801783:	00 00 00 
	}
	be_space=MAX_NUM;
  801786:	c7 05 5c 31 80 00 00 	movl   $0x40000000,0x80315c
  80178d:	00 00 40 
	//find upper limit of size and calculate num of pages with given size
	round=ROUNDUP(size/1024,4);
  801790:	c7 45 f4 04 00 00 00 	movl   $0x4,-0xc(%ebp)
  801797:	8b 45 08             	mov    0x8(%ebp),%eax
  80179a:	c1 e8 0a             	shr    $0xa,%eax
  80179d:	89 c2                	mov    %eax,%edx
  80179f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017a2:	01 d0                	add    %edx,%eax
  8017a4:	48                   	dec    %eax
  8017a5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8017a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8017ab:	ba 00 00 00 00       	mov    $0x0,%edx
  8017b0:	f7 75 f4             	divl   -0xc(%ebp)
  8017b3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8017b6:	29 d0                	sub    %edx,%eax
  8017b8:	a3 28 31 80 00       	mov    %eax,0x803128
	no_of_pages=round/4;
  8017bd:	a1 28 31 80 00       	mov    0x803128,%eax
  8017c2:	c1 e8 02             	shr    $0x2,%eax
  8017c5:	a3 60 31 a0 00       	mov    %eax,0xa03160
	// find empty spaces in user heap mem
	for(j=0;j<array_size;++j)
  8017ca:	c7 05 2c 31 80 00 00 	movl   $0x0,0x80312c
  8017d1:	00 00 00 
  8017d4:	e9 96 00 00 00       	jmp    80186f <malloc+0x171>
	{
		if(pages[j].used==0) //check empty pages
  8017d9:	a1 2c 31 80 00       	mov    0x80312c,%eax
  8017de:	c1 e0 04             	shl    $0x4,%eax
  8017e1:	05 64 31 80 00       	add    $0x803164,%eax
  8017e6:	8b 00                	mov    (%eax),%eax
  8017e8:	85 c0                	test   %eax,%eax
  8017ea:	75 2a                	jne    801816 <malloc+0x118>
		{
			//first empty space only
			if(free_mem_count==0)
  8017ec:	a1 4c 31 80 00       	mov    0x80314c,%eax
  8017f1:	85 c0                	test   %eax,%eax
  8017f3:	75 14                	jne    801809 <malloc+0x10b>
			{
				first_empty_space=pages[j].address;
  8017f5:	a1 2c 31 80 00       	mov    0x80312c,%eax
  8017fa:	c1 e0 04             	shl    $0x4,%eax
  8017fd:	05 60 31 80 00       	add    $0x803160,%eax
  801802:	8b 00                	mov    (%eax),%eax
  801804:	a3 30 31 80 00       	mov    %eax,0x803130
			}
			free_mem_count++; // increment num of free spaces
  801809:	a1 4c 31 80 00       	mov    0x80314c,%eax
  80180e:	40                   	inc    %eax
  80180f:	a3 4c 31 80 00       	mov    %eax,0x80314c
  801814:	eb 4e                	jmp    801864 <malloc+0x166>
		}
		else //pages[j].used!=0(==1)used
		{
			// best fit strategy
			emp_space=free_mem_count*PAGE_SIZE;
  801816:	a1 4c 31 80 00       	mov    0x80314c,%eax
  80181b:	c1 e0 0c             	shl    $0xc,%eax
  80181e:	a3 34 31 80 00       	mov    %eax,0x803134
			// find min space to fit given size in array
			if(be_space>emp_space&&emp_space>=size)
  801823:	8b 15 5c 31 80 00    	mov    0x80315c,%edx
  801829:	a1 34 31 80 00       	mov    0x803134,%eax
  80182e:	39 c2                	cmp    %eax,%edx
  801830:	76 28                	jbe    80185a <malloc+0x15c>
  801832:	a1 34 31 80 00       	mov    0x803134,%eax
  801837:	3b 45 08             	cmp    0x8(%ebp),%eax
  80183a:	72 1e                	jb     80185a <malloc+0x15c>
			{
				// reset min value to repeat condition to find suitable space (ms7 mosawi2 aw2kbr b shwi2)
				be_space=emp_space;
  80183c:	a1 34 31 80 00       	mov    0x803134,%eax
  801841:	a3 5c 31 80 00       	mov    %eax,0x80315c
				// set start address of empty space
				be_address=first_empty_space;
  801846:	a1 30 31 80 00       	mov    0x803130,%eax
  80184b:	a3 58 31 80 00       	mov    %eax,0x803158
				find=1;
  801850:	c7 05 48 31 80 00 01 	movl   $0x1,0x803148
  801857:	00 00 00 
			}
			free_mem_count=0;
  80185a:	c7 05 4c 31 80 00 00 	movl   $0x0,0x80314c
  801861:	00 00 00 
	be_space=MAX_NUM;
	//find upper limit of size and calculate num of pages with given size
	round=ROUNDUP(size/1024,4);
	no_of_pages=round/4;
	// find empty spaces in user heap mem
	for(j=0;j<array_size;++j)
  801864:	a1 2c 31 80 00       	mov    0x80312c,%eax
  801869:	40                   	inc    %eax
  80186a:	a3 2c 31 80 00       	mov    %eax,0x80312c
  80186f:	8b 15 2c 31 80 00    	mov    0x80312c,%edx
  801875:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80187a:	39 c2                	cmp    %eax,%edx
  80187c:	0f 82 57 ff ff ff    	jb     8017d9 <malloc+0xdb>
			}
			free_mem_count=0;
		}
	}
	// re calc new empty space
	emp_space=free_mem_count*PAGE_SIZE;
  801882:	a1 4c 31 80 00       	mov    0x80314c,%eax
  801887:	c1 e0 0c             	shl    $0xc,%eax
  80188a:	a3 34 31 80 00       	mov    %eax,0x803134
	// check if this empty space suitable to fit given size or not
	if(be_space>emp_space&&emp_space>=size)
  80188f:	8b 15 5c 31 80 00    	mov    0x80315c,%edx
  801895:	a1 34 31 80 00       	mov    0x803134,%eax
  80189a:	39 c2                	cmp    %eax,%edx
  80189c:	76 1e                	jbe    8018bc <malloc+0x1be>
  80189e:	a1 34 31 80 00       	mov    0x803134,%eax
  8018a3:	3b 45 08             	cmp    0x8(%ebp),%eax
  8018a6:	72 14                	jb     8018bc <malloc+0x1be>
	{
		find=1;
  8018a8:	c7 05 48 31 80 00 01 	movl   $0x1,0x803148
  8018af:	00 00 00 
		// set final start address of empty space
		be_address=first_empty_space;
  8018b2:	a1 30 31 80 00       	mov    0x803130,%eax
  8018b7:	a3 58 31 80 00       	mov    %eax,0x803158
	}
	if(find==0) // no suitable space found
  8018bc:	a1 48 31 80 00       	mov    0x803148,%eax
  8018c1:	85 c0                	test   %eax,%eax
  8018c3:	75 0a                	jne    8018cf <malloc+0x1d1>
	{
		return NULL;
  8018c5:	b8 00 00 00 00       	mov    $0x0,%eax
  8018ca:	e9 fa 00 00 00       	jmp    8019c9 <malloc+0x2cb>
	}
	for(j=0;j<array_size;++j)
  8018cf:	c7 05 2c 31 80 00 00 	movl   $0x0,0x80312c
  8018d6:	00 00 00 
  8018d9:	eb 2f                	jmp    80190a <malloc+0x20c>
	{
		if (pages[j].address==be_address)
  8018db:	a1 2c 31 80 00       	mov    0x80312c,%eax
  8018e0:	c1 e0 04             	shl    $0x4,%eax
  8018e3:	05 60 31 80 00       	add    $0x803160,%eax
  8018e8:	8b 10                	mov    (%eax),%edx
  8018ea:	a1 58 31 80 00       	mov    0x803158,%eax
  8018ef:	39 c2                	cmp    %eax,%edx
  8018f1:	75 0c                	jne    8018ff <malloc+0x201>
		{
			index=j;
  8018f3:	a1 2c 31 80 00       	mov    0x80312c,%eax
  8018f8:	a3 50 31 80 00       	mov    %eax,0x803150
			break;
  8018fd:	eb 1a                	jmp    801919 <malloc+0x21b>
	}
	if(find==0) // no suitable space found
	{
		return NULL;
	}
	for(j=0;j<array_size;++j)
  8018ff:	a1 2c 31 80 00       	mov    0x80312c,%eax
  801904:	40                   	inc    %eax
  801905:	a3 2c 31 80 00       	mov    %eax,0x80312c
  80190a:	8b 15 2c 31 80 00    	mov    0x80312c,%edx
  801910:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801915:	39 c2                	cmp    %eax,%edx
  801917:	72 c2                	jb     8018db <malloc+0x1dd>
			index=j;
			break;
		}
	}
	// set num of pages to address in array
	pages[index].num_of_pages=no_of_pages;
  801919:	8b 15 50 31 80 00    	mov    0x803150,%edx
  80191f:	a1 60 31 a0 00       	mov    0xa03160,%eax
  801924:	c1 e2 04             	shl    $0x4,%edx
  801927:	81 c2 68 31 80 00    	add    $0x803168,%edx
  80192d:	89 02                	mov    %eax,(%edx)
	pages[index].siize=size;
  80192f:	a1 50 31 80 00       	mov    0x803150,%eax
  801934:	c1 e0 04             	shl    $0x4,%eax
  801937:	8d 90 6c 31 80 00    	lea    0x80316c(%eax),%edx
  80193d:	8b 45 08             	mov    0x8(%ebp),%eax
  801940:	89 02                	mov    %eax,(%edx)
	ind=index;
  801942:	a1 50 31 80 00       	mov    0x803150,%eax
  801947:	a3 3c 31 80 00       	mov    %eax,0x80313c

	// loop in n to reset used value to 1 b3add l pages
	for(j=0;j<no_of_pages;++j)
  80194c:	c7 05 2c 31 80 00 00 	movl   $0x0,0x80312c
  801953:	00 00 00 
  801956:	eb 29                	jmp    801981 <malloc+0x283>
	{
		pages[index].used=1;
  801958:	a1 50 31 80 00       	mov    0x803150,%eax
  80195d:	c1 e0 04             	shl    $0x4,%eax
  801960:	05 64 31 80 00       	add    $0x803164,%eax
  801965:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
		++index;
  80196b:	a1 50 31 80 00       	mov    0x803150,%eax
  801970:	40                   	inc    %eax
  801971:	a3 50 31 80 00       	mov    %eax,0x803150
	pages[index].num_of_pages=no_of_pages;
	pages[index].siize=size;
	ind=index;

	// loop in n to reset used value to 1 b3add l pages
	for(j=0;j<no_of_pages;++j)
  801976:	a1 2c 31 80 00       	mov    0x80312c,%eax
  80197b:	40                   	inc    %eax
  80197c:	a3 2c 31 80 00       	mov    %eax,0x80312c
  801981:	8b 15 2c 31 80 00    	mov    0x80312c,%edx
  801987:	a1 60 31 a0 00       	mov    0xa03160,%eax
  80198c:	39 c2                	cmp    %eax,%edx
  80198e:	72 c8                	jb     801958 <malloc+0x25a>
	{
		pages[index].used=1;
		++index;
	}
	// Swap from user heap to kernel
	sys_allocateMem(be_address,size);
  801990:	a1 58 31 80 00       	mov    0x803158,%eax
  801995:	83 ec 08             	sub    $0x8,%esp
  801998:	ff 75 08             	pushl  0x8(%ebp)
  80199b:	50                   	push   %eax
  80199c:	e8 ea 03 00 00       	call   801d8b <sys_allocateMem>
  8019a1:	83 c4 10             	add    $0x10,%esp
	ad = be_address;
  8019a4:	a1 58 31 80 00       	mov    0x803158,%eax
  8019a9:	a3 20 31 80 00       	mov    %eax,0x803120
	si = size/2;
  8019ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8019b1:	d1 e8                	shr    %eax
  8019b3:	a3 38 31 80 00       	mov    %eax,0x803138
	nump = no_of_pages/2;
  8019b8:	a1 60 31 a0 00       	mov    0xa03160,%eax
  8019bd:	d1 e8                	shr    %eax
  8019bf:	a3 40 31 80 00       	mov    %eax,0x803140
	return (void*)be_address;
  8019c4:	a1 58 31 80 00       	mov    0x803158,%eax
	//This function should find the space of the required range
	//using the BEST FIT strategy
	//refer to the project presentation and documentation for details
	return NULL;
}
  8019c9:	c9                   	leave  
  8019ca:	c3                   	ret    

008019cb <free>:

uint32 size, maxmam_size,fif;
void free(void* virtual_address)
{
  8019cb:	55                   	push   %ebp
  8019cc:	89 e5                	mov    %esp,%ebp
  8019ce:	83 ec 28             	sub    $0x28,%esp
int index;
	//found index of virtual address
	for(int i=0;i<array_size;i++)
  8019d1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8019d8:	eb 1d                	jmp    8019f7 <free+0x2c>
	{
		if((void *)pages[i].address == virtual_address)
  8019da:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8019dd:	c1 e0 04             	shl    $0x4,%eax
  8019e0:	05 60 31 80 00       	add    $0x803160,%eax
  8019e5:	8b 00                	mov    (%eax),%eax
  8019e7:	3b 45 08             	cmp    0x8(%ebp),%eax
  8019ea:	75 08                	jne    8019f4 <free+0x29>
		{
			index = i;
  8019ec:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8019ef:	89 45 f4             	mov    %eax,-0xc(%ebp)
			break;
  8019f2:	eb 0f                	jmp    801a03 <free+0x38>
uint32 size, maxmam_size,fif;
void free(void* virtual_address)
{
int index;
	//found index of virtual address
	for(int i=0;i<array_size;i++)
  8019f4:	ff 45 f0             	incl   -0x10(%ebp)
  8019f7:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8019fa:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8019ff:	39 c2                	cmp    %eax,%edx
  801a01:	72 d7                	jb     8019da <free+0xf>
			break;
		}
	}

	//get num of pages
	int num_of_pages = pages[index].num_of_pages;
  801a03:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a06:	c1 e0 04             	shl    $0x4,%eax
  801a09:	05 68 31 80 00       	add    $0x803168,%eax
  801a0e:	8b 00                	mov    (%eax),%eax
  801a10:	89 45 e8             	mov    %eax,-0x18(%ebp)
	pages[index].num_of_pages=0;
  801a13:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a16:	c1 e0 04             	shl    $0x4,%eax
  801a19:	05 68 31 80 00       	add    $0x803168,%eax
  801a1e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	uint32 va = pages[index].address;
  801a24:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a27:	c1 e0 04             	shl    $0x4,%eax
  801a2a:	05 60 31 80 00       	add    $0x803160,%eax
  801a2f:	8b 00                	mov    (%eax),%eax
  801a31:	89 45 e4             	mov    %eax,-0x1c(%ebp)

	//set used to 0
	for(int i=0;i<num_of_pages;i++)
  801a34:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  801a3b:	eb 17                	jmp    801a54 <free+0x89>
	{
		pages[index].used=0;
  801a3d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a40:	c1 e0 04             	shl    $0x4,%eax
  801a43:	05 64 31 80 00       	add    $0x803164,%eax
  801a48:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		index++;
  801a4e:	ff 45 f4             	incl   -0xc(%ebp)
	int num_of_pages = pages[index].num_of_pages;
	pages[index].num_of_pages=0;
	uint32 va = pages[index].address;

	//set used to 0
	for(int i=0;i<num_of_pages;i++)
  801a51:	ff 45 ec             	incl   -0x14(%ebp)
  801a54:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801a57:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801a5a:	7c e1                	jl     801a3d <free+0x72>
	{
		pages[index].used=0;
		index++;
	}
	// Swap from user heap to kernel
	sys_freeMem(va, num_of_pages*PAGE_SIZE);
  801a5c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801a5f:	c1 e0 0c             	shl    $0xc,%eax
  801a62:	83 ec 08             	sub    $0x8,%esp
  801a65:	50                   	push   %eax
  801a66:	ff 75 e4             	pushl  -0x1c(%ebp)
  801a69:	e8 01 03 00 00       	call   801d6f <sys_freeMem>
  801a6e:	83 c4 10             	add    $0x10,%esp
}
  801a71:	90                   	nop
  801a72:	c9                   	leave  
  801a73:	c3                   	ret    

00801a74 <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801a74:	55                   	push   %ebp
  801a75:	89 e5                	mov    %esp,%ebp
  801a77:	83 ec 18             	sub    $0x18,%esp
  801a7a:	8b 45 10             	mov    0x10(%ebp),%eax
  801a7d:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801a80:	83 ec 04             	sub    $0x4,%esp
  801a83:	68 50 2e 80 00       	push   $0x802e50
  801a88:	68 a0 00 00 00       	push   $0xa0
  801a8d:	68 73 2e 80 00       	push   $0x802e73
  801a92:	e8 3b ec ff ff       	call   8006d2 <_panic>

00801a97 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801a97:	55                   	push   %ebp
  801a98:	89 e5                	mov    %esp,%ebp
  801a9a:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801a9d:	83 ec 04             	sub    $0x4,%esp
  801aa0:	68 50 2e 80 00       	push   $0x802e50
  801aa5:	68 a6 00 00 00       	push   $0xa6
  801aaa:	68 73 2e 80 00       	push   $0x802e73
  801aaf:	e8 1e ec ff ff       	call   8006d2 <_panic>

00801ab4 <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  801ab4:	55                   	push   %ebp
  801ab5:	89 e5                	mov    %esp,%ebp
  801ab7:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801aba:	83 ec 04             	sub    $0x4,%esp
  801abd:	68 50 2e 80 00       	push   $0x802e50
  801ac2:	68 ac 00 00 00       	push   $0xac
  801ac7:	68 73 2e 80 00       	push   $0x802e73
  801acc:	e8 01 ec ff ff       	call   8006d2 <_panic>

00801ad1 <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size)
{
  801ad1:	55                   	push   %ebp
  801ad2:	89 e5                	mov    %esp,%ebp
  801ad4:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801ad7:	83 ec 04             	sub    $0x4,%esp
  801ada:	68 50 2e 80 00       	push   $0x802e50
  801adf:	68 b1 00 00 00       	push   $0xb1
  801ae4:	68 73 2e 80 00       	push   $0x802e73
  801ae9:	e8 e4 eb ff ff       	call   8006d2 <_panic>

00801aee <expand>:
	return 0;
}

void expand(uint32 newSize)
{
  801aee:	55                   	push   %ebp
  801aef:	89 e5                	mov    %esp,%ebp
  801af1:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801af4:	83 ec 04             	sub    $0x4,%esp
  801af7:	68 50 2e 80 00       	push   $0x802e50
  801afc:	68 b7 00 00 00       	push   $0xb7
  801b01:	68 73 2e 80 00       	push   $0x802e73
  801b06:	e8 c7 eb ff ff       	call   8006d2 <_panic>

00801b0b <shrink>:
}
void shrink(uint32 newSize)
{
  801b0b:	55                   	push   %ebp
  801b0c:	89 e5                	mov    %esp,%ebp
  801b0e:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801b11:	83 ec 04             	sub    $0x4,%esp
  801b14:	68 50 2e 80 00       	push   $0x802e50
  801b19:	68 bb 00 00 00       	push   $0xbb
  801b1e:	68 73 2e 80 00       	push   $0x802e73
  801b23:	e8 aa eb ff ff       	call   8006d2 <_panic>

00801b28 <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  801b28:	55                   	push   %ebp
  801b29:	89 e5                	mov    %esp,%ebp
  801b2b:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801b2e:	83 ec 04             	sub    $0x4,%esp
  801b31:	68 50 2e 80 00       	push   $0x802e50
  801b36:	68 c0 00 00 00       	push   $0xc0
  801b3b:	68 73 2e 80 00       	push   $0x802e73
  801b40:	e8 8d eb ff ff       	call   8006d2 <_panic>

00801b45 <halfLast>:
}

void halfLast(){
  801b45:	55                   	push   %ebp
  801b46:	89 e5                	mov    %esp,%ebp
  801b48:	83 ec 18             	sub    $0x18,%esp
	for(i=array_size;i>pa/2;--i)
	{
		pages[va].used=0;
		va+=PAGE_SIZE;
	}*/
	uint32 halfAdd = ad+si;
  801b4b:	a1 20 31 80 00       	mov    0x803120,%eax
  801b50:	8b 15 38 31 80 00    	mov    0x803138,%edx
  801b56:	01 d0                	add    %edx,%eax
  801b58:	89 45 f0             	mov    %eax,-0x10(%ebp)
	ind+=nump;
  801b5b:	8b 15 3c 31 80 00    	mov    0x80313c,%edx
  801b61:	a1 40 31 80 00       	mov    0x803140,%eax
  801b66:	01 d0                	add    %edx,%eax
  801b68:	a3 3c 31 80 00       	mov    %eax,0x80313c
	for(int i=0;i<nump;i++){
  801b6d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801b74:	eb 21                	jmp    801b97 <halfLast+0x52>
		pages[ind].used=0;
  801b76:	a1 3c 31 80 00       	mov    0x80313c,%eax
  801b7b:	c1 e0 04             	shl    $0x4,%eax
  801b7e:	05 64 31 80 00       	add    $0x803164,%eax
  801b83:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		ind++;
  801b89:	a1 3c 31 80 00       	mov    0x80313c,%eax
  801b8e:	40                   	inc    %eax
  801b8f:	a3 3c 31 80 00       	mov    %eax,0x80313c
		pages[va].used=0;
		va+=PAGE_SIZE;
	}*/
	uint32 halfAdd = ad+si;
	ind+=nump;
	for(int i=0;i<nump;i++){
  801b94:	ff 45 f4             	incl   -0xc(%ebp)
  801b97:	a1 40 31 80 00       	mov    0x803140,%eax
  801b9c:	39 45 f4             	cmp    %eax,-0xc(%ebp)
  801b9f:	7c d5                	jl     801b76 <halfLast+0x31>
		pages[ind].used=0;
		ind++;
	}
	sys_freeMem(halfAdd,si);
  801ba1:	a1 38 31 80 00       	mov    0x803138,%eax
  801ba6:	83 ec 08             	sub    $0x8,%esp
  801ba9:	50                   	push   %eax
  801baa:	ff 75 f0             	pushl  -0x10(%ebp)
  801bad:	e8 bd 01 00 00       	call   801d6f <sys_freeMem>
  801bb2:	83 c4 10             	add    $0x10,%esp
	//free((void*)ad);
	//malloc(nup);
}
  801bb5:	90                   	nop
  801bb6:	c9                   	leave  
  801bb7:	c3                   	ret    

00801bb8 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801bb8:	55                   	push   %ebp
  801bb9:	89 e5                	mov    %esp,%ebp
  801bbb:	57                   	push   %edi
  801bbc:	56                   	push   %esi
  801bbd:	53                   	push   %ebx
  801bbe:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801bc1:	8b 45 08             	mov    0x8(%ebp),%eax
  801bc4:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bc7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801bca:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801bcd:	8b 7d 18             	mov    0x18(%ebp),%edi
  801bd0:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801bd3:	cd 30                	int    $0x30
  801bd5:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801bd8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801bdb:	83 c4 10             	add    $0x10,%esp
  801bde:	5b                   	pop    %ebx
  801bdf:	5e                   	pop    %esi
  801be0:	5f                   	pop    %edi
  801be1:	5d                   	pop    %ebp
  801be2:	c3                   	ret    

00801be3 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801be3:	55                   	push   %ebp
  801be4:	89 e5                	mov    %esp,%ebp
  801be6:	83 ec 04             	sub    $0x4,%esp
  801be9:	8b 45 10             	mov    0x10(%ebp),%eax
  801bec:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801bef:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801bf3:	8b 45 08             	mov    0x8(%ebp),%eax
  801bf6:	6a 00                	push   $0x0
  801bf8:	6a 00                	push   $0x0
  801bfa:	52                   	push   %edx
  801bfb:	ff 75 0c             	pushl  0xc(%ebp)
  801bfe:	50                   	push   %eax
  801bff:	6a 00                	push   $0x0
  801c01:	e8 b2 ff ff ff       	call   801bb8 <syscall>
  801c06:	83 c4 18             	add    $0x18,%esp
}
  801c09:	90                   	nop
  801c0a:	c9                   	leave  
  801c0b:	c3                   	ret    

00801c0c <sys_cgetc>:

int
sys_cgetc(void)
{
  801c0c:	55                   	push   %ebp
  801c0d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801c0f:	6a 00                	push   $0x0
  801c11:	6a 00                	push   $0x0
  801c13:	6a 00                	push   $0x0
  801c15:	6a 00                	push   $0x0
  801c17:	6a 00                	push   $0x0
  801c19:	6a 01                	push   $0x1
  801c1b:	e8 98 ff ff ff       	call   801bb8 <syscall>
  801c20:	83 c4 18             	add    $0x18,%esp
}
  801c23:	c9                   	leave  
  801c24:	c3                   	ret    

00801c25 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801c25:	55                   	push   %ebp
  801c26:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801c28:	8b 45 08             	mov    0x8(%ebp),%eax
  801c2b:	6a 00                	push   $0x0
  801c2d:	6a 00                	push   $0x0
  801c2f:	6a 00                	push   $0x0
  801c31:	6a 00                	push   $0x0
  801c33:	50                   	push   %eax
  801c34:	6a 05                	push   $0x5
  801c36:	e8 7d ff ff ff       	call   801bb8 <syscall>
  801c3b:	83 c4 18             	add    $0x18,%esp
}
  801c3e:	c9                   	leave  
  801c3f:	c3                   	ret    

00801c40 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801c40:	55                   	push   %ebp
  801c41:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801c43:	6a 00                	push   $0x0
  801c45:	6a 00                	push   $0x0
  801c47:	6a 00                	push   $0x0
  801c49:	6a 00                	push   $0x0
  801c4b:	6a 00                	push   $0x0
  801c4d:	6a 02                	push   $0x2
  801c4f:	e8 64 ff ff ff       	call   801bb8 <syscall>
  801c54:	83 c4 18             	add    $0x18,%esp
}
  801c57:	c9                   	leave  
  801c58:	c3                   	ret    

00801c59 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801c59:	55                   	push   %ebp
  801c5a:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801c5c:	6a 00                	push   $0x0
  801c5e:	6a 00                	push   $0x0
  801c60:	6a 00                	push   $0x0
  801c62:	6a 00                	push   $0x0
  801c64:	6a 00                	push   $0x0
  801c66:	6a 03                	push   $0x3
  801c68:	e8 4b ff ff ff       	call   801bb8 <syscall>
  801c6d:	83 c4 18             	add    $0x18,%esp
}
  801c70:	c9                   	leave  
  801c71:	c3                   	ret    

00801c72 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801c72:	55                   	push   %ebp
  801c73:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801c75:	6a 00                	push   $0x0
  801c77:	6a 00                	push   $0x0
  801c79:	6a 00                	push   $0x0
  801c7b:	6a 00                	push   $0x0
  801c7d:	6a 00                	push   $0x0
  801c7f:	6a 04                	push   $0x4
  801c81:	e8 32 ff ff ff       	call   801bb8 <syscall>
  801c86:	83 c4 18             	add    $0x18,%esp
}
  801c89:	c9                   	leave  
  801c8a:	c3                   	ret    

00801c8b <sys_env_exit>:


void sys_env_exit(void)
{
  801c8b:	55                   	push   %ebp
  801c8c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801c8e:	6a 00                	push   $0x0
  801c90:	6a 00                	push   $0x0
  801c92:	6a 00                	push   $0x0
  801c94:	6a 00                	push   $0x0
  801c96:	6a 00                	push   $0x0
  801c98:	6a 06                	push   $0x6
  801c9a:	e8 19 ff ff ff       	call   801bb8 <syscall>
  801c9f:	83 c4 18             	add    $0x18,%esp
}
  801ca2:	90                   	nop
  801ca3:	c9                   	leave  
  801ca4:	c3                   	ret    

00801ca5 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801ca5:	55                   	push   %ebp
  801ca6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801ca8:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cab:	8b 45 08             	mov    0x8(%ebp),%eax
  801cae:	6a 00                	push   $0x0
  801cb0:	6a 00                	push   $0x0
  801cb2:	6a 00                	push   $0x0
  801cb4:	52                   	push   %edx
  801cb5:	50                   	push   %eax
  801cb6:	6a 07                	push   $0x7
  801cb8:	e8 fb fe ff ff       	call   801bb8 <syscall>
  801cbd:	83 c4 18             	add    $0x18,%esp
}
  801cc0:	c9                   	leave  
  801cc1:	c3                   	ret    

00801cc2 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801cc2:	55                   	push   %ebp
  801cc3:	89 e5                	mov    %esp,%ebp
  801cc5:	56                   	push   %esi
  801cc6:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801cc7:	8b 75 18             	mov    0x18(%ebp),%esi
  801cca:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801ccd:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801cd0:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cd3:	8b 45 08             	mov    0x8(%ebp),%eax
  801cd6:	56                   	push   %esi
  801cd7:	53                   	push   %ebx
  801cd8:	51                   	push   %ecx
  801cd9:	52                   	push   %edx
  801cda:	50                   	push   %eax
  801cdb:	6a 08                	push   $0x8
  801cdd:	e8 d6 fe ff ff       	call   801bb8 <syscall>
  801ce2:	83 c4 18             	add    $0x18,%esp
}
  801ce5:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801ce8:	5b                   	pop    %ebx
  801ce9:	5e                   	pop    %esi
  801cea:	5d                   	pop    %ebp
  801ceb:	c3                   	ret    

00801cec <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801cec:	55                   	push   %ebp
  801ced:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801cef:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cf2:	8b 45 08             	mov    0x8(%ebp),%eax
  801cf5:	6a 00                	push   $0x0
  801cf7:	6a 00                	push   $0x0
  801cf9:	6a 00                	push   $0x0
  801cfb:	52                   	push   %edx
  801cfc:	50                   	push   %eax
  801cfd:	6a 09                	push   $0x9
  801cff:	e8 b4 fe ff ff       	call   801bb8 <syscall>
  801d04:	83 c4 18             	add    $0x18,%esp
}
  801d07:	c9                   	leave  
  801d08:	c3                   	ret    

00801d09 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801d09:	55                   	push   %ebp
  801d0a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801d0c:	6a 00                	push   $0x0
  801d0e:	6a 00                	push   $0x0
  801d10:	6a 00                	push   $0x0
  801d12:	ff 75 0c             	pushl  0xc(%ebp)
  801d15:	ff 75 08             	pushl  0x8(%ebp)
  801d18:	6a 0a                	push   $0xa
  801d1a:	e8 99 fe ff ff       	call   801bb8 <syscall>
  801d1f:	83 c4 18             	add    $0x18,%esp
}
  801d22:	c9                   	leave  
  801d23:	c3                   	ret    

00801d24 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801d24:	55                   	push   %ebp
  801d25:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801d27:	6a 00                	push   $0x0
  801d29:	6a 00                	push   $0x0
  801d2b:	6a 00                	push   $0x0
  801d2d:	6a 00                	push   $0x0
  801d2f:	6a 00                	push   $0x0
  801d31:	6a 0b                	push   $0xb
  801d33:	e8 80 fe ff ff       	call   801bb8 <syscall>
  801d38:	83 c4 18             	add    $0x18,%esp
}
  801d3b:	c9                   	leave  
  801d3c:	c3                   	ret    

00801d3d <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801d3d:	55                   	push   %ebp
  801d3e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801d40:	6a 00                	push   $0x0
  801d42:	6a 00                	push   $0x0
  801d44:	6a 00                	push   $0x0
  801d46:	6a 00                	push   $0x0
  801d48:	6a 00                	push   $0x0
  801d4a:	6a 0c                	push   $0xc
  801d4c:	e8 67 fe ff ff       	call   801bb8 <syscall>
  801d51:	83 c4 18             	add    $0x18,%esp
}
  801d54:	c9                   	leave  
  801d55:	c3                   	ret    

00801d56 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801d56:	55                   	push   %ebp
  801d57:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801d59:	6a 00                	push   $0x0
  801d5b:	6a 00                	push   $0x0
  801d5d:	6a 00                	push   $0x0
  801d5f:	6a 00                	push   $0x0
  801d61:	6a 00                	push   $0x0
  801d63:	6a 0d                	push   $0xd
  801d65:	e8 4e fe ff ff       	call   801bb8 <syscall>
  801d6a:	83 c4 18             	add    $0x18,%esp
}
  801d6d:	c9                   	leave  
  801d6e:	c3                   	ret    

00801d6f <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801d6f:	55                   	push   %ebp
  801d70:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801d72:	6a 00                	push   $0x0
  801d74:	6a 00                	push   $0x0
  801d76:	6a 00                	push   $0x0
  801d78:	ff 75 0c             	pushl  0xc(%ebp)
  801d7b:	ff 75 08             	pushl  0x8(%ebp)
  801d7e:	6a 11                	push   $0x11
  801d80:	e8 33 fe ff ff       	call   801bb8 <syscall>
  801d85:	83 c4 18             	add    $0x18,%esp
	return;
  801d88:	90                   	nop
}
  801d89:	c9                   	leave  
  801d8a:	c3                   	ret    

00801d8b <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801d8b:	55                   	push   %ebp
  801d8c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801d8e:	6a 00                	push   $0x0
  801d90:	6a 00                	push   $0x0
  801d92:	6a 00                	push   $0x0
  801d94:	ff 75 0c             	pushl  0xc(%ebp)
  801d97:	ff 75 08             	pushl  0x8(%ebp)
  801d9a:	6a 12                	push   $0x12
  801d9c:	e8 17 fe ff ff       	call   801bb8 <syscall>
  801da1:	83 c4 18             	add    $0x18,%esp
	return ;
  801da4:	90                   	nop
}
  801da5:	c9                   	leave  
  801da6:	c3                   	ret    

00801da7 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801da7:	55                   	push   %ebp
  801da8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801daa:	6a 00                	push   $0x0
  801dac:	6a 00                	push   $0x0
  801dae:	6a 00                	push   $0x0
  801db0:	6a 00                	push   $0x0
  801db2:	6a 00                	push   $0x0
  801db4:	6a 0e                	push   $0xe
  801db6:	e8 fd fd ff ff       	call   801bb8 <syscall>
  801dbb:	83 c4 18             	add    $0x18,%esp
}
  801dbe:	c9                   	leave  
  801dbf:	c3                   	ret    

00801dc0 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801dc0:	55                   	push   %ebp
  801dc1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801dc3:	6a 00                	push   $0x0
  801dc5:	6a 00                	push   $0x0
  801dc7:	6a 00                	push   $0x0
  801dc9:	6a 00                	push   $0x0
  801dcb:	ff 75 08             	pushl  0x8(%ebp)
  801dce:	6a 0f                	push   $0xf
  801dd0:	e8 e3 fd ff ff       	call   801bb8 <syscall>
  801dd5:	83 c4 18             	add    $0x18,%esp
}
  801dd8:	c9                   	leave  
  801dd9:	c3                   	ret    

00801dda <sys_scarce_memory>:

void sys_scarce_memory()
{
  801dda:	55                   	push   %ebp
  801ddb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801ddd:	6a 00                	push   $0x0
  801ddf:	6a 00                	push   $0x0
  801de1:	6a 00                	push   $0x0
  801de3:	6a 00                	push   $0x0
  801de5:	6a 00                	push   $0x0
  801de7:	6a 10                	push   $0x10
  801de9:	e8 ca fd ff ff       	call   801bb8 <syscall>
  801dee:	83 c4 18             	add    $0x18,%esp
}
  801df1:	90                   	nop
  801df2:	c9                   	leave  
  801df3:	c3                   	ret    

00801df4 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801df4:	55                   	push   %ebp
  801df5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801df7:	6a 00                	push   $0x0
  801df9:	6a 00                	push   $0x0
  801dfb:	6a 00                	push   $0x0
  801dfd:	6a 00                	push   $0x0
  801dff:	6a 00                	push   $0x0
  801e01:	6a 14                	push   $0x14
  801e03:	e8 b0 fd ff ff       	call   801bb8 <syscall>
  801e08:	83 c4 18             	add    $0x18,%esp
}
  801e0b:	90                   	nop
  801e0c:	c9                   	leave  
  801e0d:	c3                   	ret    

00801e0e <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801e0e:	55                   	push   %ebp
  801e0f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801e11:	6a 00                	push   $0x0
  801e13:	6a 00                	push   $0x0
  801e15:	6a 00                	push   $0x0
  801e17:	6a 00                	push   $0x0
  801e19:	6a 00                	push   $0x0
  801e1b:	6a 15                	push   $0x15
  801e1d:	e8 96 fd ff ff       	call   801bb8 <syscall>
  801e22:	83 c4 18             	add    $0x18,%esp
}
  801e25:	90                   	nop
  801e26:	c9                   	leave  
  801e27:	c3                   	ret    

00801e28 <sys_cputc>:


void
sys_cputc(const char c)
{
  801e28:	55                   	push   %ebp
  801e29:	89 e5                	mov    %esp,%ebp
  801e2b:	83 ec 04             	sub    $0x4,%esp
  801e2e:	8b 45 08             	mov    0x8(%ebp),%eax
  801e31:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801e34:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801e38:	6a 00                	push   $0x0
  801e3a:	6a 00                	push   $0x0
  801e3c:	6a 00                	push   $0x0
  801e3e:	6a 00                	push   $0x0
  801e40:	50                   	push   %eax
  801e41:	6a 16                	push   $0x16
  801e43:	e8 70 fd ff ff       	call   801bb8 <syscall>
  801e48:	83 c4 18             	add    $0x18,%esp
}
  801e4b:	90                   	nop
  801e4c:	c9                   	leave  
  801e4d:	c3                   	ret    

00801e4e <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801e4e:	55                   	push   %ebp
  801e4f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801e51:	6a 00                	push   $0x0
  801e53:	6a 00                	push   $0x0
  801e55:	6a 00                	push   $0x0
  801e57:	6a 00                	push   $0x0
  801e59:	6a 00                	push   $0x0
  801e5b:	6a 17                	push   $0x17
  801e5d:	e8 56 fd ff ff       	call   801bb8 <syscall>
  801e62:	83 c4 18             	add    $0x18,%esp
}
  801e65:	90                   	nop
  801e66:	c9                   	leave  
  801e67:	c3                   	ret    

00801e68 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801e68:	55                   	push   %ebp
  801e69:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801e6b:	8b 45 08             	mov    0x8(%ebp),%eax
  801e6e:	6a 00                	push   $0x0
  801e70:	6a 00                	push   $0x0
  801e72:	6a 00                	push   $0x0
  801e74:	ff 75 0c             	pushl  0xc(%ebp)
  801e77:	50                   	push   %eax
  801e78:	6a 18                	push   $0x18
  801e7a:	e8 39 fd ff ff       	call   801bb8 <syscall>
  801e7f:	83 c4 18             	add    $0x18,%esp
}
  801e82:	c9                   	leave  
  801e83:	c3                   	ret    

00801e84 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801e84:	55                   	push   %ebp
  801e85:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801e87:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e8a:	8b 45 08             	mov    0x8(%ebp),%eax
  801e8d:	6a 00                	push   $0x0
  801e8f:	6a 00                	push   $0x0
  801e91:	6a 00                	push   $0x0
  801e93:	52                   	push   %edx
  801e94:	50                   	push   %eax
  801e95:	6a 1b                	push   $0x1b
  801e97:	e8 1c fd ff ff       	call   801bb8 <syscall>
  801e9c:	83 c4 18             	add    $0x18,%esp
}
  801e9f:	c9                   	leave  
  801ea0:	c3                   	ret    

00801ea1 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801ea1:	55                   	push   %ebp
  801ea2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801ea4:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ea7:	8b 45 08             	mov    0x8(%ebp),%eax
  801eaa:	6a 00                	push   $0x0
  801eac:	6a 00                	push   $0x0
  801eae:	6a 00                	push   $0x0
  801eb0:	52                   	push   %edx
  801eb1:	50                   	push   %eax
  801eb2:	6a 19                	push   $0x19
  801eb4:	e8 ff fc ff ff       	call   801bb8 <syscall>
  801eb9:	83 c4 18             	add    $0x18,%esp
}
  801ebc:	90                   	nop
  801ebd:	c9                   	leave  
  801ebe:	c3                   	ret    

00801ebf <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801ebf:	55                   	push   %ebp
  801ec0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801ec2:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ec5:	8b 45 08             	mov    0x8(%ebp),%eax
  801ec8:	6a 00                	push   $0x0
  801eca:	6a 00                	push   $0x0
  801ecc:	6a 00                	push   $0x0
  801ece:	52                   	push   %edx
  801ecf:	50                   	push   %eax
  801ed0:	6a 1a                	push   $0x1a
  801ed2:	e8 e1 fc ff ff       	call   801bb8 <syscall>
  801ed7:	83 c4 18             	add    $0x18,%esp
}
  801eda:	90                   	nop
  801edb:	c9                   	leave  
  801edc:	c3                   	ret    

00801edd <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801edd:	55                   	push   %ebp
  801ede:	89 e5                	mov    %esp,%ebp
  801ee0:	83 ec 04             	sub    $0x4,%esp
  801ee3:	8b 45 10             	mov    0x10(%ebp),%eax
  801ee6:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801ee9:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801eec:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801ef0:	8b 45 08             	mov    0x8(%ebp),%eax
  801ef3:	6a 00                	push   $0x0
  801ef5:	51                   	push   %ecx
  801ef6:	52                   	push   %edx
  801ef7:	ff 75 0c             	pushl  0xc(%ebp)
  801efa:	50                   	push   %eax
  801efb:	6a 1c                	push   $0x1c
  801efd:	e8 b6 fc ff ff       	call   801bb8 <syscall>
  801f02:	83 c4 18             	add    $0x18,%esp
}
  801f05:	c9                   	leave  
  801f06:	c3                   	ret    

00801f07 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801f07:	55                   	push   %ebp
  801f08:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801f0a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f0d:	8b 45 08             	mov    0x8(%ebp),%eax
  801f10:	6a 00                	push   $0x0
  801f12:	6a 00                	push   $0x0
  801f14:	6a 00                	push   $0x0
  801f16:	52                   	push   %edx
  801f17:	50                   	push   %eax
  801f18:	6a 1d                	push   $0x1d
  801f1a:	e8 99 fc ff ff       	call   801bb8 <syscall>
  801f1f:	83 c4 18             	add    $0x18,%esp
}
  801f22:	c9                   	leave  
  801f23:	c3                   	ret    

00801f24 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801f24:	55                   	push   %ebp
  801f25:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801f27:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801f2a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f2d:	8b 45 08             	mov    0x8(%ebp),%eax
  801f30:	6a 00                	push   $0x0
  801f32:	6a 00                	push   $0x0
  801f34:	51                   	push   %ecx
  801f35:	52                   	push   %edx
  801f36:	50                   	push   %eax
  801f37:	6a 1e                	push   $0x1e
  801f39:	e8 7a fc ff ff       	call   801bb8 <syscall>
  801f3e:	83 c4 18             	add    $0x18,%esp
}
  801f41:	c9                   	leave  
  801f42:	c3                   	ret    

00801f43 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801f43:	55                   	push   %ebp
  801f44:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801f46:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f49:	8b 45 08             	mov    0x8(%ebp),%eax
  801f4c:	6a 00                	push   $0x0
  801f4e:	6a 00                	push   $0x0
  801f50:	6a 00                	push   $0x0
  801f52:	52                   	push   %edx
  801f53:	50                   	push   %eax
  801f54:	6a 1f                	push   $0x1f
  801f56:	e8 5d fc ff ff       	call   801bb8 <syscall>
  801f5b:	83 c4 18             	add    $0x18,%esp
}
  801f5e:	c9                   	leave  
  801f5f:	c3                   	ret    

00801f60 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801f60:	55                   	push   %ebp
  801f61:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801f63:	6a 00                	push   $0x0
  801f65:	6a 00                	push   $0x0
  801f67:	6a 00                	push   $0x0
  801f69:	6a 00                	push   $0x0
  801f6b:	6a 00                	push   $0x0
  801f6d:	6a 20                	push   $0x20
  801f6f:	e8 44 fc ff ff       	call   801bb8 <syscall>
  801f74:	83 c4 18             	add    $0x18,%esp
}
  801f77:	c9                   	leave  
  801f78:	c3                   	ret    

00801f79 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801f79:	55                   	push   %ebp
  801f7a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801f7c:	8b 45 08             	mov    0x8(%ebp),%eax
  801f7f:	6a 00                	push   $0x0
  801f81:	ff 75 14             	pushl  0x14(%ebp)
  801f84:	ff 75 10             	pushl  0x10(%ebp)
  801f87:	ff 75 0c             	pushl  0xc(%ebp)
  801f8a:	50                   	push   %eax
  801f8b:	6a 21                	push   $0x21
  801f8d:	e8 26 fc ff ff       	call   801bb8 <syscall>
  801f92:	83 c4 18             	add    $0x18,%esp
}
  801f95:	c9                   	leave  
  801f96:	c3                   	ret    

00801f97 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801f97:	55                   	push   %ebp
  801f98:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801f9a:	8b 45 08             	mov    0x8(%ebp),%eax
  801f9d:	6a 00                	push   $0x0
  801f9f:	6a 00                	push   $0x0
  801fa1:	6a 00                	push   $0x0
  801fa3:	6a 00                	push   $0x0
  801fa5:	50                   	push   %eax
  801fa6:	6a 22                	push   $0x22
  801fa8:	e8 0b fc ff ff       	call   801bb8 <syscall>
  801fad:	83 c4 18             	add    $0x18,%esp
}
  801fb0:	90                   	nop
  801fb1:	c9                   	leave  
  801fb2:	c3                   	ret    

00801fb3 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801fb3:	55                   	push   %ebp
  801fb4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801fb6:	8b 45 08             	mov    0x8(%ebp),%eax
  801fb9:	6a 00                	push   $0x0
  801fbb:	6a 00                	push   $0x0
  801fbd:	6a 00                	push   $0x0
  801fbf:	6a 00                	push   $0x0
  801fc1:	50                   	push   %eax
  801fc2:	6a 23                	push   $0x23
  801fc4:	e8 ef fb ff ff       	call   801bb8 <syscall>
  801fc9:	83 c4 18             	add    $0x18,%esp
}
  801fcc:	90                   	nop
  801fcd:	c9                   	leave  
  801fce:	c3                   	ret    

00801fcf <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801fcf:	55                   	push   %ebp
  801fd0:	89 e5                	mov    %esp,%ebp
  801fd2:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801fd5:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801fd8:	8d 50 04             	lea    0x4(%eax),%edx
  801fdb:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801fde:	6a 00                	push   $0x0
  801fe0:	6a 00                	push   $0x0
  801fe2:	6a 00                	push   $0x0
  801fe4:	52                   	push   %edx
  801fe5:	50                   	push   %eax
  801fe6:	6a 24                	push   $0x24
  801fe8:	e8 cb fb ff ff       	call   801bb8 <syscall>
  801fed:	83 c4 18             	add    $0x18,%esp
	return result;
  801ff0:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801ff3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801ff6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801ff9:	89 01                	mov    %eax,(%ecx)
  801ffb:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801ffe:	8b 45 08             	mov    0x8(%ebp),%eax
  802001:	c9                   	leave  
  802002:	c2 04 00             	ret    $0x4

00802005 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  802005:	55                   	push   %ebp
  802006:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  802008:	6a 00                	push   $0x0
  80200a:	6a 00                	push   $0x0
  80200c:	ff 75 10             	pushl  0x10(%ebp)
  80200f:	ff 75 0c             	pushl  0xc(%ebp)
  802012:	ff 75 08             	pushl  0x8(%ebp)
  802015:	6a 13                	push   $0x13
  802017:	e8 9c fb ff ff       	call   801bb8 <syscall>
  80201c:	83 c4 18             	add    $0x18,%esp
	return ;
  80201f:	90                   	nop
}
  802020:	c9                   	leave  
  802021:	c3                   	ret    

00802022 <sys_rcr2>:
uint32 sys_rcr2()
{
  802022:	55                   	push   %ebp
  802023:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  802025:	6a 00                	push   $0x0
  802027:	6a 00                	push   $0x0
  802029:	6a 00                	push   $0x0
  80202b:	6a 00                	push   $0x0
  80202d:	6a 00                	push   $0x0
  80202f:	6a 25                	push   $0x25
  802031:	e8 82 fb ff ff       	call   801bb8 <syscall>
  802036:	83 c4 18             	add    $0x18,%esp
}
  802039:	c9                   	leave  
  80203a:	c3                   	ret    

0080203b <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80203b:	55                   	push   %ebp
  80203c:	89 e5                	mov    %esp,%ebp
  80203e:	83 ec 04             	sub    $0x4,%esp
  802041:	8b 45 08             	mov    0x8(%ebp),%eax
  802044:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  802047:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80204b:	6a 00                	push   $0x0
  80204d:	6a 00                	push   $0x0
  80204f:	6a 00                	push   $0x0
  802051:	6a 00                	push   $0x0
  802053:	50                   	push   %eax
  802054:	6a 26                	push   $0x26
  802056:	e8 5d fb ff ff       	call   801bb8 <syscall>
  80205b:	83 c4 18             	add    $0x18,%esp
	return ;
  80205e:	90                   	nop
}
  80205f:	c9                   	leave  
  802060:	c3                   	ret    

00802061 <rsttst>:
void rsttst()
{
  802061:	55                   	push   %ebp
  802062:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802064:	6a 00                	push   $0x0
  802066:	6a 00                	push   $0x0
  802068:	6a 00                	push   $0x0
  80206a:	6a 00                	push   $0x0
  80206c:	6a 00                	push   $0x0
  80206e:	6a 28                	push   $0x28
  802070:	e8 43 fb ff ff       	call   801bb8 <syscall>
  802075:	83 c4 18             	add    $0x18,%esp
	return ;
  802078:	90                   	nop
}
  802079:	c9                   	leave  
  80207a:	c3                   	ret    

0080207b <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80207b:	55                   	push   %ebp
  80207c:	89 e5                	mov    %esp,%ebp
  80207e:	83 ec 04             	sub    $0x4,%esp
  802081:	8b 45 14             	mov    0x14(%ebp),%eax
  802084:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  802087:	8b 55 18             	mov    0x18(%ebp),%edx
  80208a:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80208e:	52                   	push   %edx
  80208f:	50                   	push   %eax
  802090:	ff 75 10             	pushl  0x10(%ebp)
  802093:	ff 75 0c             	pushl  0xc(%ebp)
  802096:	ff 75 08             	pushl  0x8(%ebp)
  802099:	6a 27                	push   $0x27
  80209b:	e8 18 fb ff ff       	call   801bb8 <syscall>
  8020a0:	83 c4 18             	add    $0x18,%esp
	return ;
  8020a3:	90                   	nop
}
  8020a4:	c9                   	leave  
  8020a5:	c3                   	ret    

008020a6 <chktst>:
void chktst(uint32 n)
{
  8020a6:	55                   	push   %ebp
  8020a7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8020a9:	6a 00                	push   $0x0
  8020ab:	6a 00                	push   $0x0
  8020ad:	6a 00                	push   $0x0
  8020af:	6a 00                	push   $0x0
  8020b1:	ff 75 08             	pushl  0x8(%ebp)
  8020b4:	6a 29                	push   $0x29
  8020b6:	e8 fd fa ff ff       	call   801bb8 <syscall>
  8020bb:	83 c4 18             	add    $0x18,%esp
	return ;
  8020be:	90                   	nop
}
  8020bf:	c9                   	leave  
  8020c0:	c3                   	ret    

008020c1 <inctst>:

void inctst()
{
  8020c1:	55                   	push   %ebp
  8020c2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8020c4:	6a 00                	push   $0x0
  8020c6:	6a 00                	push   $0x0
  8020c8:	6a 00                	push   $0x0
  8020ca:	6a 00                	push   $0x0
  8020cc:	6a 00                	push   $0x0
  8020ce:	6a 2a                	push   $0x2a
  8020d0:	e8 e3 fa ff ff       	call   801bb8 <syscall>
  8020d5:	83 c4 18             	add    $0x18,%esp
	return ;
  8020d8:	90                   	nop
}
  8020d9:	c9                   	leave  
  8020da:	c3                   	ret    

008020db <gettst>:
uint32 gettst()
{
  8020db:	55                   	push   %ebp
  8020dc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8020de:	6a 00                	push   $0x0
  8020e0:	6a 00                	push   $0x0
  8020e2:	6a 00                	push   $0x0
  8020e4:	6a 00                	push   $0x0
  8020e6:	6a 00                	push   $0x0
  8020e8:	6a 2b                	push   $0x2b
  8020ea:	e8 c9 fa ff ff       	call   801bb8 <syscall>
  8020ef:	83 c4 18             	add    $0x18,%esp
}
  8020f2:	c9                   	leave  
  8020f3:	c3                   	ret    

008020f4 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8020f4:	55                   	push   %ebp
  8020f5:	89 e5                	mov    %esp,%ebp
  8020f7:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8020fa:	6a 00                	push   $0x0
  8020fc:	6a 00                	push   $0x0
  8020fe:	6a 00                	push   $0x0
  802100:	6a 00                	push   $0x0
  802102:	6a 00                	push   $0x0
  802104:	6a 2c                	push   $0x2c
  802106:	e8 ad fa ff ff       	call   801bb8 <syscall>
  80210b:	83 c4 18             	add    $0x18,%esp
  80210e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  802111:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802115:	75 07                	jne    80211e <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802117:	b8 01 00 00 00       	mov    $0x1,%eax
  80211c:	eb 05                	jmp    802123 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80211e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802123:	c9                   	leave  
  802124:	c3                   	ret    

00802125 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802125:	55                   	push   %ebp
  802126:	89 e5                	mov    %esp,%ebp
  802128:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80212b:	6a 00                	push   $0x0
  80212d:	6a 00                	push   $0x0
  80212f:	6a 00                	push   $0x0
  802131:	6a 00                	push   $0x0
  802133:	6a 00                	push   $0x0
  802135:	6a 2c                	push   $0x2c
  802137:	e8 7c fa ff ff       	call   801bb8 <syscall>
  80213c:	83 c4 18             	add    $0x18,%esp
  80213f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  802142:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  802146:	75 07                	jne    80214f <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  802148:	b8 01 00 00 00       	mov    $0x1,%eax
  80214d:	eb 05                	jmp    802154 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  80214f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802154:	c9                   	leave  
  802155:	c3                   	ret    

00802156 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  802156:	55                   	push   %ebp
  802157:	89 e5                	mov    %esp,%ebp
  802159:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80215c:	6a 00                	push   $0x0
  80215e:	6a 00                	push   $0x0
  802160:	6a 00                	push   $0x0
  802162:	6a 00                	push   $0x0
  802164:	6a 00                	push   $0x0
  802166:	6a 2c                	push   $0x2c
  802168:	e8 4b fa ff ff       	call   801bb8 <syscall>
  80216d:	83 c4 18             	add    $0x18,%esp
  802170:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802173:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802177:	75 07                	jne    802180 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  802179:	b8 01 00 00 00       	mov    $0x1,%eax
  80217e:	eb 05                	jmp    802185 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802180:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802185:	c9                   	leave  
  802186:	c3                   	ret    

00802187 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802187:	55                   	push   %ebp
  802188:	89 e5                	mov    %esp,%ebp
  80218a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80218d:	6a 00                	push   $0x0
  80218f:	6a 00                	push   $0x0
  802191:	6a 00                	push   $0x0
  802193:	6a 00                	push   $0x0
  802195:	6a 00                	push   $0x0
  802197:	6a 2c                	push   $0x2c
  802199:	e8 1a fa ff ff       	call   801bb8 <syscall>
  80219e:	83 c4 18             	add    $0x18,%esp
  8021a1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8021a4:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8021a8:	75 07                	jne    8021b1 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8021aa:	b8 01 00 00 00       	mov    $0x1,%eax
  8021af:	eb 05                	jmp    8021b6 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8021b1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8021b6:	c9                   	leave  
  8021b7:	c3                   	ret    

008021b8 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8021b8:	55                   	push   %ebp
  8021b9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8021bb:	6a 00                	push   $0x0
  8021bd:	6a 00                	push   $0x0
  8021bf:	6a 00                	push   $0x0
  8021c1:	6a 00                	push   $0x0
  8021c3:	ff 75 08             	pushl  0x8(%ebp)
  8021c6:	6a 2d                	push   $0x2d
  8021c8:	e8 eb f9 ff ff       	call   801bb8 <syscall>
  8021cd:	83 c4 18             	add    $0x18,%esp
	return ;
  8021d0:	90                   	nop
}
  8021d1:	c9                   	leave  
  8021d2:	c3                   	ret    

008021d3 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8021d3:	55                   	push   %ebp
  8021d4:	89 e5                	mov    %esp,%ebp
  8021d6:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8021d7:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8021da:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8021dd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8021e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8021e3:	6a 00                	push   $0x0
  8021e5:	53                   	push   %ebx
  8021e6:	51                   	push   %ecx
  8021e7:	52                   	push   %edx
  8021e8:	50                   	push   %eax
  8021e9:	6a 2e                	push   $0x2e
  8021eb:	e8 c8 f9 ff ff       	call   801bb8 <syscall>
  8021f0:	83 c4 18             	add    $0x18,%esp
}
  8021f3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8021f6:	c9                   	leave  
  8021f7:	c3                   	ret    

008021f8 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8021f8:	55                   	push   %ebp
  8021f9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8021fb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8021fe:	8b 45 08             	mov    0x8(%ebp),%eax
  802201:	6a 00                	push   $0x0
  802203:	6a 00                	push   $0x0
  802205:	6a 00                	push   $0x0
  802207:	52                   	push   %edx
  802208:	50                   	push   %eax
  802209:	6a 2f                	push   $0x2f
  80220b:	e8 a8 f9 ff ff       	call   801bb8 <syscall>
  802210:	83 c4 18             	add    $0x18,%esp
}
  802213:	c9                   	leave  
  802214:	c3                   	ret    
  802215:	66 90                	xchg   %ax,%ax
  802217:	90                   	nop

00802218 <__udivdi3>:
  802218:	55                   	push   %ebp
  802219:	57                   	push   %edi
  80221a:	56                   	push   %esi
  80221b:	53                   	push   %ebx
  80221c:	83 ec 1c             	sub    $0x1c,%esp
  80221f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  802223:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  802227:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80222b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80222f:	89 ca                	mov    %ecx,%edx
  802231:	89 f8                	mov    %edi,%eax
  802233:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802237:	85 f6                	test   %esi,%esi
  802239:	75 2d                	jne    802268 <__udivdi3+0x50>
  80223b:	39 cf                	cmp    %ecx,%edi
  80223d:	77 65                	ja     8022a4 <__udivdi3+0x8c>
  80223f:	89 fd                	mov    %edi,%ebp
  802241:	85 ff                	test   %edi,%edi
  802243:	75 0b                	jne    802250 <__udivdi3+0x38>
  802245:	b8 01 00 00 00       	mov    $0x1,%eax
  80224a:	31 d2                	xor    %edx,%edx
  80224c:	f7 f7                	div    %edi
  80224e:	89 c5                	mov    %eax,%ebp
  802250:	31 d2                	xor    %edx,%edx
  802252:	89 c8                	mov    %ecx,%eax
  802254:	f7 f5                	div    %ebp
  802256:	89 c1                	mov    %eax,%ecx
  802258:	89 d8                	mov    %ebx,%eax
  80225a:	f7 f5                	div    %ebp
  80225c:	89 cf                	mov    %ecx,%edi
  80225e:	89 fa                	mov    %edi,%edx
  802260:	83 c4 1c             	add    $0x1c,%esp
  802263:	5b                   	pop    %ebx
  802264:	5e                   	pop    %esi
  802265:	5f                   	pop    %edi
  802266:	5d                   	pop    %ebp
  802267:	c3                   	ret    
  802268:	39 ce                	cmp    %ecx,%esi
  80226a:	77 28                	ja     802294 <__udivdi3+0x7c>
  80226c:	0f bd fe             	bsr    %esi,%edi
  80226f:	83 f7 1f             	xor    $0x1f,%edi
  802272:	75 40                	jne    8022b4 <__udivdi3+0x9c>
  802274:	39 ce                	cmp    %ecx,%esi
  802276:	72 0a                	jb     802282 <__udivdi3+0x6a>
  802278:	3b 44 24 08          	cmp    0x8(%esp),%eax
  80227c:	0f 87 9e 00 00 00    	ja     802320 <__udivdi3+0x108>
  802282:	b8 01 00 00 00       	mov    $0x1,%eax
  802287:	89 fa                	mov    %edi,%edx
  802289:	83 c4 1c             	add    $0x1c,%esp
  80228c:	5b                   	pop    %ebx
  80228d:	5e                   	pop    %esi
  80228e:	5f                   	pop    %edi
  80228f:	5d                   	pop    %ebp
  802290:	c3                   	ret    
  802291:	8d 76 00             	lea    0x0(%esi),%esi
  802294:	31 ff                	xor    %edi,%edi
  802296:	31 c0                	xor    %eax,%eax
  802298:	89 fa                	mov    %edi,%edx
  80229a:	83 c4 1c             	add    $0x1c,%esp
  80229d:	5b                   	pop    %ebx
  80229e:	5e                   	pop    %esi
  80229f:	5f                   	pop    %edi
  8022a0:	5d                   	pop    %ebp
  8022a1:	c3                   	ret    
  8022a2:	66 90                	xchg   %ax,%ax
  8022a4:	89 d8                	mov    %ebx,%eax
  8022a6:	f7 f7                	div    %edi
  8022a8:	31 ff                	xor    %edi,%edi
  8022aa:	89 fa                	mov    %edi,%edx
  8022ac:	83 c4 1c             	add    $0x1c,%esp
  8022af:	5b                   	pop    %ebx
  8022b0:	5e                   	pop    %esi
  8022b1:	5f                   	pop    %edi
  8022b2:	5d                   	pop    %ebp
  8022b3:	c3                   	ret    
  8022b4:	bd 20 00 00 00       	mov    $0x20,%ebp
  8022b9:	89 eb                	mov    %ebp,%ebx
  8022bb:	29 fb                	sub    %edi,%ebx
  8022bd:	89 f9                	mov    %edi,%ecx
  8022bf:	d3 e6                	shl    %cl,%esi
  8022c1:	89 c5                	mov    %eax,%ebp
  8022c3:	88 d9                	mov    %bl,%cl
  8022c5:	d3 ed                	shr    %cl,%ebp
  8022c7:	89 e9                	mov    %ebp,%ecx
  8022c9:	09 f1                	or     %esi,%ecx
  8022cb:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8022cf:	89 f9                	mov    %edi,%ecx
  8022d1:	d3 e0                	shl    %cl,%eax
  8022d3:	89 c5                	mov    %eax,%ebp
  8022d5:	89 d6                	mov    %edx,%esi
  8022d7:	88 d9                	mov    %bl,%cl
  8022d9:	d3 ee                	shr    %cl,%esi
  8022db:	89 f9                	mov    %edi,%ecx
  8022dd:	d3 e2                	shl    %cl,%edx
  8022df:	8b 44 24 08          	mov    0x8(%esp),%eax
  8022e3:	88 d9                	mov    %bl,%cl
  8022e5:	d3 e8                	shr    %cl,%eax
  8022e7:	09 c2                	or     %eax,%edx
  8022e9:	89 d0                	mov    %edx,%eax
  8022eb:	89 f2                	mov    %esi,%edx
  8022ed:	f7 74 24 0c          	divl   0xc(%esp)
  8022f1:	89 d6                	mov    %edx,%esi
  8022f3:	89 c3                	mov    %eax,%ebx
  8022f5:	f7 e5                	mul    %ebp
  8022f7:	39 d6                	cmp    %edx,%esi
  8022f9:	72 19                	jb     802314 <__udivdi3+0xfc>
  8022fb:	74 0b                	je     802308 <__udivdi3+0xf0>
  8022fd:	89 d8                	mov    %ebx,%eax
  8022ff:	31 ff                	xor    %edi,%edi
  802301:	e9 58 ff ff ff       	jmp    80225e <__udivdi3+0x46>
  802306:	66 90                	xchg   %ax,%ax
  802308:	8b 54 24 08          	mov    0x8(%esp),%edx
  80230c:	89 f9                	mov    %edi,%ecx
  80230e:	d3 e2                	shl    %cl,%edx
  802310:	39 c2                	cmp    %eax,%edx
  802312:	73 e9                	jae    8022fd <__udivdi3+0xe5>
  802314:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802317:	31 ff                	xor    %edi,%edi
  802319:	e9 40 ff ff ff       	jmp    80225e <__udivdi3+0x46>
  80231e:	66 90                	xchg   %ax,%ax
  802320:	31 c0                	xor    %eax,%eax
  802322:	e9 37 ff ff ff       	jmp    80225e <__udivdi3+0x46>
  802327:	90                   	nop

00802328 <__umoddi3>:
  802328:	55                   	push   %ebp
  802329:	57                   	push   %edi
  80232a:	56                   	push   %esi
  80232b:	53                   	push   %ebx
  80232c:	83 ec 1c             	sub    $0x1c,%esp
  80232f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802333:	8b 74 24 34          	mov    0x34(%esp),%esi
  802337:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80233b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80233f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802343:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802347:	89 f3                	mov    %esi,%ebx
  802349:	89 fa                	mov    %edi,%edx
  80234b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80234f:	89 34 24             	mov    %esi,(%esp)
  802352:	85 c0                	test   %eax,%eax
  802354:	75 1a                	jne    802370 <__umoddi3+0x48>
  802356:	39 f7                	cmp    %esi,%edi
  802358:	0f 86 a2 00 00 00    	jbe    802400 <__umoddi3+0xd8>
  80235e:	89 c8                	mov    %ecx,%eax
  802360:	89 f2                	mov    %esi,%edx
  802362:	f7 f7                	div    %edi
  802364:	89 d0                	mov    %edx,%eax
  802366:	31 d2                	xor    %edx,%edx
  802368:	83 c4 1c             	add    $0x1c,%esp
  80236b:	5b                   	pop    %ebx
  80236c:	5e                   	pop    %esi
  80236d:	5f                   	pop    %edi
  80236e:	5d                   	pop    %ebp
  80236f:	c3                   	ret    
  802370:	39 f0                	cmp    %esi,%eax
  802372:	0f 87 ac 00 00 00    	ja     802424 <__umoddi3+0xfc>
  802378:	0f bd e8             	bsr    %eax,%ebp
  80237b:	83 f5 1f             	xor    $0x1f,%ebp
  80237e:	0f 84 ac 00 00 00    	je     802430 <__umoddi3+0x108>
  802384:	bf 20 00 00 00       	mov    $0x20,%edi
  802389:	29 ef                	sub    %ebp,%edi
  80238b:	89 fe                	mov    %edi,%esi
  80238d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802391:	89 e9                	mov    %ebp,%ecx
  802393:	d3 e0                	shl    %cl,%eax
  802395:	89 d7                	mov    %edx,%edi
  802397:	89 f1                	mov    %esi,%ecx
  802399:	d3 ef                	shr    %cl,%edi
  80239b:	09 c7                	or     %eax,%edi
  80239d:	89 e9                	mov    %ebp,%ecx
  80239f:	d3 e2                	shl    %cl,%edx
  8023a1:	89 14 24             	mov    %edx,(%esp)
  8023a4:	89 d8                	mov    %ebx,%eax
  8023a6:	d3 e0                	shl    %cl,%eax
  8023a8:	89 c2                	mov    %eax,%edx
  8023aa:	8b 44 24 08          	mov    0x8(%esp),%eax
  8023ae:	d3 e0                	shl    %cl,%eax
  8023b0:	89 44 24 04          	mov    %eax,0x4(%esp)
  8023b4:	8b 44 24 08          	mov    0x8(%esp),%eax
  8023b8:	89 f1                	mov    %esi,%ecx
  8023ba:	d3 e8                	shr    %cl,%eax
  8023bc:	09 d0                	or     %edx,%eax
  8023be:	d3 eb                	shr    %cl,%ebx
  8023c0:	89 da                	mov    %ebx,%edx
  8023c2:	f7 f7                	div    %edi
  8023c4:	89 d3                	mov    %edx,%ebx
  8023c6:	f7 24 24             	mull   (%esp)
  8023c9:	89 c6                	mov    %eax,%esi
  8023cb:	89 d1                	mov    %edx,%ecx
  8023cd:	39 d3                	cmp    %edx,%ebx
  8023cf:	0f 82 87 00 00 00    	jb     80245c <__umoddi3+0x134>
  8023d5:	0f 84 91 00 00 00    	je     80246c <__umoddi3+0x144>
  8023db:	8b 54 24 04          	mov    0x4(%esp),%edx
  8023df:	29 f2                	sub    %esi,%edx
  8023e1:	19 cb                	sbb    %ecx,%ebx
  8023e3:	89 d8                	mov    %ebx,%eax
  8023e5:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8023e9:	d3 e0                	shl    %cl,%eax
  8023eb:	89 e9                	mov    %ebp,%ecx
  8023ed:	d3 ea                	shr    %cl,%edx
  8023ef:	09 d0                	or     %edx,%eax
  8023f1:	89 e9                	mov    %ebp,%ecx
  8023f3:	d3 eb                	shr    %cl,%ebx
  8023f5:	89 da                	mov    %ebx,%edx
  8023f7:	83 c4 1c             	add    $0x1c,%esp
  8023fa:	5b                   	pop    %ebx
  8023fb:	5e                   	pop    %esi
  8023fc:	5f                   	pop    %edi
  8023fd:	5d                   	pop    %ebp
  8023fe:	c3                   	ret    
  8023ff:	90                   	nop
  802400:	89 fd                	mov    %edi,%ebp
  802402:	85 ff                	test   %edi,%edi
  802404:	75 0b                	jne    802411 <__umoddi3+0xe9>
  802406:	b8 01 00 00 00       	mov    $0x1,%eax
  80240b:	31 d2                	xor    %edx,%edx
  80240d:	f7 f7                	div    %edi
  80240f:	89 c5                	mov    %eax,%ebp
  802411:	89 f0                	mov    %esi,%eax
  802413:	31 d2                	xor    %edx,%edx
  802415:	f7 f5                	div    %ebp
  802417:	89 c8                	mov    %ecx,%eax
  802419:	f7 f5                	div    %ebp
  80241b:	89 d0                	mov    %edx,%eax
  80241d:	e9 44 ff ff ff       	jmp    802366 <__umoddi3+0x3e>
  802422:	66 90                	xchg   %ax,%ax
  802424:	89 c8                	mov    %ecx,%eax
  802426:	89 f2                	mov    %esi,%edx
  802428:	83 c4 1c             	add    $0x1c,%esp
  80242b:	5b                   	pop    %ebx
  80242c:	5e                   	pop    %esi
  80242d:	5f                   	pop    %edi
  80242e:	5d                   	pop    %ebp
  80242f:	c3                   	ret    
  802430:	3b 04 24             	cmp    (%esp),%eax
  802433:	72 06                	jb     80243b <__umoddi3+0x113>
  802435:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802439:	77 0f                	ja     80244a <__umoddi3+0x122>
  80243b:	89 f2                	mov    %esi,%edx
  80243d:	29 f9                	sub    %edi,%ecx
  80243f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802443:	89 14 24             	mov    %edx,(%esp)
  802446:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80244a:	8b 44 24 04          	mov    0x4(%esp),%eax
  80244e:	8b 14 24             	mov    (%esp),%edx
  802451:	83 c4 1c             	add    $0x1c,%esp
  802454:	5b                   	pop    %ebx
  802455:	5e                   	pop    %esi
  802456:	5f                   	pop    %edi
  802457:	5d                   	pop    %ebp
  802458:	c3                   	ret    
  802459:	8d 76 00             	lea    0x0(%esi),%esi
  80245c:	2b 04 24             	sub    (%esp),%eax
  80245f:	19 fa                	sbb    %edi,%edx
  802461:	89 d1                	mov    %edx,%ecx
  802463:	89 c6                	mov    %eax,%esi
  802465:	e9 71 ff ff ff       	jmp    8023db <__umoddi3+0xb3>
  80246a:	66 90                	xchg   %ax,%ax
  80246c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802470:	72 ea                	jb     80245c <__umoddi3+0x134>
  802472:	89 d9                	mov    %ebx,%ecx
  802474:	e9 62 ff ff ff       	jmp    8023db <__umoddi3+0xb3>
