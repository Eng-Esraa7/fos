
obj/user/ef_mergesort_noleakage:     file format elf32-i386


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
  800031:	e8 81 07 00 00       	call   8007b7 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
void Merge(int* A, int p, int q, int r);

uint32 CheckSorted(int *Elements, int NumOfElements);

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	81 ec 18 01 00 00    	sub    $0x118,%esp
	char Line[255] ;
	char Chose ;
	do
	{
		//2012: lock the interrupt
		sys_disable_interrupt();
  800041:	e8 d8 1f 00 00       	call   80201e <sys_disable_interrupt>

		cprintf("\n");
  800046:	83 ec 0c             	sub    $0xc,%esp
  800049:	68 c0 26 80 00       	push   $0x8026c0
  80004e:	e8 4b 0b 00 00       	call   800b9e <cprintf>
  800053:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  800056:	83 ec 0c             	sub    $0xc,%esp
  800059:	68 c2 26 80 00       	push   $0x8026c2
  80005e:	e8 3b 0b 00 00       	call   800b9e <cprintf>
  800063:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!! MERGE SORT !!!!\n");
  800066:	83 ec 0c             	sub    $0xc,%esp
  800069:	68 d8 26 80 00       	push   $0x8026d8
  80006e:	e8 2b 0b 00 00       	call   800b9e <cprintf>
  800073:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  800076:	83 ec 0c             	sub    $0xc,%esp
  800079:	68 c2 26 80 00       	push   $0x8026c2
  80007e:	e8 1b 0b 00 00       	call   800b9e <cprintf>
  800083:	83 c4 10             	add    $0x10,%esp
		cprintf("\n");
  800086:	83 ec 0c             	sub    $0xc,%esp
  800089:	68 c0 26 80 00       	push   $0x8026c0
  80008e:	e8 0b 0b 00 00       	call   800b9e <cprintf>
  800093:	83 c4 10             	add    $0x10,%esp
		//readline("Enter the number of elements: ", Line);
		cprintf("Enter the number of elements: ");
  800096:	83 ec 0c             	sub    $0xc,%esp
  800099:	68 f0 26 80 00       	push   $0x8026f0
  80009e:	e8 fb 0a 00 00       	call   800b9e <cprintf>
  8000a3:	83 c4 10             	add    $0x10,%esp
		int NumOfElements = 2000 ;
  8000a6:	c7 45 f0 d0 07 00 00 	movl   $0x7d0,-0x10(%ebp)
		cprintf("%d\n", NumOfElements) ;
  8000ad:	83 ec 08             	sub    $0x8,%esp
  8000b0:	ff 75 f0             	pushl  -0x10(%ebp)
  8000b3:	68 0f 27 80 00       	push   $0x80270f
  8000b8:	e8 e1 0a 00 00       	call   800b9e <cprintf>
  8000bd:	83 c4 10             	add    $0x10,%esp

		int *Elements = malloc(sizeof(int) * NumOfElements) ;
  8000c0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8000c3:	c1 e0 02             	shl    $0x2,%eax
  8000c6:	83 ec 0c             	sub    $0xc,%esp
  8000c9:	50                   	push   %eax
  8000ca:	e8 59 18 00 00       	call   801928 <malloc>
  8000cf:	83 c4 10             	add    $0x10,%esp
  8000d2:	89 45 ec             	mov    %eax,-0x14(%ebp)
		cprintf("Chose the initialization method:\n") ;
  8000d5:	83 ec 0c             	sub    $0xc,%esp
  8000d8:	68 14 27 80 00       	push   $0x802714
  8000dd:	e8 bc 0a 00 00       	call   800b9e <cprintf>
  8000e2:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  8000e5:	83 ec 0c             	sub    $0xc,%esp
  8000e8:	68 36 27 80 00       	push   $0x802736
  8000ed:	e8 ac 0a 00 00       	call   800b9e <cprintf>
  8000f2:	83 c4 10             	add    $0x10,%esp
		cprintf("b) Descending\n") ;
  8000f5:	83 ec 0c             	sub    $0xc,%esp
  8000f8:	68 44 27 80 00       	push   $0x802744
  8000fd:	e8 9c 0a 00 00       	call   800b9e <cprintf>
  800102:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n");
  800105:	83 ec 0c             	sub    $0xc,%esp
  800108:	68 53 27 80 00       	push   $0x802753
  80010d:	e8 8c 0a 00 00       	call   800b9e <cprintf>
  800112:	83 c4 10             	add    $0x10,%esp
		do
		{
			cprintf("Select: ") ;
  800115:	83 ec 0c             	sub    $0xc,%esp
  800118:	68 63 27 80 00       	push   $0x802763
  80011d:	e8 7c 0a 00 00       	call   800b9e <cprintf>
  800122:	83 c4 10             	add    $0x10,%esp
			//Chose = getchar() ;
			Chose = 'a';
  800125:	c6 45 f7 61          	movb   $0x61,-0x9(%ebp)
			cputchar(Chose);
  800129:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80012d:	83 ec 0c             	sub    $0xc,%esp
  800130:	50                   	push   %eax
  800131:	e8 e1 05 00 00       	call   800717 <cputchar>
  800136:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  800139:	83 ec 0c             	sub    $0xc,%esp
  80013c:	6a 0a                	push   $0xa
  80013e:	e8 d4 05 00 00       	call   800717 <cputchar>
  800143:	83 c4 10             	add    $0x10,%esp
		} while (Chose != 'a' && Chose != 'b' && Chose != 'c');
  800146:	80 7d f7 61          	cmpb   $0x61,-0x9(%ebp)
  80014a:	74 0c                	je     800158 <_main+0x120>
  80014c:	80 7d f7 62          	cmpb   $0x62,-0x9(%ebp)
  800150:	74 06                	je     800158 <_main+0x120>
  800152:	80 7d f7 63          	cmpb   $0x63,-0x9(%ebp)
  800156:	75 bd                	jne    800115 <_main+0xdd>

		//2012: lock the interrupt
		sys_enable_interrupt();
  800158:	e8 db 1e 00 00       	call   802038 <sys_enable_interrupt>

		int  i ;
		switch (Chose)
  80015d:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800161:	83 f8 62             	cmp    $0x62,%eax
  800164:	74 1d                	je     800183 <_main+0x14b>
  800166:	83 f8 63             	cmp    $0x63,%eax
  800169:	74 2b                	je     800196 <_main+0x15e>
  80016b:	83 f8 61             	cmp    $0x61,%eax
  80016e:	75 39                	jne    8001a9 <_main+0x171>
		{
		case 'a':
			InitializeAscending(Elements, NumOfElements);
  800170:	83 ec 08             	sub    $0x8,%esp
  800173:	ff 75 f0             	pushl  -0x10(%ebp)
  800176:	ff 75 ec             	pushl  -0x14(%ebp)
  800179:	e8 f0 01 00 00       	call   80036e <InitializeAscending>
  80017e:	83 c4 10             	add    $0x10,%esp
			break ;
  800181:	eb 37                	jmp    8001ba <_main+0x182>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  800183:	83 ec 08             	sub    $0x8,%esp
  800186:	ff 75 f0             	pushl  -0x10(%ebp)
  800189:	ff 75 ec             	pushl  -0x14(%ebp)
  80018c:	e8 0e 02 00 00       	call   80039f <InitializeDescending>
  800191:	83 c4 10             	add    $0x10,%esp
			break ;
  800194:	eb 24                	jmp    8001ba <_main+0x182>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  800196:	83 ec 08             	sub    $0x8,%esp
  800199:	ff 75 f0             	pushl  -0x10(%ebp)
  80019c:	ff 75 ec             	pushl  -0x14(%ebp)
  80019f:	e8 30 02 00 00       	call   8003d4 <InitializeSemiRandom>
  8001a4:	83 c4 10             	add    $0x10,%esp
			break ;
  8001a7:	eb 11                	jmp    8001ba <_main+0x182>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  8001a9:	83 ec 08             	sub    $0x8,%esp
  8001ac:	ff 75 f0             	pushl  -0x10(%ebp)
  8001af:	ff 75 ec             	pushl  -0x14(%ebp)
  8001b2:	e8 1d 02 00 00       	call   8003d4 <InitializeSemiRandom>
  8001b7:	83 c4 10             	add    $0x10,%esp
		}

		MSort(Elements, 1, NumOfElements);
  8001ba:	83 ec 04             	sub    $0x4,%esp
  8001bd:	ff 75 f0             	pushl  -0x10(%ebp)
  8001c0:	6a 01                	push   $0x1
  8001c2:	ff 75 ec             	pushl  -0x14(%ebp)
  8001c5:	e8 dc 02 00 00       	call   8004a6 <MSort>
  8001ca:	83 c4 10             	add    $0x10,%esp

		sys_disable_interrupt();
  8001cd:	e8 4c 1e 00 00       	call   80201e <sys_disable_interrupt>
		cprintf("Sorting is Finished!!!!it'll be checked now....\n") ;
  8001d2:	83 ec 0c             	sub    $0xc,%esp
  8001d5:	68 6c 27 80 00       	push   $0x80276c
  8001da:	e8 bf 09 00 00       	call   800b9e <cprintf>
  8001df:	83 c4 10             	add    $0x10,%esp
		//PrintElements(Elements, NumOfElements);
		sys_enable_interrupt();
  8001e2:	e8 51 1e 00 00       	call   802038 <sys_enable_interrupt>

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  8001e7:	83 ec 08             	sub    $0x8,%esp
  8001ea:	ff 75 f0             	pushl  -0x10(%ebp)
  8001ed:	ff 75 ec             	pushl  -0x14(%ebp)
  8001f0:	e8 cf 00 00 00       	call   8002c4 <CheckSorted>
  8001f5:	83 c4 10             	add    $0x10,%esp
  8001f8:	89 45 e8             	mov    %eax,-0x18(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  8001fb:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  8001ff:	75 14                	jne    800215 <_main+0x1dd>
  800201:	83 ec 04             	sub    $0x4,%esp
  800204:	68 a0 27 80 00       	push   $0x8027a0
  800209:	6a 4e                	push   $0x4e
  80020b:	68 c2 27 80 00       	push   $0x8027c2
  800210:	e8 e7 06 00 00       	call   8008fc <_panic>
		else
		{
			sys_disable_interrupt();
  800215:	e8 04 1e 00 00       	call   80201e <sys_disable_interrupt>
			cprintf("===============================================\n") ;
  80021a:	83 ec 0c             	sub    $0xc,%esp
  80021d:	68 e0 27 80 00       	push   $0x8027e0
  800222:	e8 77 09 00 00       	call   800b9e <cprintf>
  800227:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  80022a:	83 ec 0c             	sub    $0xc,%esp
  80022d:	68 14 28 80 00       	push   $0x802814
  800232:	e8 67 09 00 00       	call   800b9e <cprintf>
  800237:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  80023a:	83 ec 0c             	sub    $0xc,%esp
  80023d:	68 48 28 80 00       	push   $0x802848
  800242:	e8 57 09 00 00       	call   800b9e <cprintf>
  800247:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  80024a:	e8 e9 1d 00 00       	call   802038 <sys_enable_interrupt>
		}

		free(Elements) ;
  80024f:	83 ec 0c             	sub    $0xc,%esp
  800252:	ff 75 ec             	pushl  -0x14(%ebp)
  800255:	e8 9b 19 00 00       	call   801bf5 <free>
  80025a:	83 c4 10             	add    $0x10,%esp

		sys_disable_interrupt();
  80025d:	e8 bc 1d 00 00       	call   80201e <sys_disable_interrupt>
			Chose = 0 ;
  800262:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
			while (Chose != 'y' && Chose != 'n')
  800266:	eb 3e                	jmp    8002a6 <_main+0x26e>
			{
				cprintf("Do you want to repeat (y/n): ") ;
  800268:	83 ec 0c             	sub    $0xc,%esp
  80026b:	68 7a 28 80 00       	push   $0x80287a
  800270:	e8 29 09 00 00       	call   800b9e <cprintf>
  800275:	83 c4 10             	add    $0x10,%esp
				Chose = 'n' ;
  800278:	c6 45 f7 6e          	movb   $0x6e,-0x9(%ebp)
				cputchar(Chose);
  80027c:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800280:	83 ec 0c             	sub    $0xc,%esp
  800283:	50                   	push   %eax
  800284:	e8 8e 04 00 00       	call   800717 <cputchar>
  800289:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  80028c:	83 ec 0c             	sub    $0xc,%esp
  80028f:	6a 0a                	push   $0xa
  800291:	e8 81 04 00 00       	call   800717 <cputchar>
  800296:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  800299:	83 ec 0c             	sub    $0xc,%esp
  80029c:	6a 0a                	push   $0xa
  80029e:	e8 74 04 00 00       	call   800717 <cputchar>
  8002a3:	83 c4 10             	add    $0x10,%esp

		free(Elements) ;

		sys_disable_interrupt();
			Chose = 0 ;
			while (Chose != 'y' && Chose != 'n')
  8002a6:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  8002aa:	74 06                	je     8002b2 <_main+0x27a>
  8002ac:	80 7d f7 6e          	cmpb   $0x6e,-0x9(%ebp)
  8002b0:	75 b6                	jne    800268 <_main+0x230>
				Chose = 'n' ;
				cputchar(Chose);
				cputchar('\n');
				cputchar('\n');
			}
		sys_enable_interrupt();
  8002b2:	e8 81 1d 00 00       	call   802038 <sys_enable_interrupt>

	} while (Chose == 'y');
  8002b7:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  8002bb:	0f 84 80 fd ff ff    	je     800041 <_main+0x9>
}
  8002c1:	90                   	nop
  8002c2:	c9                   	leave  
  8002c3:	c3                   	ret    

008002c4 <CheckSorted>:


uint32 CheckSorted(int *Elements, int NumOfElements)
{
  8002c4:	55                   	push   %ebp
  8002c5:	89 e5                	mov    %esp,%ebp
  8002c7:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  8002ca:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  8002d1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8002d8:	eb 33                	jmp    80030d <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  8002da:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8002dd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8002e7:	01 d0                	add    %edx,%eax
  8002e9:	8b 10                	mov    (%eax),%edx
  8002eb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8002ee:	40                   	inc    %eax
  8002ef:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8002f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8002f9:	01 c8                	add    %ecx,%eax
  8002fb:	8b 00                	mov    (%eax),%eax
  8002fd:	39 c2                	cmp    %eax,%edx
  8002ff:	7e 09                	jle    80030a <CheckSorted+0x46>
		{
			Sorted = 0 ;
  800301:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  800308:	eb 0c                	jmp    800316 <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  80030a:	ff 45 f8             	incl   -0x8(%ebp)
  80030d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800310:	48                   	dec    %eax
  800311:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800314:	7f c4                	jg     8002da <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  800316:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800319:	c9                   	leave  
  80031a:	c3                   	ret    

0080031b <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  80031b:	55                   	push   %ebp
  80031c:	89 e5                	mov    %esp,%ebp
  80031e:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  800321:	8b 45 0c             	mov    0xc(%ebp),%eax
  800324:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80032b:	8b 45 08             	mov    0x8(%ebp),%eax
  80032e:	01 d0                	add    %edx,%eax
  800330:	8b 00                	mov    (%eax),%eax
  800332:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  800335:	8b 45 0c             	mov    0xc(%ebp),%eax
  800338:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80033f:	8b 45 08             	mov    0x8(%ebp),%eax
  800342:	01 c2                	add    %eax,%edx
  800344:	8b 45 10             	mov    0x10(%ebp),%eax
  800347:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80034e:	8b 45 08             	mov    0x8(%ebp),%eax
  800351:	01 c8                	add    %ecx,%eax
  800353:	8b 00                	mov    (%eax),%eax
  800355:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  800357:	8b 45 10             	mov    0x10(%ebp),%eax
  80035a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800361:	8b 45 08             	mov    0x8(%ebp),%eax
  800364:	01 c2                	add    %eax,%edx
  800366:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800369:	89 02                	mov    %eax,(%edx)
}
  80036b:	90                   	nop
  80036c:	c9                   	leave  
  80036d:	c3                   	ret    

0080036e <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  80036e:	55                   	push   %ebp
  80036f:	89 e5                	mov    %esp,%ebp
  800371:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800374:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80037b:	eb 17                	jmp    800394 <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  80037d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800380:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800387:	8b 45 08             	mov    0x8(%ebp),%eax
  80038a:	01 c2                	add    %eax,%edx
  80038c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80038f:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800391:	ff 45 fc             	incl   -0x4(%ebp)
  800394:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800397:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80039a:	7c e1                	jl     80037d <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  80039c:	90                   	nop
  80039d:	c9                   	leave  
  80039e:	c3                   	ret    

0080039f <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  80039f:	55                   	push   %ebp
  8003a0:	89 e5                	mov    %esp,%ebp
  8003a2:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8003a5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8003ac:	eb 1b                	jmp    8003c9 <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  8003ae:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003b1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8003bb:	01 c2                	add    %eax,%edx
  8003bd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003c0:	2b 45 fc             	sub    -0x4(%ebp),%eax
  8003c3:	48                   	dec    %eax
  8003c4:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8003c6:	ff 45 fc             	incl   -0x4(%ebp)
  8003c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003cc:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8003cf:	7c dd                	jl     8003ae <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  8003d1:	90                   	nop
  8003d2:	c9                   	leave  
  8003d3:	c3                   	ret    

008003d4 <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  8003d4:	55                   	push   %ebp
  8003d5:	89 e5                	mov    %esp,%ebp
  8003d7:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  8003da:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8003dd:	b8 56 55 55 55       	mov    $0x55555556,%eax
  8003e2:	f7 e9                	imul   %ecx
  8003e4:	c1 f9 1f             	sar    $0x1f,%ecx
  8003e7:	89 d0                	mov    %edx,%eax
  8003e9:	29 c8                	sub    %ecx,%eax
  8003eb:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  8003ee:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8003f5:	eb 1e                	jmp    800415 <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  8003f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003fa:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800401:	8b 45 08             	mov    0x8(%ebp),%eax
  800404:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800407:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80040a:	99                   	cltd   
  80040b:	f7 7d f8             	idivl  -0x8(%ebp)
  80040e:	89 d0                	mov    %edx,%eax
  800410:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  800412:	ff 45 fc             	incl   -0x4(%ebp)
  800415:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800418:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80041b:	7c da                	jl     8003f7 <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
		//	cprintf("i=%d\n",i);
	}

}
  80041d:	90                   	nop
  80041e:	c9                   	leave  
  80041f:	c3                   	ret    

00800420 <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  800420:	55                   	push   %ebp
  800421:	89 e5                	mov    %esp,%ebp
  800423:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  800426:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  80042d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800434:	eb 42                	jmp    800478 <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  800436:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800439:	99                   	cltd   
  80043a:	f7 7d f0             	idivl  -0x10(%ebp)
  80043d:	89 d0                	mov    %edx,%eax
  80043f:	85 c0                	test   %eax,%eax
  800441:	75 10                	jne    800453 <PrintElements+0x33>
			cprintf("\n");
  800443:	83 ec 0c             	sub    $0xc,%esp
  800446:	68 c0 26 80 00       	push   $0x8026c0
  80044b:	e8 4e 07 00 00       	call   800b9e <cprintf>
  800450:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  800453:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800456:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80045d:	8b 45 08             	mov    0x8(%ebp),%eax
  800460:	01 d0                	add    %edx,%eax
  800462:	8b 00                	mov    (%eax),%eax
  800464:	83 ec 08             	sub    $0x8,%esp
  800467:	50                   	push   %eax
  800468:	68 98 28 80 00       	push   $0x802898
  80046d:	e8 2c 07 00 00       	call   800b9e <cprintf>
  800472:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800475:	ff 45 f4             	incl   -0xc(%ebp)
  800478:	8b 45 0c             	mov    0xc(%ebp),%eax
  80047b:	48                   	dec    %eax
  80047c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80047f:	7f b5                	jg     800436 <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  800481:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800484:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80048b:	8b 45 08             	mov    0x8(%ebp),%eax
  80048e:	01 d0                	add    %edx,%eax
  800490:	8b 00                	mov    (%eax),%eax
  800492:	83 ec 08             	sub    $0x8,%esp
  800495:	50                   	push   %eax
  800496:	68 0f 27 80 00       	push   $0x80270f
  80049b:	e8 fe 06 00 00       	call   800b9e <cprintf>
  8004a0:	83 c4 10             	add    $0x10,%esp

}
  8004a3:	90                   	nop
  8004a4:	c9                   	leave  
  8004a5:	c3                   	ret    

008004a6 <MSort>:


void MSort(int* A, int p, int r)
{
  8004a6:	55                   	push   %ebp
  8004a7:	89 e5                	mov    %esp,%ebp
  8004a9:	83 ec 18             	sub    $0x18,%esp
	if (p >= r)
  8004ac:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004af:	3b 45 10             	cmp    0x10(%ebp),%eax
  8004b2:	7d 54                	jge    800508 <MSort+0x62>
	{
		return;
	}

	int q = (p + r) / 2;
  8004b4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004b7:	8b 45 10             	mov    0x10(%ebp),%eax
  8004ba:	01 d0                	add    %edx,%eax
  8004bc:	89 c2                	mov    %eax,%edx
  8004be:	c1 ea 1f             	shr    $0x1f,%edx
  8004c1:	01 d0                	add    %edx,%eax
  8004c3:	d1 f8                	sar    %eax
  8004c5:	89 45 f4             	mov    %eax,-0xc(%ebp)

	MSort(A, p, q);
  8004c8:	83 ec 04             	sub    $0x4,%esp
  8004cb:	ff 75 f4             	pushl  -0xc(%ebp)
  8004ce:	ff 75 0c             	pushl  0xc(%ebp)
  8004d1:	ff 75 08             	pushl  0x8(%ebp)
  8004d4:	e8 cd ff ff ff       	call   8004a6 <MSort>
  8004d9:	83 c4 10             	add    $0x10,%esp

	MSort(A, q + 1, r);
  8004dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004df:	40                   	inc    %eax
  8004e0:	83 ec 04             	sub    $0x4,%esp
  8004e3:	ff 75 10             	pushl  0x10(%ebp)
  8004e6:	50                   	push   %eax
  8004e7:	ff 75 08             	pushl  0x8(%ebp)
  8004ea:	e8 b7 ff ff ff       	call   8004a6 <MSort>
  8004ef:	83 c4 10             	add    $0x10,%esp

	Merge(A, p, q, r);
  8004f2:	ff 75 10             	pushl  0x10(%ebp)
  8004f5:	ff 75 f4             	pushl  -0xc(%ebp)
  8004f8:	ff 75 0c             	pushl  0xc(%ebp)
  8004fb:	ff 75 08             	pushl  0x8(%ebp)
  8004fe:	e8 08 00 00 00       	call   80050b <Merge>
  800503:	83 c4 10             	add    $0x10,%esp
  800506:	eb 01                	jmp    800509 <MSort+0x63>

void MSort(int* A, int p, int r)
{
	if (p >= r)
	{
		return;
  800508:	90                   	nop

	MSort(A, q + 1, r);

	Merge(A, p, q, r);

}
  800509:	c9                   	leave  
  80050a:	c3                   	ret    

0080050b <Merge>:

void Merge(int* A, int p, int q, int r)
{
  80050b:	55                   	push   %ebp
  80050c:	89 e5                	mov    %esp,%ebp
  80050e:	83 ec 38             	sub    $0x38,%esp
	int leftCapacity = q - p + 1;
  800511:	8b 45 10             	mov    0x10(%ebp),%eax
  800514:	2b 45 0c             	sub    0xc(%ebp),%eax
  800517:	40                   	inc    %eax
  800518:	89 45 e0             	mov    %eax,-0x20(%ebp)

	int rightCapacity = r - q;
  80051b:	8b 45 14             	mov    0x14(%ebp),%eax
  80051e:	2b 45 10             	sub    0x10(%ebp),%eax
  800521:	89 45 dc             	mov    %eax,-0x24(%ebp)

	int leftIndex = 0;
  800524:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	int rightIndex = 0;
  80052b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)

	int* Left = malloc(sizeof(int) * leftCapacity);
  800532:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800535:	c1 e0 02             	shl    $0x2,%eax
  800538:	83 ec 0c             	sub    $0xc,%esp
  80053b:	50                   	push   %eax
  80053c:	e8 e7 13 00 00       	call   801928 <malloc>
  800541:	83 c4 10             	add    $0x10,%esp
  800544:	89 45 d8             	mov    %eax,-0x28(%ebp)

	int* Right = malloc(sizeof(int) * rightCapacity);
  800547:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80054a:	c1 e0 02             	shl    $0x2,%eax
  80054d:	83 ec 0c             	sub    $0xc,%esp
  800550:	50                   	push   %eax
  800551:	e8 d2 13 00 00       	call   801928 <malloc>
  800556:	83 c4 10             	add    $0x10,%esp
  800559:	89 45 d4             	mov    %eax,-0x2c(%ebp)

	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
  80055c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  800563:	eb 2f                	jmp    800594 <Merge+0x89>
	{
		Left[i] = A[p + i - 1];
  800565:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800568:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80056f:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800572:	01 c2                	add    %eax,%edx
  800574:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800577:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80057a:	01 c8                	add    %ecx,%eax
  80057c:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  800581:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800588:	8b 45 08             	mov    0x8(%ebp),%eax
  80058b:	01 c8                	add    %ecx,%eax
  80058d:	8b 00                	mov    (%eax),%eax
  80058f:	89 02                	mov    %eax,(%edx)
	int* Left = malloc(sizeof(int) * leftCapacity);

	int* Right = malloc(sizeof(int) * rightCapacity);

	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
  800591:	ff 45 ec             	incl   -0x14(%ebp)
  800594:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800597:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  80059a:	7c c9                	jl     800565 <Merge+0x5a>
	{
		Left[i] = A[p + i - 1];
	}
	for (j = 0; j < rightCapacity; j++)
  80059c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8005a3:	eb 2a                	jmp    8005cf <Merge+0xc4>
	{
		Right[j] = A[q + j];
  8005a5:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005a8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005af:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8005b2:	01 c2                	add    %eax,%edx
  8005b4:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8005b7:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005ba:	01 c8                	add    %ecx,%eax
  8005bc:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8005c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8005c6:	01 c8                	add    %ecx,%eax
  8005c8:	8b 00                	mov    (%eax),%eax
  8005ca:	89 02                	mov    %eax,(%edx)
	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
	{
		Left[i] = A[p + i - 1];
	}
	for (j = 0; j < rightCapacity; j++)
  8005cc:	ff 45 e8             	incl   -0x18(%ebp)
  8005cf:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005d2:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  8005d5:	7c ce                	jl     8005a5 <Merge+0x9a>
	{
		Right[j] = A[q + j];
	}

	for ( k = p; k <= r; k++)
  8005d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005da:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8005dd:	e9 0a 01 00 00       	jmp    8006ec <Merge+0x1e1>
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
  8005e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005e5:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8005e8:	0f 8d 95 00 00 00    	jge    800683 <Merge+0x178>
  8005ee:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005f1:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  8005f4:	0f 8d 89 00 00 00    	jge    800683 <Merge+0x178>
		{
			if (Left[leftIndex] < Right[rightIndex] )
  8005fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005fd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800604:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800607:	01 d0                	add    %edx,%eax
  800609:	8b 10                	mov    (%eax),%edx
  80060b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80060e:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800615:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800618:	01 c8                	add    %ecx,%eax
  80061a:	8b 00                	mov    (%eax),%eax
  80061c:	39 c2                	cmp    %eax,%edx
  80061e:	7d 33                	jge    800653 <Merge+0x148>
			{
				A[k - 1] = Left[leftIndex++];
  800620:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800623:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  800628:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80062f:	8b 45 08             	mov    0x8(%ebp),%eax
  800632:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800635:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800638:	8d 50 01             	lea    0x1(%eax),%edx
  80063b:	89 55 f4             	mov    %edx,-0xc(%ebp)
  80063e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800645:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800648:	01 d0                	add    %edx,%eax
  80064a:	8b 00                	mov    (%eax),%eax
  80064c:	89 01                	mov    %eax,(%ecx)

	for ( k = p; k <= r; k++)
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
		{
			if (Left[leftIndex] < Right[rightIndex] )
  80064e:	e9 96 00 00 00       	jmp    8006e9 <Merge+0x1de>
			{
				A[k - 1] = Left[leftIndex++];
			}
			else
			{
				A[k - 1] = Right[rightIndex++];
  800653:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800656:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  80065b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800662:	8b 45 08             	mov    0x8(%ebp),%eax
  800665:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800668:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80066b:	8d 50 01             	lea    0x1(%eax),%edx
  80066e:	89 55 f0             	mov    %edx,-0x10(%ebp)
  800671:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800678:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80067b:	01 d0                	add    %edx,%eax
  80067d:	8b 00                	mov    (%eax),%eax
  80067f:	89 01                	mov    %eax,(%ecx)

	for ( k = p; k <= r; k++)
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
		{
			if (Left[leftIndex] < Right[rightIndex] )
  800681:	eb 66                	jmp    8006e9 <Merge+0x1de>
			else
			{
				A[k - 1] = Right[rightIndex++];
			}
		}
		else if (leftIndex < leftCapacity)
  800683:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800686:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  800689:	7d 30                	jge    8006bb <Merge+0x1b0>
		{
			A[k - 1] = Left[leftIndex++];
  80068b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80068e:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  800693:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80069a:	8b 45 08             	mov    0x8(%ebp),%eax
  80069d:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8006a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8006a3:	8d 50 01             	lea    0x1(%eax),%edx
  8006a6:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8006a9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006b0:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8006b3:	01 d0                	add    %edx,%eax
  8006b5:	8b 00                	mov    (%eax),%eax
  8006b7:	89 01                	mov    %eax,(%ecx)
  8006b9:	eb 2e                	jmp    8006e9 <Merge+0x1de>
		}
		else
		{
			A[k - 1] = Right[rightIndex++];
  8006bb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006be:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  8006c3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8006cd:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8006d0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006d3:	8d 50 01             	lea    0x1(%eax),%edx
  8006d6:	89 55 f0             	mov    %edx,-0x10(%ebp)
  8006d9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006e0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8006e3:	01 d0                	add    %edx,%eax
  8006e5:	8b 00                	mov    (%eax),%eax
  8006e7:	89 01                	mov    %eax,(%ecx)
	for (j = 0; j < rightCapacity; j++)
	{
		Right[j] = A[q + j];
	}

	for ( k = p; k <= r; k++)
  8006e9:	ff 45 e4             	incl   -0x1c(%ebp)
  8006ec:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006ef:	3b 45 14             	cmp    0x14(%ebp),%eax
  8006f2:	0f 8e ea fe ff ff    	jle    8005e2 <Merge+0xd7>
		{
			A[k - 1] = Right[rightIndex++];
		}
	}

	free(Left);
  8006f8:	83 ec 0c             	sub    $0xc,%esp
  8006fb:	ff 75 d8             	pushl  -0x28(%ebp)
  8006fe:	e8 f2 14 00 00       	call   801bf5 <free>
  800703:	83 c4 10             	add    $0x10,%esp
	free(Right);
  800706:	83 ec 0c             	sub    $0xc,%esp
  800709:	ff 75 d4             	pushl  -0x2c(%ebp)
  80070c:	e8 e4 14 00 00       	call   801bf5 <free>
  800711:	83 c4 10             	add    $0x10,%esp

}
  800714:	90                   	nop
  800715:	c9                   	leave  
  800716:	c3                   	ret    

00800717 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  800717:	55                   	push   %ebp
  800718:	89 e5                	mov    %esp,%ebp
  80071a:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  80071d:	8b 45 08             	mov    0x8(%ebp),%eax
  800720:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800723:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800727:	83 ec 0c             	sub    $0xc,%esp
  80072a:	50                   	push   %eax
  80072b:	e8 22 19 00 00       	call   802052 <sys_cputc>
  800730:	83 c4 10             	add    $0x10,%esp
}
  800733:	90                   	nop
  800734:	c9                   	leave  
  800735:	c3                   	ret    

00800736 <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  800736:	55                   	push   %ebp
  800737:	89 e5                	mov    %esp,%ebp
  800739:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80073c:	e8 dd 18 00 00       	call   80201e <sys_disable_interrupt>
	char c = ch;
  800741:	8b 45 08             	mov    0x8(%ebp),%eax
  800744:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800747:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80074b:	83 ec 0c             	sub    $0xc,%esp
  80074e:	50                   	push   %eax
  80074f:	e8 fe 18 00 00       	call   802052 <sys_cputc>
  800754:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800757:	e8 dc 18 00 00       	call   802038 <sys_enable_interrupt>
}
  80075c:	90                   	nop
  80075d:	c9                   	leave  
  80075e:	c3                   	ret    

0080075f <getchar>:

int
getchar(void)
{
  80075f:	55                   	push   %ebp
  800760:	89 e5                	mov    %esp,%ebp
  800762:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  800765:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  80076c:	eb 08                	jmp    800776 <getchar+0x17>
	{
		c = sys_cgetc();
  80076e:	e8 c3 16 00 00       	call   801e36 <sys_cgetc>
  800773:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  800776:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80077a:	74 f2                	je     80076e <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  80077c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80077f:	c9                   	leave  
  800780:	c3                   	ret    

00800781 <atomic_getchar>:

int
atomic_getchar(void)
{
  800781:	55                   	push   %ebp
  800782:	89 e5                	mov    %esp,%ebp
  800784:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800787:	e8 92 18 00 00       	call   80201e <sys_disable_interrupt>
	int c=0;
  80078c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  800793:	eb 08                	jmp    80079d <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  800795:	e8 9c 16 00 00       	call   801e36 <sys_cgetc>
  80079a:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  80079d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8007a1:	74 f2                	je     800795 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  8007a3:	e8 90 18 00 00       	call   802038 <sys_enable_interrupt>
	return c;
  8007a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8007ab:	c9                   	leave  
  8007ac:	c3                   	ret    

008007ad <iscons>:

int iscons(int fdnum)
{
  8007ad:	55                   	push   %ebp
  8007ae:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  8007b0:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8007b5:	5d                   	pop    %ebp
  8007b6:	c3                   	ret    

008007b7 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8007b7:	55                   	push   %ebp
  8007b8:	89 e5                	mov    %esp,%ebp
  8007ba:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8007bd:	e8 c1 16 00 00       	call   801e83 <sys_getenvindex>
  8007c2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8007c5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8007c8:	89 d0                	mov    %edx,%eax
  8007ca:	c1 e0 03             	shl    $0x3,%eax
  8007cd:	01 d0                	add    %edx,%eax
  8007cf:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8007d6:	01 c8                	add    %ecx,%eax
  8007d8:	01 c0                	add    %eax,%eax
  8007da:	01 d0                	add    %edx,%eax
  8007dc:	01 c0                	add    %eax,%eax
  8007de:	01 d0                	add    %edx,%eax
  8007e0:	89 c2                	mov    %eax,%edx
  8007e2:	c1 e2 05             	shl    $0x5,%edx
  8007e5:	29 c2                	sub    %eax,%edx
  8007e7:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  8007ee:	89 c2                	mov    %eax,%edx
  8007f0:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  8007f6:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8007fb:	a1 24 30 80 00       	mov    0x803024,%eax
  800800:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800806:	84 c0                	test   %al,%al
  800808:	74 0f                	je     800819 <libmain+0x62>
		binaryname = myEnv->prog_name;
  80080a:	a1 24 30 80 00       	mov    0x803024,%eax
  80080f:	05 40 3c 01 00       	add    $0x13c40,%eax
  800814:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800819:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80081d:	7e 0a                	jle    800829 <libmain+0x72>
		binaryname = argv[0];
  80081f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800822:	8b 00                	mov    (%eax),%eax
  800824:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800829:	83 ec 08             	sub    $0x8,%esp
  80082c:	ff 75 0c             	pushl  0xc(%ebp)
  80082f:	ff 75 08             	pushl  0x8(%ebp)
  800832:	e8 01 f8 ff ff       	call   800038 <_main>
  800837:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80083a:	e8 df 17 00 00       	call   80201e <sys_disable_interrupt>
	cprintf("**************************************\n");
  80083f:	83 ec 0c             	sub    $0xc,%esp
  800842:	68 b8 28 80 00       	push   $0x8028b8
  800847:	e8 52 03 00 00       	call   800b9e <cprintf>
  80084c:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80084f:	a1 24 30 80 00       	mov    0x803024,%eax
  800854:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  80085a:	a1 24 30 80 00       	mov    0x803024,%eax
  80085f:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800865:	83 ec 04             	sub    $0x4,%esp
  800868:	52                   	push   %edx
  800869:	50                   	push   %eax
  80086a:	68 e0 28 80 00       	push   $0x8028e0
  80086f:	e8 2a 03 00 00       	call   800b9e <cprintf>
  800874:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800877:	a1 24 30 80 00       	mov    0x803024,%eax
  80087c:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800882:	a1 24 30 80 00       	mov    0x803024,%eax
  800887:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  80088d:	83 ec 04             	sub    $0x4,%esp
  800890:	52                   	push   %edx
  800891:	50                   	push   %eax
  800892:	68 08 29 80 00       	push   $0x802908
  800897:	e8 02 03 00 00       	call   800b9e <cprintf>
  80089c:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80089f:	a1 24 30 80 00       	mov    0x803024,%eax
  8008a4:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  8008aa:	83 ec 08             	sub    $0x8,%esp
  8008ad:	50                   	push   %eax
  8008ae:	68 49 29 80 00       	push   $0x802949
  8008b3:	e8 e6 02 00 00       	call   800b9e <cprintf>
  8008b8:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8008bb:	83 ec 0c             	sub    $0xc,%esp
  8008be:	68 b8 28 80 00       	push   $0x8028b8
  8008c3:	e8 d6 02 00 00       	call   800b9e <cprintf>
  8008c8:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8008cb:	e8 68 17 00 00       	call   802038 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8008d0:	e8 19 00 00 00       	call   8008ee <exit>
}
  8008d5:	90                   	nop
  8008d6:	c9                   	leave  
  8008d7:	c3                   	ret    

008008d8 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8008d8:	55                   	push   %ebp
  8008d9:	89 e5                	mov    %esp,%ebp
  8008db:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8008de:	83 ec 0c             	sub    $0xc,%esp
  8008e1:	6a 00                	push   $0x0
  8008e3:	e8 67 15 00 00       	call   801e4f <sys_env_destroy>
  8008e8:	83 c4 10             	add    $0x10,%esp
}
  8008eb:	90                   	nop
  8008ec:	c9                   	leave  
  8008ed:	c3                   	ret    

008008ee <exit>:

void
exit(void)
{
  8008ee:	55                   	push   %ebp
  8008ef:	89 e5                	mov    %esp,%ebp
  8008f1:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8008f4:	e8 bc 15 00 00       	call   801eb5 <sys_env_exit>
}
  8008f9:	90                   	nop
  8008fa:	c9                   	leave  
  8008fb:	c3                   	ret    

008008fc <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8008fc:	55                   	push   %ebp
  8008fd:	89 e5                	mov    %esp,%ebp
  8008ff:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800902:	8d 45 10             	lea    0x10(%ebp),%eax
  800905:	83 c0 04             	add    $0x4,%eax
  800908:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80090b:	a1 18 31 80 00       	mov    0x803118,%eax
  800910:	85 c0                	test   %eax,%eax
  800912:	74 16                	je     80092a <_panic+0x2e>
		cprintf("%s: ", argv0);
  800914:	a1 18 31 80 00       	mov    0x803118,%eax
  800919:	83 ec 08             	sub    $0x8,%esp
  80091c:	50                   	push   %eax
  80091d:	68 60 29 80 00       	push   $0x802960
  800922:	e8 77 02 00 00       	call   800b9e <cprintf>
  800927:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80092a:	a1 00 30 80 00       	mov    0x803000,%eax
  80092f:	ff 75 0c             	pushl  0xc(%ebp)
  800932:	ff 75 08             	pushl  0x8(%ebp)
  800935:	50                   	push   %eax
  800936:	68 65 29 80 00       	push   $0x802965
  80093b:	e8 5e 02 00 00       	call   800b9e <cprintf>
  800940:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800943:	8b 45 10             	mov    0x10(%ebp),%eax
  800946:	83 ec 08             	sub    $0x8,%esp
  800949:	ff 75 f4             	pushl  -0xc(%ebp)
  80094c:	50                   	push   %eax
  80094d:	e8 e1 01 00 00       	call   800b33 <vcprintf>
  800952:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800955:	83 ec 08             	sub    $0x8,%esp
  800958:	6a 00                	push   $0x0
  80095a:	68 81 29 80 00       	push   $0x802981
  80095f:	e8 cf 01 00 00       	call   800b33 <vcprintf>
  800964:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800967:	e8 82 ff ff ff       	call   8008ee <exit>

	// should not return here
	while (1) ;
  80096c:	eb fe                	jmp    80096c <_panic+0x70>

0080096e <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80096e:	55                   	push   %ebp
  80096f:	89 e5                	mov    %esp,%ebp
  800971:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800974:	a1 24 30 80 00       	mov    0x803024,%eax
  800979:	8b 50 74             	mov    0x74(%eax),%edx
  80097c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80097f:	39 c2                	cmp    %eax,%edx
  800981:	74 14                	je     800997 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800983:	83 ec 04             	sub    $0x4,%esp
  800986:	68 84 29 80 00       	push   $0x802984
  80098b:	6a 26                	push   $0x26
  80098d:	68 d0 29 80 00       	push   $0x8029d0
  800992:	e8 65 ff ff ff       	call   8008fc <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800997:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80099e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8009a5:	e9 b6 00 00 00       	jmp    800a60 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  8009aa:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009ad:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8009b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b7:	01 d0                	add    %edx,%eax
  8009b9:	8b 00                	mov    (%eax),%eax
  8009bb:	85 c0                	test   %eax,%eax
  8009bd:	75 08                	jne    8009c7 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8009bf:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8009c2:	e9 96 00 00 00       	jmp    800a5d <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  8009c7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8009ce:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8009d5:	eb 5d                	jmp    800a34 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8009d7:	a1 24 30 80 00       	mov    0x803024,%eax
  8009dc:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8009e2:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8009e5:	c1 e2 04             	shl    $0x4,%edx
  8009e8:	01 d0                	add    %edx,%eax
  8009ea:	8a 40 04             	mov    0x4(%eax),%al
  8009ed:	84 c0                	test   %al,%al
  8009ef:	75 40                	jne    800a31 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8009f1:	a1 24 30 80 00       	mov    0x803024,%eax
  8009f6:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8009fc:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8009ff:	c1 e2 04             	shl    $0x4,%edx
  800a02:	01 d0                	add    %edx,%eax
  800a04:	8b 00                	mov    (%eax),%eax
  800a06:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800a09:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800a0c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800a11:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800a13:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a16:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800a1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800a20:	01 c8                	add    %ecx,%eax
  800a22:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800a24:	39 c2                	cmp    %eax,%edx
  800a26:	75 09                	jne    800a31 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  800a28:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800a2f:	eb 12                	jmp    800a43 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a31:	ff 45 e8             	incl   -0x18(%ebp)
  800a34:	a1 24 30 80 00       	mov    0x803024,%eax
  800a39:	8b 50 74             	mov    0x74(%eax),%edx
  800a3c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800a3f:	39 c2                	cmp    %eax,%edx
  800a41:	77 94                	ja     8009d7 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800a43:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800a47:	75 14                	jne    800a5d <CheckWSWithoutLastIndex+0xef>
			panic(
  800a49:	83 ec 04             	sub    $0x4,%esp
  800a4c:	68 dc 29 80 00       	push   $0x8029dc
  800a51:	6a 3a                	push   $0x3a
  800a53:	68 d0 29 80 00       	push   $0x8029d0
  800a58:	e8 9f fe ff ff       	call   8008fc <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800a5d:	ff 45 f0             	incl   -0x10(%ebp)
  800a60:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a63:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800a66:	0f 8c 3e ff ff ff    	jl     8009aa <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800a6c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a73:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800a7a:	eb 20                	jmp    800a9c <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800a7c:	a1 24 30 80 00       	mov    0x803024,%eax
  800a81:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800a87:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a8a:	c1 e2 04             	shl    $0x4,%edx
  800a8d:	01 d0                	add    %edx,%eax
  800a8f:	8a 40 04             	mov    0x4(%eax),%al
  800a92:	3c 01                	cmp    $0x1,%al
  800a94:	75 03                	jne    800a99 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  800a96:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a99:	ff 45 e0             	incl   -0x20(%ebp)
  800a9c:	a1 24 30 80 00       	mov    0x803024,%eax
  800aa1:	8b 50 74             	mov    0x74(%eax),%edx
  800aa4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800aa7:	39 c2                	cmp    %eax,%edx
  800aa9:	77 d1                	ja     800a7c <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800aab:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800aae:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800ab1:	74 14                	je     800ac7 <CheckWSWithoutLastIndex+0x159>
		panic(
  800ab3:	83 ec 04             	sub    $0x4,%esp
  800ab6:	68 30 2a 80 00       	push   $0x802a30
  800abb:	6a 44                	push   $0x44
  800abd:	68 d0 29 80 00       	push   $0x8029d0
  800ac2:	e8 35 fe ff ff       	call   8008fc <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800ac7:	90                   	nop
  800ac8:	c9                   	leave  
  800ac9:	c3                   	ret    

00800aca <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800aca:	55                   	push   %ebp
  800acb:	89 e5                	mov    %esp,%ebp
  800acd:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800ad0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ad3:	8b 00                	mov    (%eax),%eax
  800ad5:	8d 48 01             	lea    0x1(%eax),%ecx
  800ad8:	8b 55 0c             	mov    0xc(%ebp),%edx
  800adb:	89 0a                	mov    %ecx,(%edx)
  800add:	8b 55 08             	mov    0x8(%ebp),%edx
  800ae0:	88 d1                	mov    %dl,%cl
  800ae2:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ae5:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800ae9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aec:	8b 00                	mov    (%eax),%eax
  800aee:	3d ff 00 00 00       	cmp    $0xff,%eax
  800af3:	75 2c                	jne    800b21 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800af5:	a0 28 30 80 00       	mov    0x803028,%al
  800afa:	0f b6 c0             	movzbl %al,%eax
  800afd:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b00:	8b 12                	mov    (%edx),%edx
  800b02:	89 d1                	mov    %edx,%ecx
  800b04:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b07:	83 c2 08             	add    $0x8,%edx
  800b0a:	83 ec 04             	sub    $0x4,%esp
  800b0d:	50                   	push   %eax
  800b0e:	51                   	push   %ecx
  800b0f:	52                   	push   %edx
  800b10:	e8 f8 12 00 00       	call   801e0d <sys_cputs>
  800b15:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800b18:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b1b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800b21:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b24:	8b 40 04             	mov    0x4(%eax),%eax
  800b27:	8d 50 01             	lea    0x1(%eax),%edx
  800b2a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b2d:	89 50 04             	mov    %edx,0x4(%eax)
}
  800b30:	90                   	nop
  800b31:	c9                   	leave  
  800b32:	c3                   	ret    

00800b33 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800b33:	55                   	push   %ebp
  800b34:	89 e5                	mov    %esp,%ebp
  800b36:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800b3c:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800b43:	00 00 00 
	b.cnt = 0;
  800b46:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800b4d:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800b50:	ff 75 0c             	pushl  0xc(%ebp)
  800b53:	ff 75 08             	pushl  0x8(%ebp)
  800b56:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800b5c:	50                   	push   %eax
  800b5d:	68 ca 0a 80 00       	push   $0x800aca
  800b62:	e8 11 02 00 00       	call   800d78 <vprintfmt>
  800b67:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800b6a:	a0 28 30 80 00       	mov    0x803028,%al
  800b6f:	0f b6 c0             	movzbl %al,%eax
  800b72:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800b78:	83 ec 04             	sub    $0x4,%esp
  800b7b:	50                   	push   %eax
  800b7c:	52                   	push   %edx
  800b7d:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800b83:	83 c0 08             	add    $0x8,%eax
  800b86:	50                   	push   %eax
  800b87:	e8 81 12 00 00       	call   801e0d <sys_cputs>
  800b8c:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800b8f:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  800b96:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800b9c:	c9                   	leave  
  800b9d:	c3                   	ret    

00800b9e <cprintf>:

int cprintf(const char *fmt, ...) {
  800b9e:	55                   	push   %ebp
  800b9f:	89 e5                	mov    %esp,%ebp
  800ba1:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800ba4:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  800bab:	8d 45 0c             	lea    0xc(%ebp),%eax
  800bae:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800bb1:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb4:	83 ec 08             	sub    $0x8,%esp
  800bb7:	ff 75 f4             	pushl  -0xc(%ebp)
  800bba:	50                   	push   %eax
  800bbb:	e8 73 ff ff ff       	call   800b33 <vcprintf>
  800bc0:	83 c4 10             	add    $0x10,%esp
  800bc3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800bc6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800bc9:	c9                   	leave  
  800bca:	c3                   	ret    

00800bcb <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800bcb:	55                   	push   %ebp
  800bcc:	89 e5                	mov    %esp,%ebp
  800bce:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800bd1:	e8 48 14 00 00       	call   80201e <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800bd6:	8d 45 0c             	lea    0xc(%ebp),%eax
  800bd9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800bdc:	8b 45 08             	mov    0x8(%ebp),%eax
  800bdf:	83 ec 08             	sub    $0x8,%esp
  800be2:	ff 75 f4             	pushl  -0xc(%ebp)
  800be5:	50                   	push   %eax
  800be6:	e8 48 ff ff ff       	call   800b33 <vcprintf>
  800beb:	83 c4 10             	add    $0x10,%esp
  800bee:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800bf1:	e8 42 14 00 00       	call   802038 <sys_enable_interrupt>
	return cnt;
  800bf6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800bf9:	c9                   	leave  
  800bfa:	c3                   	ret    

00800bfb <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800bfb:	55                   	push   %ebp
  800bfc:	89 e5                	mov    %esp,%ebp
  800bfe:	53                   	push   %ebx
  800bff:	83 ec 14             	sub    $0x14,%esp
  800c02:	8b 45 10             	mov    0x10(%ebp),%eax
  800c05:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c08:	8b 45 14             	mov    0x14(%ebp),%eax
  800c0b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800c0e:	8b 45 18             	mov    0x18(%ebp),%eax
  800c11:	ba 00 00 00 00       	mov    $0x0,%edx
  800c16:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800c19:	77 55                	ja     800c70 <printnum+0x75>
  800c1b:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800c1e:	72 05                	jb     800c25 <printnum+0x2a>
  800c20:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800c23:	77 4b                	ja     800c70 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800c25:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800c28:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800c2b:	8b 45 18             	mov    0x18(%ebp),%eax
  800c2e:	ba 00 00 00 00       	mov    $0x0,%edx
  800c33:	52                   	push   %edx
  800c34:	50                   	push   %eax
  800c35:	ff 75 f4             	pushl  -0xc(%ebp)
  800c38:	ff 75 f0             	pushl  -0x10(%ebp)
  800c3b:	e8 00 18 00 00       	call   802440 <__udivdi3>
  800c40:	83 c4 10             	add    $0x10,%esp
  800c43:	83 ec 04             	sub    $0x4,%esp
  800c46:	ff 75 20             	pushl  0x20(%ebp)
  800c49:	53                   	push   %ebx
  800c4a:	ff 75 18             	pushl  0x18(%ebp)
  800c4d:	52                   	push   %edx
  800c4e:	50                   	push   %eax
  800c4f:	ff 75 0c             	pushl  0xc(%ebp)
  800c52:	ff 75 08             	pushl  0x8(%ebp)
  800c55:	e8 a1 ff ff ff       	call   800bfb <printnum>
  800c5a:	83 c4 20             	add    $0x20,%esp
  800c5d:	eb 1a                	jmp    800c79 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800c5f:	83 ec 08             	sub    $0x8,%esp
  800c62:	ff 75 0c             	pushl  0xc(%ebp)
  800c65:	ff 75 20             	pushl  0x20(%ebp)
  800c68:	8b 45 08             	mov    0x8(%ebp),%eax
  800c6b:	ff d0                	call   *%eax
  800c6d:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800c70:	ff 4d 1c             	decl   0x1c(%ebp)
  800c73:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800c77:	7f e6                	jg     800c5f <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800c79:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800c7c:	bb 00 00 00 00       	mov    $0x0,%ebx
  800c81:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c84:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c87:	53                   	push   %ebx
  800c88:	51                   	push   %ecx
  800c89:	52                   	push   %edx
  800c8a:	50                   	push   %eax
  800c8b:	e8 c0 18 00 00       	call   802550 <__umoddi3>
  800c90:	83 c4 10             	add    $0x10,%esp
  800c93:	05 94 2c 80 00       	add    $0x802c94,%eax
  800c98:	8a 00                	mov    (%eax),%al
  800c9a:	0f be c0             	movsbl %al,%eax
  800c9d:	83 ec 08             	sub    $0x8,%esp
  800ca0:	ff 75 0c             	pushl  0xc(%ebp)
  800ca3:	50                   	push   %eax
  800ca4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca7:	ff d0                	call   *%eax
  800ca9:	83 c4 10             	add    $0x10,%esp
}
  800cac:	90                   	nop
  800cad:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800cb0:	c9                   	leave  
  800cb1:	c3                   	ret    

00800cb2 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800cb2:	55                   	push   %ebp
  800cb3:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800cb5:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800cb9:	7e 1c                	jle    800cd7 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800cbb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cbe:	8b 00                	mov    (%eax),%eax
  800cc0:	8d 50 08             	lea    0x8(%eax),%edx
  800cc3:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc6:	89 10                	mov    %edx,(%eax)
  800cc8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccb:	8b 00                	mov    (%eax),%eax
  800ccd:	83 e8 08             	sub    $0x8,%eax
  800cd0:	8b 50 04             	mov    0x4(%eax),%edx
  800cd3:	8b 00                	mov    (%eax),%eax
  800cd5:	eb 40                	jmp    800d17 <getuint+0x65>
	else if (lflag)
  800cd7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800cdb:	74 1e                	je     800cfb <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800cdd:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce0:	8b 00                	mov    (%eax),%eax
  800ce2:	8d 50 04             	lea    0x4(%eax),%edx
  800ce5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce8:	89 10                	mov    %edx,(%eax)
  800cea:	8b 45 08             	mov    0x8(%ebp),%eax
  800ced:	8b 00                	mov    (%eax),%eax
  800cef:	83 e8 04             	sub    $0x4,%eax
  800cf2:	8b 00                	mov    (%eax),%eax
  800cf4:	ba 00 00 00 00       	mov    $0x0,%edx
  800cf9:	eb 1c                	jmp    800d17 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800cfb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfe:	8b 00                	mov    (%eax),%eax
  800d00:	8d 50 04             	lea    0x4(%eax),%edx
  800d03:	8b 45 08             	mov    0x8(%ebp),%eax
  800d06:	89 10                	mov    %edx,(%eax)
  800d08:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0b:	8b 00                	mov    (%eax),%eax
  800d0d:	83 e8 04             	sub    $0x4,%eax
  800d10:	8b 00                	mov    (%eax),%eax
  800d12:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800d17:	5d                   	pop    %ebp
  800d18:	c3                   	ret    

00800d19 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800d19:	55                   	push   %ebp
  800d1a:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800d1c:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800d20:	7e 1c                	jle    800d3e <getint+0x25>
		return va_arg(*ap, long long);
  800d22:	8b 45 08             	mov    0x8(%ebp),%eax
  800d25:	8b 00                	mov    (%eax),%eax
  800d27:	8d 50 08             	lea    0x8(%eax),%edx
  800d2a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2d:	89 10                	mov    %edx,(%eax)
  800d2f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d32:	8b 00                	mov    (%eax),%eax
  800d34:	83 e8 08             	sub    $0x8,%eax
  800d37:	8b 50 04             	mov    0x4(%eax),%edx
  800d3a:	8b 00                	mov    (%eax),%eax
  800d3c:	eb 38                	jmp    800d76 <getint+0x5d>
	else if (lflag)
  800d3e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d42:	74 1a                	je     800d5e <getint+0x45>
		return va_arg(*ap, long);
  800d44:	8b 45 08             	mov    0x8(%ebp),%eax
  800d47:	8b 00                	mov    (%eax),%eax
  800d49:	8d 50 04             	lea    0x4(%eax),%edx
  800d4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4f:	89 10                	mov    %edx,(%eax)
  800d51:	8b 45 08             	mov    0x8(%ebp),%eax
  800d54:	8b 00                	mov    (%eax),%eax
  800d56:	83 e8 04             	sub    $0x4,%eax
  800d59:	8b 00                	mov    (%eax),%eax
  800d5b:	99                   	cltd   
  800d5c:	eb 18                	jmp    800d76 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800d5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d61:	8b 00                	mov    (%eax),%eax
  800d63:	8d 50 04             	lea    0x4(%eax),%edx
  800d66:	8b 45 08             	mov    0x8(%ebp),%eax
  800d69:	89 10                	mov    %edx,(%eax)
  800d6b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6e:	8b 00                	mov    (%eax),%eax
  800d70:	83 e8 04             	sub    $0x4,%eax
  800d73:	8b 00                	mov    (%eax),%eax
  800d75:	99                   	cltd   
}
  800d76:	5d                   	pop    %ebp
  800d77:	c3                   	ret    

00800d78 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800d78:	55                   	push   %ebp
  800d79:	89 e5                	mov    %esp,%ebp
  800d7b:	56                   	push   %esi
  800d7c:	53                   	push   %ebx
  800d7d:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800d80:	eb 17                	jmp    800d99 <vprintfmt+0x21>
			if (ch == '\0')
  800d82:	85 db                	test   %ebx,%ebx
  800d84:	0f 84 af 03 00 00    	je     801139 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800d8a:	83 ec 08             	sub    $0x8,%esp
  800d8d:	ff 75 0c             	pushl  0xc(%ebp)
  800d90:	53                   	push   %ebx
  800d91:	8b 45 08             	mov    0x8(%ebp),%eax
  800d94:	ff d0                	call   *%eax
  800d96:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800d99:	8b 45 10             	mov    0x10(%ebp),%eax
  800d9c:	8d 50 01             	lea    0x1(%eax),%edx
  800d9f:	89 55 10             	mov    %edx,0x10(%ebp)
  800da2:	8a 00                	mov    (%eax),%al
  800da4:	0f b6 d8             	movzbl %al,%ebx
  800da7:	83 fb 25             	cmp    $0x25,%ebx
  800daa:	75 d6                	jne    800d82 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800dac:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800db0:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800db7:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800dbe:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800dc5:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800dcc:	8b 45 10             	mov    0x10(%ebp),%eax
  800dcf:	8d 50 01             	lea    0x1(%eax),%edx
  800dd2:	89 55 10             	mov    %edx,0x10(%ebp)
  800dd5:	8a 00                	mov    (%eax),%al
  800dd7:	0f b6 d8             	movzbl %al,%ebx
  800dda:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800ddd:	83 f8 55             	cmp    $0x55,%eax
  800de0:	0f 87 2b 03 00 00    	ja     801111 <vprintfmt+0x399>
  800de6:	8b 04 85 b8 2c 80 00 	mov    0x802cb8(,%eax,4),%eax
  800ded:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800def:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800df3:	eb d7                	jmp    800dcc <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800df5:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800df9:	eb d1                	jmp    800dcc <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800dfb:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800e02:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800e05:	89 d0                	mov    %edx,%eax
  800e07:	c1 e0 02             	shl    $0x2,%eax
  800e0a:	01 d0                	add    %edx,%eax
  800e0c:	01 c0                	add    %eax,%eax
  800e0e:	01 d8                	add    %ebx,%eax
  800e10:	83 e8 30             	sub    $0x30,%eax
  800e13:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800e16:	8b 45 10             	mov    0x10(%ebp),%eax
  800e19:	8a 00                	mov    (%eax),%al
  800e1b:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800e1e:	83 fb 2f             	cmp    $0x2f,%ebx
  800e21:	7e 3e                	jle    800e61 <vprintfmt+0xe9>
  800e23:	83 fb 39             	cmp    $0x39,%ebx
  800e26:	7f 39                	jg     800e61 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800e28:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800e2b:	eb d5                	jmp    800e02 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800e2d:	8b 45 14             	mov    0x14(%ebp),%eax
  800e30:	83 c0 04             	add    $0x4,%eax
  800e33:	89 45 14             	mov    %eax,0x14(%ebp)
  800e36:	8b 45 14             	mov    0x14(%ebp),%eax
  800e39:	83 e8 04             	sub    $0x4,%eax
  800e3c:	8b 00                	mov    (%eax),%eax
  800e3e:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800e41:	eb 1f                	jmp    800e62 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800e43:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e47:	79 83                	jns    800dcc <vprintfmt+0x54>
				width = 0;
  800e49:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800e50:	e9 77 ff ff ff       	jmp    800dcc <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800e55:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800e5c:	e9 6b ff ff ff       	jmp    800dcc <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800e61:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800e62:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e66:	0f 89 60 ff ff ff    	jns    800dcc <vprintfmt+0x54>
				width = precision, precision = -1;
  800e6c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800e6f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800e72:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800e79:	e9 4e ff ff ff       	jmp    800dcc <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800e7e:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800e81:	e9 46 ff ff ff       	jmp    800dcc <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800e86:	8b 45 14             	mov    0x14(%ebp),%eax
  800e89:	83 c0 04             	add    $0x4,%eax
  800e8c:	89 45 14             	mov    %eax,0x14(%ebp)
  800e8f:	8b 45 14             	mov    0x14(%ebp),%eax
  800e92:	83 e8 04             	sub    $0x4,%eax
  800e95:	8b 00                	mov    (%eax),%eax
  800e97:	83 ec 08             	sub    $0x8,%esp
  800e9a:	ff 75 0c             	pushl  0xc(%ebp)
  800e9d:	50                   	push   %eax
  800e9e:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea1:	ff d0                	call   *%eax
  800ea3:	83 c4 10             	add    $0x10,%esp
			break;
  800ea6:	e9 89 02 00 00       	jmp    801134 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800eab:	8b 45 14             	mov    0x14(%ebp),%eax
  800eae:	83 c0 04             	add    $0x4,%eax
  800eb1:	89 45 14             	mov    %eax,0x14(%ebp)
  800eb4:	8b 45 14             	mov    0x14(%ebp),%eax
  800eb7:	83 e8 04             	sub    $0x4,%eax
  800eba:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800ebc:	85 db                	test   %ebx,%ebx
  800ebe:	79 02                	jns    800ec2 <vprintfmt+0x14a>
				err = -err;
  800ec0:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800ec2:	83 fb 64             	cmp    $0x64,%ebx
  800ec5:	7f 0b                	jg     800ed2 <vprintfmt+0x15a>
  800ec7:	8b 34 9d 00 2b 80 00 	mov    0x802b00(,%ebx,4),%esi
  800ece:	85 f6                	test   %esi,%esi
  800ed0:	75 19                	jne    800eeb <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800ed2:	53                   	push   %ebx
  800ed3:	68 a5 2c 80 00       	push   $0x802ca5
  800ed8:	ff 75 0c             	pushl  0xc(%ebp)
  800edb:	ff 75 08             	pushl  0x8(%ebp)
  800ede:	e8 5e 02 00 00       	call   801141 <printfmt>
  800ee3:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800ee6:	e9 49 02 00 00       	jmp    801134 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800eeb:	56                   	push   %esi
  800eec:	68 ae 2c 80 00       	push   $0x802cae
  800ef1:	ff 75 0c             	pushl  0xc(%ebp)
  800ef4:	ff 75 08             	pushl  0x8(%ebp)
  800ef7:	e8 45 02 00 00       	call   801141 <printfmt>
  800efc:	83 c4 10             	add    $0x10,%esp
			break;
  800eff:	e9 30 02 00 00       	jmp    801134 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800f04:	8b 45 14             	mov    0x14(%ebp),%eax
  800f07:	83 c0 04             	add    $0x4,%eax
  800f0a:	89 45 14             	mov    %eax,0x14(%ebp)
  800f0d:	8b 45 14             	mov    0x14(%ebp),%eax
  800f10:	83 e8 04             	sub    $0x4,%eax
  800f13:	8b 30                	mov    (%eax),%esi
  800f15:	85 f6                	test   %esi,%esi
  800f17:	75 05                	jne    800f1e <vprintfmt+0x1a6>
				p = "(null)";
  800f19:	be b1 2c 80 00       	mov    $0x802cb1,%esi
			if (width > 0 && padc != '-')
  800f1e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f22:	7e 6d                	jle    800f91 <vprintfmt+0x219>
  800f24:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800f28:	74 67                	je     800f91 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800f2a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800f2d:	83 ec 08             	sub    $0x8,%esp
  800f30:	50                   	push   %eax
  800f31:	56                   	push   %esi
  800f32:	e8 0c 03 00 00       	call   801243 <strnlen>
  800f37:	83 c4 10             	add    $0x10,%esp
  800f3a:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800f3d:	eb 16                	jmp    800f55 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800f3f:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800f43:	83 ec 08             	sub    $0x8,%esp
  800f46:	ff 75 0c             	pushl  0xc(%ebp)
  800f49:	50                   	push   %eax
  800f4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4d:	ff d0                	call   *%eax
  800f4f:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800f52:	ff 4d e4             	decl   -0x1c(%ebp)
  800f55:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f59:	7f e4                	jg     800f3f <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800f5b:	eb 34                	jmp    800f91 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800f5d:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800f61:	74 1c                	je     800f7f <vprintfmt+0x207>
  800f63:	83 fb 1f             	cmp    $0x1f,%ebx
  800f66:	7e 05                	jle    800f6d <vprintfmt+0x1f5>
  800f68:	83 fb 7e             	cmp    $0x7e,%ebx
  800f6b:	7e 12                	jle    800f7f <vprintfmt+0x207>
					putch('?', putdat);
  800f6d:	83 ec 08             	sub    $0x8,%esp
  800f70:	ff 75 0c             	pushl  0xc(%ebp)
  800f73:	6a 3f                	push   $0x3f
  800f75:	8b 45 08             	mov    0x8(%ebp),%eax
  800f78:	ff d0                	call   *%eax
  800f7a:	83 c4 10             	add    $0x10,%esp
  800f7d:	eb 0f                	jmp    800f8e <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800f7f:	83 ec 08             	sub    $0x8,%esp
  800f82:	ff 75 0c             	pushl  0xc(%ebp)
  800f85:	53                   	push   %ebx
  800f86:	8b 45 08             	mov    0x8(%ebp),%eax
  800f89:	ff d0                	call   *%eax
  800f8b:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800f8e:	ff 4d e4             	decl   -0x1c(%ebp)
  800f91:	89 f0                	mov    %esi,%eax
  800f93:	8d 70 01             	lea    0x1(%eax),%esi
  800f96:	8a 00                	mov    (%eax),%al
  800f98:	0f be d8             	movsbl %al,%ebx
  800f9b:	85 db                	test   %ebx,%ebx
  800f9d:	74 24                	je     800fc3 <vprintfmt+0x24b>
  800f9f:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800fa3:	78 b8                	js     800f5d <vprintfmt+0x1e5>
  800fa5:	ff 4d e0             	decl   -0x20(%ebp)
  800fa8:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800fac:	79 af                	jns    800f5d <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800fae:	eb 13                	jmp    800fc3 <vprintfmt+0x24b>
				putch(' ', putdat);
  800fb0:	83 ec 08             	sub    $0x8,%esp
  800fb3:	ff 75 0c             	pushl  0xc(%ebp)
  800fb6:	6a 20                	push   $0x20
  800fb8:	8b 45 08             	mov    0x8(%ebp),%eax
  800fbb:	ff d0                	call   *%eax
  800fbd:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800fc0:	ff 4d e4             	decl   -0x1c(%ebp)
  800fc3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800fc7:	7f e7                	jg     800fb0 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800fc9:	e9 66 01 00 00       	jmp    801134 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800fce:	83 ec 08             	sub    $0x8,%esp
  800fd1:	ff 75 e8             	pushl  -0x18(%ebp)
  800fd4:	8d 45 14             	lea    0x14(%ebp),%eax
  800fd7:	50                   	push   %eax
  800fd8:	e8 3c fd ff ff       	call   800d19 <getint>
  800fdd:	83 c4 10             	add    $0x10,%esp
  800fe0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fe3:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800fe6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fe9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fec:	85 d2                	test   %edx,%edx
  800fee:	79 23                	jns    801013 <vprintfmt+0x29b>
				putch('-', putdat);
  800ff0:	83 ec 08             	sub    $0x8,%esp
  800ff3:	ff 75 0c             	pushl  0xc(%ebp)
  800ff6:	6a 2d                	push   $0x2d
  800ff8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ffb:	ff d0                	call   *%eax
  800ffd:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  801000:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801003:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801006:	f7 d8                	neg    %eax
  801008:	83 d2 00             	adc    $0x0,%edx
  80100b:	f7 da                	neg    %edx
  80100d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801010:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  801013:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80101a:	e9 bc 00 00 00       	jmp    8010db <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  80101f:	83 ec 08             	sub    $0x8,%esp
  801022:	ff 75 e8             	pushl  -0x18(%ebp)
  801025:	8d 45 14             	lea    0x14(%ebp),%eax
  801028:	50                   	push   %eax
  801029:	e8 84 fc ff ff       	call   800cb2 <getuint>
  80102e:	83 c4 10             	add    $0x10,%esp
  801031:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801034:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  801037:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80103e:	e9 98 00 00 00       	jmp    8010db <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  801043:	83 ec 08             	sub    $0x8,%esp
  801046:	ff 75 0c             	pushl  0xc(%ebp)
  801049:	6a 58                	push   $0x58
  80104b:	8b 45 08             	mov    0x8(%ebp),%eax
  80104e:	ff d0                	call   *%eax
  801050:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801053:	83 ec 08             	sub    $0x8,%esp
  801056:	ff 75 0c             	pushl  0xc(%ebp)
  801059:	6a 58                	push   $0x58
  80105b:	8b 45 08             	mov    0x8(%ebp),%eax
  80105e:	ff d0                	call   *%eax
  801060:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801063:	83 ec 08             	sub    $0x8,%esp
  801066:	ff 75 0c             	pushl  0xc(%ebp)
  801069:	6a 58                	push   $0x58
  80106b:	8b 45 08             	mov    0x8(%ebp),%eax
  80106e:	ff d0                	call   *%eax
  801070:	83 c4 10             	add    $0x10,%esp
			break;
  801073:	e9 bc 00 00 00       	jmp    801134 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  801078:	83 ec 08             	sub    $0x8,%esp
  80107b:	ff 75 0c             	pushl  0xc(%ebp)
  80107e:	6a 30                	push   $0x30
  801080:	8b 45 08             	mov    0x8(%ebp),%eax
  801083:	ff d0                	call   *%eax
  801085:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  801088:	83 ec 08             	sub    $0x8,%esp
  80108b:	ff 75 0c             	pushl  0xc(%ebp)
  80108e:	6a 78                	push   $0x78
  801090:	8b 45 08             	mov    0x8(%ebp),%eax
  801093:	ff d0                	call   *%eax
  801095:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  801098:	8b 45 14             	mov    0x14(%ebp),%eax
  80109b:	83 c0 04             	add    $0x4,%eax
  80109e:	89 45 14             	mov    %eax,0x14(%ebp)
  8010a1:	8b 45 14             	mov    0x14(%ebp),%eax
  8010a4:	83 e8 04             	sub    $0x4,%eax
  8010a7:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8010a9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010ac:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8010b3:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8010ba:	eb 1f                	jmp    8010db <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8010bc:	83 ec 08             	sub    $0x8,%esp
  8010bf:	ff 75 e8             	pushl  -0x18(%ebp)
  8010c2:	8d 45 14             	lea    0x14(%ebp),%eax
  8010c5:	50                   	push   %eax
  8010c6:	e8 e7 fb ff ff       	call   800cb2 <getuint>
  8010cb:	83 c4 10             	add    $0x10,%esp
  8010ce:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010d1:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8010d4:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8010db:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8010df:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8010e2:	83 ec 04             	sub    $0x4,%esp
  8010e5:	52                   	push   %edx
  8010e6:	ff 75 e4             	pushl  -0x1c(%ebp)
  8010e9:	50                   	push   %eax
  8010ea:	ff 75 f4             	pushl  -0xc(%ebp)
  8010ed:	ff 75 f0             	pushl  -0x10(%ebp)
  8010f0:	ff 75 0c             	pushl  0xc(%ebp)
  8010f3:	ff 75 08             	pushl  0x8(%ebp)
  8010f6:	e8 00 fb ff ff       	call   800bfb <printnum>
  8010fb:	83 c4 20             	add    $0x20,%esp
			break;
  8010fe:	eb 34                	jmp    801134 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  801100:	83 ec 08             	sub    $0x8,%esp
  801103:	ff 75 0c             	pushl  0xc(%ebp)
  801106:	53                   	push   %ebx
  801107:	8b 45 08             	mov    0x8(%ebp),%eax
  80110a:	ff d0                	call   *%eax
  80110c:	83 c4 10             	add    $0x10,%esp
			break;
  80110f:	eb 23                	jmp    801134 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  801111:	83 ec 08             	sub    $0x8,%esp
  801114:	ff 75 0c             	pushl  0xc(%ebp)
  801117:	6a 25                	push   $0x25
  801119:	8b 45 08             	mov    0x8(%ebp),%eax
  80111c:	ff d0                	call   *%eax
  80111e:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801121:	ff 4d 10             	decl   0x10(%ebp)
  801124:	eb 03                	jmp    801129 <vprintfmt+0x3b1>
  801126:	ff 4d 10             	decl   0x10(%ebp)
  801129:	8b 45 10             	mov    0x10(%ebp),%eax
  80112c:	48                   	dec    %eax
  80112d:	8a 00                	mov    (%eax),%al
  80112f:	3c 25                	cmp    $0x25,%al
  801131:	75 f3                	jne    801126 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  801133:	90                   	nop
		}
	}
  801134:	e9 47 fc ff ff       	jmp    800d80 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801139:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  80113a:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80113d:	5b                   	pop    %ebx
  80113e:	5e                   	pop    %esi
  80113f:	5d                   	pop    %ebp
  801140:	c3                   	ret    

00801141 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801141:	55                   	push   %ebp
  801142:	89 e5                	mov    %esp,%ebp
  801144:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801147:	8d 45 10             	lea    0x10(%ebp),%eax
  80114a:	83 c0 04             	add    $0x4,%eax
  80114d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801150:	8b 45 10             	mov    0x10(%ebp),%eax
  801153:	ff 75 f4             	pushl  -0xc(%ebp)
  801156:	50                   	push   %eax
  801157:	ff 75 0c             	pushl  0xc(%ebp)
  80115a:	ff 75 08             	pushl  0x8(%ebp)
  80115d:	e8 16 fc ff ff       	call   800d78 <vprintfmt>
  801162:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801165:	90                   	nop
  801166:	c9                   	leave  
  801167:	c3                   	ret    

00801168 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801168:	55                   	push   %ebp
  801169:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80116b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80116e:	8b 40 08             	mov    0x8(%eax),%eax
  801171:	8d 50 01             	lea    0x1(%eax),%edx
  801174:	8b 45 0c             	mov    0xc(%ebp),%eax
  801177:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80117a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80117d:	8b 10                	mov    (%eax),%edx
  80117f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801182:	8b 40 04             	mov    0x4(%eax),%eax
  801185:	39 c2                	cmp    %eax,%edx
  801187:	73 12                	jae    80119b <sprintputch+0x33>
		*b->buf++ = ch;
  801189:	8b 45 0c             	mov    0xc(%ebp),%eax
  80118c:	8b 00                	mov    (%eax),%eax
  80118e:	8d 48 01             	lea    0x1(%eax),%ecx
  801191:	8b 55 0c             	mov    0xc(%ebp),%edx
  801194:	89 0a                	mov    %ecx,(%edx)
  801196:	8b 55 08             	mov    0x8(%ebp),%edx
  801199:	88 10                	mov    %dl,(%eax)
}
  80119b:	90                   	nop
  80119c:	5d                   	pop    %ebp
  80119d:	c3                   	ret    

0080119e <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  80119e:	55                   	push   %ebp
  80119f:	89 e5                	mov    %esp,%ebp
  8011a1:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8011a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a7:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8011aa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011ad:	8d 50 ff             	lea    -0x1(%eax),%edx
  8011b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b3:	01 d0                	add    %edx,%eax
  8011b5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8011b8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8011bf:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011c3:	74 06                	je     8011cb <vsnprintf+0x2d>
  8011c5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8011c9:	7f 07                	jg     8011d2 <vsnprintf+0x34>
		return -E_INVAL;
  8011cb:	b8 03 00 00 00       	mov    $0x3,%eax
  8011d0:	eb 20                	jmp    8011f2 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8011d2:	ff 75 14             	pushl  0x14(%ebp)
  8011d5:	ff 75 10             	pushl  0x10(%ebp)
  8011d8:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8011db:	50                   	push   %eax
  8011dc:	68 68 11 80 00       	push   $0x801168
  8011e1:	e8 92 fb ff ff       	call   800d78 <vprintfmt>
  8011e6:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8011e9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8011ec:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8011ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8011f2:	c9                   	leave  
  8011f3:	c3                   	ret    

008011f4 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8011f4:	55                   	push   %ebp
  8011f5:	89 e5                	mov    %esp,%ebp
  8011f7:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8011fa:	8d 45 10             	lea    0x10(%ebp),%eax
  8011fd:	83 c0 04             	add    $0x4,%eax
  801200:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801203:	8b 45 10             	mov    0x10(%ebp),%eax
  801206:	ff 75 f4             	pushl  -0xc(%ebp)
  801209:	50                   	push   %eax
  80120a:	ff 75 0c             	pushl  0xc(%ebp)
  80120d:	ff 75 08             	pushl  0x8(%ebp)
  801210:	e8 89 ff ff ff       	call   80119e <vsnprintf>
  801215:	83 c4 10             	add    $0x10,%esp
  801218:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80121b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80121e:	c9                   	leave  
  80121f:	c3                   	ret    

00801220 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801220:	55                   	push   %ebp
  801221:	89 e5                	mov    %esp,%ebp
  801223:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801226:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80122d:	eb 06                	jmp    801235 <strlen+0x15>
		n++;
  80122f:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801232:	ff 45 08             	incl   0x8(%ebp)
  801235:	8b 45 08             	mov    0x8(%ebp),%eax
  801238:	8a 00                	mov    (%eax),%al
  80123a:	84 c0                	test   %al,%al
  80123c:	75 f1                	jne    80122f <strlen+0xf>
		n++;
	return n;
  80123e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801241:	c9                   	leave  
  801242:	c3                   	ret    

00801243 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801243:	55                   	push   %ebp
  801244:	89 e5                	mov    %esp,%ebp
  801246:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801249:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801250:	eb 09                	jmp    80125b <strnlen+0x18>
		n++;
  801252:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801255:	ff 45 08             	incl   0x8(%ebp)
  801258:	ff 4d 0c             	decl   0xc(%ebp)
  80125b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80125f:	74 09                	je     80126a <strnlen+0x27>
  801261:	8b 45 08             	mov    0x8(%ebp),%eax
  801264:	8a 00                	mov    (%eax),%al
  801266:	84 c0                	test   %al,%al
  801268:	75 e8                	jne    801252 <strnlen+0xf>
		n++;
	return n;
  80126a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80126d:	c9                   	leave  
  80126e:	c3                   	ret    

0080126f <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80126f:	55                   	push   %ebp
  801270:	89 e5                	mov    %esp,%ebp
  801272:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801275:	8b 45 08             	mov    0x8(%ebp),%eax
  801278:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80127b:	90                   	nop
  80127c:	8b 45 08             	mov    0x8(%ebp),%eax
  80127f:	8d 50 01             	lea    0x1(%eax),%edx
  801282:	89 55 08             	mov    %edx,0x8(%ebp)
  801285:	8b 55 0c             	mov    0xc(%ebp),%edx
  801288:	8d 4a 01             	lea    0x1(%edx),%ecx
  80128b:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80128e:	8a 12                	mov    (%edx),%dl
  801290:	88 10                	mov    %dl,(%eax)
  801292:	8a 00                	mov    (%eax),%al
  801294:	84 c0                	test   %al,%al
  801296:	75 e4                	jne    80127c <strcpy+0xd>
		/* do nothing */;
	return ret;
  801298:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80129b:	c9                   	leave  
  80129c:	c3                   	ret    

0080129d <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  80129d:	55                   	push   %ebp
  80129e:	89 e5                	mov    %esp,%ebp
  8012a0:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8012a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a6:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8012a9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012b0:	eb 1f                	jmp    8012d1 <strncpy+0x34>
		*dst++ = *src;
  8012b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b5:	8d 50 01             	lea    0x1(%eax),%edx
  8012b8:	89 55 08             	mov    %edx,0x8(%ebp)
  8012bb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012be:	8a 12                	mov    (%edx),%dl
  8012c0:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8012c2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012c5:	8a 00                	mov    (%eax),%al
  8012c7:	84 c0                	test   %al,%al
  8012c9:	74 03                	je     8012ce <strncpy+0x31>
			src++;
  8012cb:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8012ce:	ff 45 fc             	incl   -0x4(%ebp)
  8012d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012d4:	3b 45 10             	cmp    0x10(%ebp),%eax
  8012d7:	72 d9                	jb     8012b2 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8012d9:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8012dc:	c9                   	leave  
  8012dd:	c3                   	ret    

008012de <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8012de:	55                   	push   %ebp
  8012df:	89 e5                	mov    %esp,%ebp
  8012e1:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8012e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8012ea:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8012ee:	74 30                	je     801320 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8012f0:	eb 16                	jmp    801308 <strlcpy+0x2a>
			*dst++ = *src++;
  8012f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f5:	8d 50 01             	lea    0x1(%eax),%edx
  8012f8:	89 55 08             	mov    %edx,0x8(%ebp)
  8012fb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012fe:	8d 4a 01             	lea    0x1(%edx),%ecx
  801301:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801304:	8a 12                	mov    (%edx),%dl
  801306:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801308:	ff 4d 10             	decl   0x10(%ebp)
  80130b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80130f:	74 09                	je     80131a <strlcpy+0x3c>
  801311:	8b 45 0c             	mov    0xc(%ebp),%eax
  801314:	8a 00                	mov    (%eax),%al
  801316:	84 c0                	test   %al,%al
  801318:	75 d8                	jne    8012f2 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  80131a:	8b 45 08             	mov    0x8(%ebp),%eax
  80131d:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801320:	8b 55 08             	mov    0x8(%ebp),%edx
  801323:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801326:	29 c2                	sub    %eax,%edx
  801328:	89 d0                	mov    %edx,%eax
}
  80132a:	c9                   	leave  
  80132b:	c3                   	ret    

0080132c <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80132c:	55                   	push   %ebp
  80132d:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  80132f:	eb 06                	jmp    801337 <strcmp+0xb>
		p++, q++;
  801331:	ff 45 08             	incl   0x8(%ebp)
  801334:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801337:	8b 45 08             	mov    0x8(%ebp),%eax
  80133a:	8a 00                	mov    (%eax),%al
  80133c:	84 c0                	test   %al,%al
  80133e:	74 0e                	je     80134e <strcmp+0x22>
  801340:	8b 45 08             	mov    0x8(%ebp),%eax
  801343:	8a 10                	mov    (%eax),%dl
  801345:	8b 45 0c             	mov    0xc(%ebp),%eax
  801348:	8a 00                	mov    (%eax),%al
  80134a:	38 c2                	cmp    %al,%dl
  80134c:	74 e3                	je     801331 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  80134e:	8b 45 08             	mov    0x8(%ebp),%eax
  801351:	8a 00                	mov    (%eax),%al
  801353:	0f b6 d0             	movzbl %al,%edx
  801356:	8b 45 0c             	mov    0xc(%ebp),%eax
  801359:	8a 00                	mov    (%eax),%al
  80135b:	0f b6 c0             	movzbl %al,%eax
  80135e:	29 c2                	sub    %eax,%edx
  801360:	89 d0                	mov    %edx,%eax
}
  801362:	5d                   	pop    %ebp
  801363:	c3                   	ret    

00801364 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801364:	55                   	push   %ebp
  801365:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801367:	eb 09                	jmp    801372 <strncmp+0xe>
		n--, p++, q++;
  801369:	ff 4d 10             	decl   0x10(%ebp)
  80136c:	ff 45 08             	incl   0x8(%ebp)
  80136f:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801372:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801376:	74 17                	je     80138f <strncmp+0x2b>
  801378:	8b 45 08             	mov    0x8(%ebp),%eax
  80137b:	8a 00                	mov    (%eax),%al
  80137d:	84 c0                	test   %al,%al
  80137f:	74 0e                	je     80138f <strncmp+0x2b>
  801381:	8b 45 08             	mov    0x8(%ebp),%eax
  801384:	8a 10                	mov    (%eax),%dl
  801386:	8b 45 0c             	mov    0xc(%ebp),%eax
  801389:	8a 00                	mov    (%eax),%al
  80138b:	38 c2                	cmp    %al,%dl
  80138d:	74 da                	je     801369 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  80138f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801393:	75 07                	jne    80139c <strncmp+0x38>
		return 0;
  801395:	b8 00 00 00 00       	mov    $0x0,%eax
  80139a:	eb 14                	jmp    8013b0 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  80139c:	8b 45 08             	mov    0x8(%ebp),%eax
  80139f:	8a 00                	mov    (%eax),%al
  8013a1:	0f b6 d0             	movzbl %al,%edx
  8013a4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013a7:	8a 00                	mov    (%eax),%al
  8013a9:	0f b6 c0             	movzbl %al,%eax
  8013ac:	29 c2                	sub    %eax,%edx
  8013ae:	89 d0                	mov    %edx,%eax
}
  8013b0:	5d                   	pop    %ebp
  8013b1:	c3                   	ret    

008013b2 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8013b2:	55                   	push   %ebp
  8013b3:	89 e5                	mov    %esp,%ebp
  8013b5:	83 ec 04             	sub    $0x4,%esp
  8013b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013bb:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8013be:	eb 12                	jmp    8013d2 <strchr+0x20>
		if (*s == c)
  8013c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c3:	8a 00                	mov    (%eax),%al
  8013c5:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8013c8:	75 05                	jne    8013cf <strchr+0x1d>
			return (char *) s;
  8013ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8013cd:	eb 11                	jmp    8013e0 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8013cf:	ff 45 08             	incl   0x8(%ebp)
  8013d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d5:	8a 00                	mov    (%eax),%al
  8013d7:	84 c0                	test   %al,%al
  8013d9:	75 e5                	jne    8013c0 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8013db:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8013e0:	c9                   	leave  
  8013e1:	c3                   	ret    

008013e2 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8013e2:	55                   	push   %ebp
  8013e3:	89 e5                	mov    %esp,%ebp
  8013e5:	83 ec 04             	sub    $0x4,%esp
  8013e8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013eb:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8013ee:	eb 0d                	jmp    8013fd <strfind+0x1b>
		if (*s == c)
  8013f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f3:	8a 00                	mov    (%eax),%al
  8013f5:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8013f8:	74 0e                	je     801408 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8013fa:	ff 45 08             	incl   0x8(%ebp)
  8013fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801400:	8a 00                	mov    (%eax),%al
  801402:	84 c0                	test   %al,%al
  801404:	75 ea                	jne    8013f0 <strfind+0xe>
  801406:	eb 01                	jmp    801409 <strfind+0x27>
		if (*s == c)
			break;
  801408:	90                   	nop
	return (char *) s;
  801409:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80140c:	c9                   	leave  
  80140d:	c3                   	ret    

0080140e <memset>:


void *
memset(void *v, int c, uint32 n)
{
  80140e:	55                   	push   %ebp
  80140f:	89 e5                	mov    %esp,%ebp
  801411:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801414:	8b 45 08             	mov    0x8(%ebp),%eax
  801417:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  80141a:	8b 45 10             	mov    0x10(%ebp),%eax
  80141d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801420:	eb 0e                	jmp    801430 <memset+0x22>
		*p++ = c;
  801422:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801425:	8d 50 01             	lea    0x1(%eax),%edx
  801428:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80142b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80142e:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801430:	ff 4d f8             	decl   -0x8(%ebp)
  801433:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801437:	79 e9                	jns    801422 <memset+0x14>
		*p++ = c;

	return v;
  801439:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80143c:	c9                   	leave  
  80143d:	c3                   	ret    

0080143e <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80143e:	55                   	push   %ebp
  80143f:	89 e5                	mov    %esp,%ebp
  801441:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801444:	8b 45 0c             	mov    0xc(%ebp),%eax
  801447:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80144a:	8b 45 08             	mov    0x8(%ebp),%eax
  80144d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801450:	eb 16                	jmp    801468 <memcpy+0x2a>
		*d++ = *s++;
  801452:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801455:	8d 50 01             	lea    0x1(%eax),%edx
  801458:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80145b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80145e:	8d 4a 01             	lea    0x1(%edx),%ecx
  801461:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801464:	8a 12                	mov    (%edx),%dl
  801466:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801468:	8b 45 10             	mov    0x10(%ebp),%eax
  80146b:	8d 50 ff             	lea    -0x1(%eax),%edx
  80146e:	89 55 10             	mov    %edx,0x10(%ebp)
  801471:	85 c0                	test   %eax,%eax
  801473:	75 dd                	jne    801452 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801475:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801478:	c9                   	leave  
  801479:	c3                   	ret    

0080147a <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80147a:	55                   	push   %ebp
  80147b:	89 e5                	mov    %esp,%ebp
  80147d:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801480:	8b 45 0c             	mov    0xc(%ebp),%eax
  801483:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801486:	8b 45 08             	mov    0x8(%ebp),%eax
  801489:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80148c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80148f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801492:	73 50                	jae    8014e4 <memmove+0x6a>
  801494:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801497:	8b 45 10             	mov    0x10(%ebp),%eax
  80149a:	01 d0                	add    %edx,%eax
  80149c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80149f:	76 43                	jbe    8014e4 <memmove+0x6a>
		s += n;
  8014a1:	8b 45 10             	mov    0x10(%ebp),%eax
  8014a4:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8014a7:	8b 45 10             	mov    0x10(%ebp),%eax
  8014aa:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8014ad:	eb 10                	jmp    8014bf <memmove+0x45>
			*--d = *--s;
  8014af:	ff 4d f8             	decl   -0x8(%ebp)
  8014b2:	ff 4d fc             	decl   -0x4(%ebp)
  8014b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014b8:	8a 10                	mov    (%eax),%dl
  8014ba:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014bd:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8014bf:	8b 45 10             	mov    0x10(%ebp),%eax
  8014c2:	8d 50 ff             	lea    -0x1(%eax),%edx
  8014c5:	89 55 10             	mov    %edx,0x10(%ebp)
  8014c8:	85 c0                	test   %eax,%eax
  8014ca:	75 e3                	jne    8014af <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8014cc:	eb 23                	jmp    8014f1 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8014ce:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014d1:	8d 50 01             	lea    0x1(%eax),%edx
  8014d4:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8014d7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014da:	8d 4a 01             	lea    0x1(%edx),%ecx
  8014dd:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8014e0:	8a 12                	mov    (%edx),%dl
  8014e2:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8014e4:	8b 45 10             	mov    0x10(%ebp),%eax
  8014e7:	8d 50 ff             	lea    -0x1(%eax),%edx
  8014ea:	89 55 10             	mov    %edx,0x10(%ebp)
  8014ed:	85 c0                	test   %eax,%eax
  8014ef:	75 dd                	jne    8014ce <memmove+0x54>
			*d++ = *s++;

	return dst;
  8014f1:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8014f4:	c9                   	leave  
  8014f5:	c3                   	ret    

008014f6 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8014f6:	55                   	push   %ebp
  8014f7:	89 e5                	mov    %esp,%ebp
  8014f9:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8014fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ff:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801502:	8b 45 0c             	mov    0xc(%ebp),%eax
  801505:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801508:	eb 2a                	jmp    801534 <memcmp+0x3e>
		if (*s1 != *s2)
  80150a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80150d:	8a 10                	mov    (%eax),%dl
  80150f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801512:	8a 00                	mov    (%eax),%al
  801514:	38 c2                	cmp    %al,%dl
  801516:	74 16                	je     80152e <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801518:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80151b:	8a 00                	mov    (%eax),%al
  80151d:	0f b6 d0             	movzbl %al,%edx
  801520:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801523:	8a 00                	mov    (%eax),%al
  801525:	0f b6 c0             	movzbl %al,%eax
  801528:	29 c2                	sub    %eax,%edx
  80152a:	89 d0                	mov    %edx,%eax
  80152c:	eb 18                	jmp    801546 <memcmp+0x50>
		s1++, s2++;
  80152e:	ff 45 fc             	incl   -0x4(%ebp)
  801531:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801534:	8b 45 10             	mov    0x10(%ebp),%eax
  801537:	8d 50 ff             	lea    -0x1(%eax),%edx
  80153a:	89 55 10             	mov    %edx,0x10(%ebp)
  80153d:	85 c0                	test   %eax,%eax
  80153f:	75 c9                	jne    80150a <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801541:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801546:	c9                   	leave  
  801547:	c3                   	ret    

00801548 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801548:	55                   	push   %ebp
  801549:	89 e5                	mov    %esp,%ebp
  80154b:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80154e:	8b 55 08             	mov    0x8(%ebp),%edx
  801551:	8b 45 10             	mov    0x10(%ebp),%eax
  801554:	01 d0                	add    %edx,%eax
  801556:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801559:	eb 15                	jmp    801570 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80155b:	8b 45 08             	mov    0x8(%ebp),%eax
  80155e:	8a 00                	mov    (%eax),%al
  801560:	0f b6 d0             	movzbl %al,%edx
  801563:	8b 45 0c             	mov    0xc(%ebp),%eax
  801566:	0f b6 c0             	movzbl %al,%eax
  801569:	39 c2                	cmp    %eax,%edx
  80156b:	74 0d                	je     80157a <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80156d:	ff 45 08             	incl   0x8(%ebp)
  801570:	8b 45 08             	mov    0x8(%ebp),%eax
  801573:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801576:	72 e3                	jb     80155b <memfind+0x13>
  801578:	eb 01                	jmp    80157b <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80157a:	90                   	nop
	return (void *) s;
  80157b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80157e:	c9                   	leave  
  80157f:	c3                   	ret    

00801580 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801580:	55                   	push   %ebp
  801581:	89 e5                	mov    %esp,%ebp
  801583:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801586:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80158d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801594:	eb 03                	jmp    801599 <strtol+0x19>
		s++;
  801596:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801599:	8b 45 08             	mov    0x8(%ebp),%eax
  80159c:	8a 00                	mov    (%eax),%al
  80159e:	3c 20                	cmp    $0x20,%al
  8015a0:	74 f4                	je     801596 <strtol+0x16>
  8015a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a5:	8a 00                	mov    (%eax),%al
  8015a7:	3c 09                	cmp    $0x9,%al
  8015a9:	74 eb                	je     801596 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8015ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ae:	8a 00                	mov    (%eax),%al
  8015b0:	3c 2b                	cmp    $0x2b,%al
  8015b2:	75 05                	jne    8015b9 <strtol+0x39>
		s++;
  8015b4:	ff 45 08             	incl   0x8(%ebp)
  8015b7:	eb 13                	jmp    8015cc <strtol+0x4c>
	else if (*s == '-')
  8015b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8015bc:	8a 00                	mov    (%eax),%al
  8015be:	3c 2d                	cmp    $0x2d,%al
  8015c0:	75 0a                	jne    8015cc <strtol+0x4c>
		s++, neg = 1;
  8015c2:	ff 45 08             	incl   0x8(%ebp)
  8015c5:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8015cc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8015d0:	74 06                	je     8015d8 <strtol+0x58>
  8015d2:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8015d6:	75 20                	jne    8015f8 <strtol+0x78>
  8015d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8015db:	8a 00                	mov    (%eax),%al
  8015dd:	3c 30                	cmp    $0x30,%al
  8015df:	75 17                	jne    8015f8 <strtol+0x78>
  8015e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e4:	40                   	inc    %eax
  8015e5:	8a 00                	mov    (%eax),%al
  8015e7:	3c 78                	cmp    $0x78,%al
  8015e9:	75 0d                	jne    8015f8 <strtol+0x78>
		s += 2, base = 16;
  8015eb:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8015ef:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8015f6:	eb 28                	jmp    801620 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8015f8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8015fc:	75 15                	jne    801613 <strtol+0x93>
  8015fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801601:	8a 00                	mov    (%eax),%al
  801603:	3c 30                	cmp    $0x30,%al
  801605:	75 0c                	jne    801613 <strtol+0x93>
		s++, base = 8;
  801607:	ff 45 08             	incl   0x8(%ebp)
  80160a:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801611:	eb 0d                	jmp    801620 <strtol+0xa0>
	else if (base == 0)
  801613:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801617:	75 07                	jne    801620 <strtol+0xa0>
		base = 10;
  801619:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801620:	8b 45 08             	mov    0x8(%ebp),%eax
  801623:	8a 00                	mov    (%eax),%al
  801625:	3c 2f                	cmp    $0x2f,%al
  801627:	7e 19                	jle    801642 <strtol+0xc2>
  801629:	8b 45 08             	mov    0x8(%ebp),%eax
  80162c:	8a 00                	mov    (%eax),%al
  80162e:	3c 39                	cmp    $0x39,%al
  801630:	7f 10                	jg     801642 <strtol+0xc2>
			dig = *s - '0';
  801632:	8b 45 08             	mov    0x8(%ebp),%eax
  801635:	8a 00                	mov    (%eax),%al
  801637:	0f be c0             	movsbl %al,%eax
  80163a:	83 e8 30             	sub    $0x30,%eax
  80163d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801640:	eb 42                	jmp    801684 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801642:	8b 45 08             	mov    0x8(%ebp),%eax
  801645:	8a 00                	mov    (%eax),%al
  801647:	3c 60                	cmp    $0x60,%al
  801649:	7e 19                	jle    801664 <strtol+0xe4>
  80164b:	8b 45 08             	mov    0x8(%ebp),%eax
  80164e:	8a 00                	mov    (%eax),%al
  801650:	3c 7a                	cmp    $0x7a,%al
  801652:	7f 10                	jg     801664 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801654:	8b 45 08             	mov    0x8(%ebp),%eax
  801657:	8a 00                	mov    (%eax),%al
  801659:	0f be c0             	movsbl %al,%eax
  80165c:	83 e8 57             	sub    $0x57,%eax
  80165f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801662:	eb 20                	jmp    801684 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801664:	8b 45 08             	mov    0x8(%ebp),%eax
  801667:	8a 00                	mov    (%eax),%al
  801669:	3c 40                	cmp    $0x40,%al
  80166b:	7e 39                	jle    8016a6 <strtol+0x126>
  80166d:	8b 45 08             	mov    0x8(%ebp),%eax
  801670:	8a 00                	mov    (%eax),%al
  801672:	3c 5a                	cmp    $0x5a,%al
  801674:	7f 30                	jg     8016a6 <strtol+0x126>
			dig = *s - 'A' + 10;
  801676:	8b 45 08             	mov    0x8(%ebp),%eax
  801679:	8a 00                	mov    (%eax),%al
  80167b:	0f be c0             	movsbl %al,%eax
  80167e:	83 e8 37             	sub    $0x37,%eax
  801681:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801684:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801687:	3b 45 10             	cmp    0x10(%ebp),%eax
  80168a:	7d 19                	jge    8016a5 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80168c:	ff 45 08             	incl   0x8(%ebp)
  80168f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801692:	0f af 45 10          	imul   0x10(%ebp),%eax
  801696:	89 c2                	mov    %eax,%edx
  801698:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80169b:	01 d0                	add    %edx,%eax
  80169d:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8016a0:	e9 7b ff ff ff       	jmp    801620 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8016a5:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8016a6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8016aa:	74 08                	je     8016b4 <strtol+0x134>
		*endptr = (char *) s;
  8016ac:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016af:	8b 55 08             	mov    0x8(%ebp),%edx
  8016b2:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8016b4:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8016b8:	74 07                	je     8016c1 <strtol+0x141>
  8016ba:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016bd:	f7 d8                	neg    %eax
  8016bf:	eb 03                	jmp    8016c4 <strtol+0x144>
  8016c1:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8016c4:	c9                   	leave  
  8016c5:	c3                   	ret    

008016c6 <ltostr>:

void
ltostr(long value, char *str)
{
  8016c6:	55                   	push   %ebp
  8016c7:	89 e5                	mov    %esp,%ebp
  8016c9:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8016cc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8016d3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8016da:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8016de:	79 13                	jns    8016f3 <ltostr+0x2d>
	{
		neg = 1;
  8016e0:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8016e7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016ea:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8016ed:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8016f0:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8016f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f6:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8016fb:	99                   	cltd   
  8016fc:	f7 f9                	idiv   %ecx
  8016fe:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801701:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801704:	8d 50 01             	lea    0x1(%eax),%edx
  801707:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80170a:	89 c2                	mov    %eax,%edx
  80170c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80170f:	01 d0                	add    %edx,%eax
  801711:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801714:	83 c2 30             	add    $0x30,%edx
  801717:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801719:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80171c:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801721:	f7 e9                	imul   %ecx
  801723:	c1 fa 02             	sar    $0x2,%edx
  801726:	89 c8                	mov    %ecx,%eax
  801728:	c1 f8 1f             	sar    $0x1f,%eax
  80172b:	29 c2                	sub    %eax,%edx
  80172d:	89 d0                	mov    %edx,%eax
  80172f:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801732:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801735:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80173a:	f7 e9                	imul   %ecx
  80173c:	c1 fa 02             	sar    $0x2,%edx
  80173f:	89 c8                	mov    %ecx,%eax
  801741:	c1 f8 1f             	sar    $0x1f,%eax
  801744:	29 c2                	sub    %eax,%edx
  801746:	89 d0                	mov    %edx,%eax
  801748:	c1 e0 02             	shl    $0x2,%eax
  80174b:	01 d0                	add    %edx,%eax
  80174d:	01 c0                	add    %eax,%eax
  80174f:	29 c1                	sub    %eax,%ecx
  801751:	89 ca                	mov    %ecx,%edx
  801753:	85 d2                	test   %edx,%edx
  801755:	75 9c                	jne    8016f3 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801757:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80175e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801761:	48                   	dec    %eax
  801762:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801765:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801769:	74 3d                	je     8017a8 <ltostr+0xe2>
		start = 1 ;
  80176b:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801772:	eb 34                	jmp    8017a8 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801774:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801777:	8b 45 0c             	mov    0xc(%ebp),%eax
  80177a:	01 d0                	add    %edx,%eax
  80177c:	8a 00                	mov    (%eax),%al
  80177e:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801781:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801784:	8b 45 0c             	mov    0xc(%ebp),%eax
  801787:	01 c2                	add    %eax,%edx
  801789:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80178c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80178f:	01 c8                	add    %ecx,%eax
  801791:	8a 00                	mov    (%eax),%al
  801793:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801795:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801798:	8b 45 0c             	mov    0xc(%ebp),%eax
  80179b:	01 c2                	add    %eax,%edx
  80179d:	8a 45 eb             	mov    -0x15(%ebp),%al
  8017a0:	88 02                	mov    %al,(%edx)
		start++ ;
  8017a2:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8017a5:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8017a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017ab:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8017ae:	7c c4                	jl     801774 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8017b0:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8017b3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017b6:	01 d0                	add    %edx,%eax
  8017b8:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8017bb:	90                   	nop
  8017bc:	c9                   	leave  
  8017bd:	c3                   	ret    

008017be <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8017be:	55                   	push   %ebp
  8017bf:	89 e5                	mov    %esp,%ebp
  8017c1:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8017c4:	ff 75 08             	pushl  0x8(%ebp)
  8017c7:	e8 54 fa ff ff       	call   801220 <strlen>
  8017cc:	83 c4 04             	add    $0x4,%esp
  8017cf:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8017d2:	ff 75 0c             	pushl  0xc(%ebp)
  8017d5:	e8 46 fa ff ff       	call   801220 <strlen>
  8017da:	83 c4 04             	add    $0x4,%esp
  8017dd:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8017e0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8017e7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8017ee:	eb 17                	jmp    801807 <strcconcat+0x49>
		final[s] = str1[s] ;
  8017f0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8017f3:	8b 45 10             	mov    0x10(%ebp),%eax
  8017f6:	01 c2                	add    %eax,%edx
  8017f8:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8017fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8017fe:	01 c8                	add    %ecx,%eax
  801800:	8a 00                	mov    (%eax),%al
  801802:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801804:	ff 45 fc             	incl   -0x4(%ebp)
  801807:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80180a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80180d:	7c e1                	jl     8017f0 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80180f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801816:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80181d:	eb 1f                	jmp    80183e <strcconcat+0x80>
		final[s++] = str2[i] ;
  80181f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801822:	8d 50 01             	lea    0x1(%eax),%edx
  801825:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801828:	89 c2                	mov    %eax,%edx
  80182a:	8b 45 10             	mov    0x10(%ebp),%eax
  80182d:	01 c2                	add    %eax,%edx
  80182f:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801832:	8b 45 0c             	mov    0xc(%ebp),%eax
  801835:	01 c8                	add    %ecx,%eax
  801837:	8a 00                	mov    (%eax),%al
  801839:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80183b:	ff 45 f8             	incl   -0x8(%ebp)
  80183e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801841:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801844:	7c d9                	jl     80181f <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801846:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801849:	8b 45 10             	mov    0x10(%ebp),%eax
  80184c:	01 d0                	add    %edx,%eax
  80184e:	c6 00 00             	movb   $0x0,(%eax)
}
  801851:	90                   	nop
  801852:	c9                   	leave  
  801853:	c3                   	ret    

00801854 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801854:	55                   	push   %ebp
  801855:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801857:	8b 45 14             	mov    0x14(%ebp),%eax
  80185a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801860:	8b 45 14             	mov    0x14(%ebp),%eax
  801863:	8b 00                	mov    (%eax),%eax
  801865:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80186c:	8b 45 10             	mov    0x10(%ebp),%eax
  80186f:	01 d0                	add    %edx,%eax
  801871:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801877:	eb 0c                	jmp    801885 <strsplit+0x31>
			*string++ = 0;
  801879:	8b 45 08             	mov    0x8(%ebp),%eax
  80187c:	8d 50 01             	lea    0x1(%eax),%edx
  80187f:	89 55 08             	mov    %edx,0x8(%ebp)
  801882:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801885:	8b 45 08             	mov    0x8(%ebp),%eax
  801888:	8a 00                	mov    (%eax),%al
  80188a:	84 c0                	test   %al,%al
  80188c:	74 18                	je     8018a6 <strsplit+0x52>
  80188e:	8b 45 08             	mov    0x8(%ebp),%eax
  801891:	8a 00                	mov    (%eax),%al
  801893:	0f be c0             	movsbl %al,%eax
  801896:	50                   	push   %eax
  801897:	ff 75 0c             	pushl  0xc(%ebp)
  80189a:	e8 13 fb ff ff       	call   8013b2 <strchr>
  80189f:	83 c4 08             	add    $0x8,%esp
  8018a2:	85 c0                	test   %eax,%eax
  8018a4:	75 d3                	jne    801879 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8018a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8018a9:	8a 00                	mov    (%eax),%al
  8018ab:	84 c0                	test   %al,%al
  8018ad:	74 5a                	je     801909 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8018af:	8b 45 14             	mov    0x14(%ebp),%eax
  8018b2:	8b 00                	mov    (%eax),%eax
  8018b4:	83 f8 0f             	cmp    $0xf,%eax
  8018b7:	75 07                	jne    8018c0 <strsplit+0x6c>
		{
			return 0;
  8018b9:	b8 00 00 00 00       	mov    $0x0,%eax
  8018be:	eb 66                	jmp    801926 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8018c0:	8b 45 14             	mov    0x14(%ebp),%eax
  8018c3:	8b 00                	mov    (%eax),%eax
  8018c5:	8d 48 01             	lea    0x1(%eax),%ecx
  8018c8:	8b 55 14             	mov    0x14(%ebp),%edx
  8018cb:	89 0a                	mov    %ecx,(%edx)
  8018cd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018d4:	8b 45 10             	mov    0x10(%ebp),%eax
  8018d7:	01 c2                	add    %eax,%edx
  8018d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8018dc:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8018de:	eb 03                	jmp    8018e3 <strsplit+0x8f>
			string++;
  8018e0:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8018e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8018e6:	8a 00                	mov    (%eax),%al
  8018e8:	84 c0                	test   %al,%al
  8018ea:	74 8b                	je     801877 <strsplit+0x23>
  8018ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ef:	8a 00                	mov    (%eax),%al
  8018f1:	0f be c0             	movsbl %al,%eax
  8018f4:	50                   	push   %eax
  8018f5:	ff 75 0c             	pushl  0xc(%ebp)
  8018f8:	e8 b5 fa ff ff       	call   8013b2 <strchr>
  8018fd:	83 c4 08             	add    $0x8,%esp
  801900:	85 c0                	test   %eax,%eax
  801902:	74 dc                	je     8018e0 <strsplit+0x8c>
			string++;
	}
  801904:	e9 6e ff ff ff       	jmp    801877 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801909:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80190a:	8b 45 14             	mov    0x14(%ebp),%eax
  80190d:	8b 00                	mov    (%eax),%eax
  80190f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801916:	8b 45 10             	mov    0x10(%ebp),%eax
  801919:	01 d0                	add    %edx,%eax
  80191b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801921:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801926:	c9                   	leave  
  801927:	c3                   	ret    

00801928 <malloc>:
struct page pages[(USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE];
uint32 be_space,be_address,first_empty_space,index,ad,
emp_space,find,array_size=0;
int nump,si,ind;
void* malloc(uint32 size)
{
  801928:	55                   	push   %ebp
  801929:	89 e5                	mov    %esp,%ebp
  80192b:	83 ec 18             	sub    $0x18,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	//panic("malloc() is not implemented yet...!!");

	//BOOL VARIABLE COUNT FREE SPACES IN MEM
	free_mem_count=0;
  80192e:	c7 05 4c 31 80 00 00 	movl   $0x0,0x80314c
  801935:	00 00 00 
	//BOOL VARIABLE check is there suitable space or not
	find=0;
  801938:	c7 05 48 31 80 00 00 	movl   $0x0,0x803148
  80193f:	00 00 00 
	// Initialize user heap memory (1GB = 2^30)->MAX_NUM
	if(intialize_mem==0)
  801942:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801947:	85 c0                	test   %eax,%eax
  801949:	75 65                	jne    8019b0 <malloc+0x88>
	{
		for(j=USER_HEAP_START;j<USER_HEAP_MAX;j+=PAGE_SIZE)
  80194b:	c7 05 2c 31 80 00 00 	movl   $0x80000000,0x80312c
  801952:	00 00 80 
  801955:	eb 43                	jmp    80199a <malloc+0x72>
		{
			pages[array_size].address=j; // store start address of each 4k(Page_size)
  801957:	8b 15 30 30 80 00    	mov    0x803030,%edx
  80195d:	a1 2c 31 80 00       	mov    0x80312c,%eax
  801962:	c1 e2 04             	shl    $0x4,%edx
  801965:	81 c2 60 31 80 00    	add    $0x803160,%edx
  80196b:	89 02                	mov    %eax,(%edx)
			pages[array_size].used=0;//not used
  80196d:	a1 30 30 80 00       	mov    0x803030,%eax
  801972:	c1 e0 04             	shl    $0x4,%eax
  801975:	05 64 31 80 00       	add    $0x803164,%eax
  80197a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
			array_size+=1;
  801980:	a1 30 30 80 00       	mov    0x803030,%eax
  801985:	40                   	inc    %eax
  801986:	a3 30 30 80 00       	mov    %eax,0x803030
	//BOOL VARIABLE check is there suitable space or not
	find=0;
	// Initialize user heap memory (1GB = 2^30)->MAX_NUM
	if(intialize_mem==0)
	{
		for(j=USER_HEAP_START;j<USER_HEAP_MAX;j+=PAGE_SIZE)
  80198b:	a1 2c 31 80 00       	mov    0x80312c,%eax
  801990:	05 00 10 00 00       	add    $0x1000,%eax
  801995:	a3 2c 31 80 00       	mov    %eax,0x80312c
  80199a:	a1 2c 31 80 00       	mov    0x80312c,%eax
  80199f:	3d ff ff ff 9f       	cmp    $0x9fffffff,%eax
  8019a4:	76 b1                	jbe    801957 <malloc+0x2f>
		{
			pages[array_size].address=j; // store start address of each 4k(Page_size)
			pages[array_size].used=0;//not used
			array_size+=1;
		}
		intialize_mem=1;
  8019a6:	c7 05 2c 30 80 00 01 	movl   $0x1,0x80302c
  8019ad:	00 00 00 
	}
	be_space=MAX_NUM;
  8019b0:	c7 05 5c 31 80 00 00 	movl   $0x40000000,0x80315c
  8019b7:	00 00 40 
	//find upper limit of size and calculate num of pages with given size
	round=ROUNDUP(size/1024,4);
  8019ba:	c7 45 f4 04 00 00 00 	movl   $0x4,-0xc(%ebp)
  8019c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8019c4:	c1 e8 0a             	shr    $0xa,%eax
  8019c7:	89 c2                	mov    %eax,%edx
  8019c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8019cc:	01 d0                	add    %edx,%eax
  8019ce:	48                   	dec    %eax
  8019cf:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8019d2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8019d5:	ba 00 00 00 00       	mov    $0x0,%edx
  8019da:	f7 75 f4             	divl   -0xc(%ebp)
  8019dd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8019e0:	29 d0                	sub    %edx,%eax
  8019e2:	a3 28 31 80 00       	mov    %eax,0x803128
	no_of_pages=round/4;
  8019e7:	a1 28 31 80 00       	mov    0x803128,%eax
  8019ec:	c1 e8 02             	shr    $0x2,%eax
  8019ef:	a3 60 31 a0 00       	mov    %eax,0xa03160
	// find empty spaces in user heap mem
	for(j=0;j<array_size;++j)
  8019f4:	c7 05 2c 31 80 00 00 	movl   $0x0,0x80312c
  8019fb:	00 00 00 
  8019fe:	e9 96 00 00 00       	jmp    801a99 <malloc+0x171>
	{
		if(pages[j].used==0) //check empty pages
  801a03:	a1 2c 31 80 00       	mov    0x80312c,%eax
  801a08:	c1 e0 04             	shl    $0x4,%eax
  801a0b:	05 64 31 80 00       	add    $0x803164,%eax
  801a10:	8b 00                	mov    (%eax),%eax
  801a12:	85 c0                	test   %eax,%eax
  801a14:	75 2a                	jne    801a40 <malloc+0x118>
		{
			//first empty space only
			if(free_mem_count==0)
  801a16:	a1 4c 31 80 00       	mov    0x80314c,%eax
  801a1b:	85 c0                	test   %eax,%eax
  801a1d:	75 14                	jne    801a33 <malloc+0x10b>
			{
				first_empty_space=pages[j].address;
  801a1f:	a1 2c 31 80 00       	mov    0x80312c,%eax
  801a24:	c1 e0 04             	shl    $0x4,%eax
  801a27:	05 60 31 80 00       	add    $0x803160,%eax
  801a2c:	8b 00                	mov    (%eax),%eax
  801a2e:	a3 30 31 80 00       	mov    %eax,0x803130
			}
			free_mem_count++; // increment num of free spaces
  801a33:	a1 4c 31 80 00       	mov    0x80314c,%eax
  801a38:	40                   	inc    %eax
  801a39:	a3 4c 31 80 00       	mov    %eax,0x80314c
  801a3e:	eb 4e                	jmp    801a8e <malloc+0x166>
		}
		else //pages[j].used!=0(==1)used
		{
			// best fit strategy
			emp_space=free_mem_count*PAGE_SIZE;
  801a40:	a1 4c 31 80 00       	mov    0x80314c,%eax
  801a45:	c1 e0 0c             	shl    $0xc,%eax
  801a48:	a3 34 31 80 00       	mov    %eax,0x803134
			// find min space to fit given size in array
			if(be_space>emp_space&&emp_space>=size)
  801a4d:	8b 15 5c 31 80 00    	mov    0x80315c,%edx
  801a53:	a1 34 31 80 00       	mov    0x803134,%eax
  801a58:	39 c2                	cmp    %eax,%edx
  801a5a:	76 28                	jbe    801a84 <malloc+0x15c>
  801a5c:	a1 34 31 80 00       	mov    0x803134,%eax
  801a61:	3b 45 08             	cmp    0x8(%ebp),%eax
  801a64:	72 1e                	jb     801a84 <malloc+0x15c>
			{
				// reset min value to repeat condition to find suitable space (ms7 mosawi2 aw2kbr b shwi2)
				be_space=emp_space;
  801a66:	a1 34 31 80 00       	mov    0x803134,%eax
  801a6b:	a3 5c 31 80 00       	mov    %eax,0x80315c
				// set start address of empty space
				be_address=first_empty_space;
  801a70:	a1 30 31 80 00       	mov    0x803130,%eax
  801a75:	a3 58 31 80 00       	mov    %eax,0x803158
				find=1;
  801a7a:	c7 05 48 31 80 00 01 	movl   $0x1,0x803148
  801a81:	00 00 00 
			}
			free_mem_count=0;
  801a84:	c7 05 4c 31 80 00 00 	movl   $0x0,0x80314c
  801a8b:	00 00 00 
	be_space=MAX_NUM;
	//find upper limit of size and calculate num of pages with given size
	round=ROUNDUP(size/1024,4);
	no_of_pages=round/4;
	// find empty spaces in user heap mem
	for(j=0;j<array_size;++j)
  801a8e:	a1 2c 31 80 00       	mov    0x80312c,%eax
  801a93:	40                   	inc    %eax
  801a94:	a3 2c 31 80 00       	mov    %eax,0x80312c
  801a99:	8b 15 2c 31 80 00    	mov    0x80312c,%edx
  801a9f:	a1 30 30 80 00       	mov    0x803030,%eax
  801aa4:	39 c2                	cmp    %eax,%edx
  801aa6:	0f 82 57 ff ff ff    	jb     801a03 <malloc+0xdb>
			}
			free_mem_count=0;
		}
	}
	// re calc new empty space
	emp_space=free_mem_count*PAGE_SIZE;
  801aac:	a1 4c 31 80 00       	mov    0x80314c,%eax
  801ab1:	c1 e0 0c             	shl    $0xc,%eax
  801ab4:	a3 34 31 80 00       	mov    %eax,0x803134
	// check if this empty space suitable to fit given size or not
	if(be_space>emp_space&&emp_space>=size)
  801ab9:	8b 15 5c 31 80 00    	mov    0x80315c,%edx
  801abf:	a1 34 31 80 00       	mov    0x803134,%eax
  801ac4:	39 c2                	cmp    %eax,%edx
  801ac6:	76 1e                	jbe    801ae6 <malloc+0x1be>
  801ac8:	a1 34 31 80 00       	mov    0x803134,%eax
  801acd:	3b 45 08             	cmp    0x8(%ebp),%eax
  801ad0:	72 14                	jb     801ae6 <malloc+0x1be>
	{
		find=1;
  801ad2:	c7 05 48 31 80 00 01 	movl   $0x1,0x803148
  801ad9:	00 00 00 
		// set final start address of empty space
		be_address=first_empty_space;
  801adc:	a1 30 31 80 00       	mov    0x803130,%eax
  801ae1:	a3 58 31 80 00       	mov    %eax,0x803158
	}
	if(find==0) // no suitable space found
  801ae6:	a1 48 31 80 00       	mov    0x803148,%eax
  801aeb:	85 c0                	test   %eax,%eax
  801aed:	75 0a                	jne    801af9 <malloc+0x1d1>
	{
		return NULL;
  801aef:	b8 00 00 00 00       	mov    $0x0,%eax
  801af4:	e9 fa 00 00 00       	jmp    801bf3 <malloc+0x2cb>
	}
	for(j=0;j<array_size;++j)
  801af9:	c7 05 2c 31 80 00 00 	movl   $0x0,0x80312c
  801b00:	00 00 00 
  801b03:	eb 2f                	jmp    801b34 <malloc+0x20c>
	{
		if (pages[j].address==be_address)
  801b05:	a1 2c 31 80 00       	mov    0x80312c,%eax
  801b0a:	c1 e0 04             	shl    $0x4,%eax
  801b0d:	05 60 31 80 00       	add    $0x803160,%eax
  801b12:	8b 10                	mov    (%eax),%edx
  801b14:	a1 58 31 80 00       	mov    0x803158,%eax
  801b19:	39 c2                	cmp    %eax,%edx
  801b1b:	75 0c                	jne    801b29 <malloc+0x201>
		{
			index=j;
  801b1d:	a1 2c 31 80 00       	mov    0x80312c,%eax
  801b22:	a3 50 31 80 00       	mov    %eax,0x803150
			break;
  801b27:	eb 1a                	jmp    801b43 <malloc+0x21b>
	}
	if(find==0) // no suitable space found
	{
		return NULL;
	}
	for(j=0;j<array_size;++j)
  801b29:	a1 2c 31 80 00       	mov    0x80312c,%eax
  801b2e:	40                   	inc    %eax
  801b2f:	a3 2c 31 80 00       	mov    %eax,0x80312c
  801b34:	8b 15 2c 31 80 00    	mov    0x80312c,%edx
  801b3a:	a1 30 30 80 00       	mov    0x803030,%eax
  801b3f:	39 c2                	cmp    %eax,%edx
  801b41:	72 c2                	jb     801b05 <malloc+0x1dd>
			index=j;
			break;
		}
	}
	// set num of pages to address in array
	pages[index].num_of_pages=no_of_pages;
  801b43:	8b 15 50 31 80 00    	mov    0x803150,%edx
  801b49:	a1 60 31 a0 00       	mov    0xa03160,%eax
  801b4e:	c1 e2 04             	shl    $0x4,%edx
  801b51:	81 c2 68 31 80 00    	add    $0x803168,%edx
  801b57:	89 02                	mov    %eax,(%edx)
	pages[index].siize=size;
  801b59:	a1 50 31 80 00       	mov    0x803150,%eax
  801b5e:	c1 e0 04             	shl    $0x4,%eax
  801b61:	8d 90 6c 31 80 00    	lea    0x80316c(%eax),%edx
  801b67:	8b 45 08             	mov    0x8(%ebp),%eax
  801b6a:	89 02                	mov    %eax,(%edx)
	ind=index;
  801b6c:	a1 50 31 80 00       	mov    0x803150,%eax
  801b71:	a3 3c 31 80 00       	mov    %eax,0x80313c

	// loop in n to reset used value to 1 b3add l pages
	for(j=0;j<no_of_pages;++j)
  801b76:	c7 05 2c 31 80 00 00 	movl   $0x0,0x80312c
  801b7d:	00 00 00 
  801b80:	eb 29                	jmp    801bab <malloc+0x283>
	{
		pages[index].used=1;
  801b82:	a1 50 31 80 00       	mov    0x803150,%eax
  801b87:	c1 e0 04             	shl    $0x4,%eax
  801b8a:	05 64 31 80 00       	add    $0x803164,%eax
  801b8f:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
		++index;
  801b95:	a1 50 31 80 00       	mov    0x803150,%eax
  801b9a:	40                   	inc    %eax
  801b9b:	a3 50 31 80 00       	mov    %eax,0x803150
	pages[index].num_of_pages=no_of_pages;
	pages[index].siize=size;
	ind=index;

	// loop in n to reset used value to 1 b3add l pages
	for(j=0;j<no_of_pages;++j)
  801ba0:	a1 2c 31 80 00       	mov    0x80312c,%eax
  801ba5:	40                   	inc    %eax
  801ba6:	a3 2c 31 80 00       	mov    %eax,0x80312c
  801bab:	8b 15 2c 31 80 00    	mov    0x80312c,%edx
  801bb1:	a1 60 31 a0 00       	mov    0xa03160,%eax
  801bb6:	39 c2                	cmp    %eax,%edx
  801bb8:	72 c8                	jb     801b82 <malloc+0x25a>
	{
		pages[index].used=1;
		++index;
	}
	// Swap from user heap to kernel
	sys_allocateMem(be_address,size);
  801bba:	a1 58 31 80 00       	mov    0x803158,%eax
  801bbf:	83 ec 08             	sub    $0x8,%esp
  801bc2:	ff 75 08             	pushl  0x8(%ebp)
  801bc5:	50                   	push   %eax
  801bc6:	e8 ea 03 00 00       	call   801fb5 <sys_allocateMem>
  801bcb:	83 c4 10             	add    $0x10,%esp
	ad = be_address;
  801bce:	a1 58 31 80 00       	mov    0x803158,%eax
  801bd3:	a3 20 31 80 00       	mov    %eax,0x803120
	si = size/2;
  801bd8:	8b 45 08             	mov    0x8(%ebp),%eax
  801bdb:	d1 e8                	shr    %eax
  801bdd:	a3 38 31 80 00       	mov    %eax,0x803138
	nump = no_of_pages/2;
  801be2:	a1 60 31 a0 00       	mov    0xa03160,%eax
  801be7:	d1 e8                	shr    %eax
  801be9:	a3 40 31 80 00       	mov    %eax,0x803140
	return (void*)be_address;
  801bee:	a1 58 31 80 00       	mov    0x803158,%eax
	//This function should find the space of the required range
	//using the BEST FIT strategy
	//refer to the project presentation and documentation for details
	return NULL;
}
  801bf3:	c9                   	leave  
  801bf4:	c3                   	ret    

00801bf5 <free>:

uint32 size, maxmam_size,fif;
void free(void* virtual_address)
{
  801bf5:	55                   	push   %ebp
  801bf6:	89 e5                	mov    %esp,%ebp
  801bf8:	83 ec 28             	sub    $0x28,%esp
int index;
	//found index of virtual address
	for(int i=0;i<array_size;i++)
  801bfb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801c02:	eb 1d                	jmp    801c21 <free+0x2c>
	{
		if((void *)pages[i].address == virtual_address)
  801c04:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c07:	c1 e0 04             	shl    $0x4,%eax
  801c0a:	05 60 31 80 00       	add    $0x803160,%eax
  801c0f:	8b 00                	mov    (%eax),%eax
  801c11:	3b 45 08             	cmp    0x8(%ebp),%eax
  801c14:	75 08                	jne    801c1e <free+0x29>
		{
			index = i;
  801c16:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c19:	89 45 f4             	mov    %eax,-0xc(%ebp)
			break;
  801c1c:	eb 0f                	jmp    801c2d <free+0x38>
uint32 size, maxmam_size,fif;
void free(void* virtual_address)
{
int index;
	//found index of virtual address
	for(int i=0;i<array_size;i++)
  801c1e:	ff 45 f0             	incl   -0x10(%ebp)
  801c21:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801c24:	a1 30 30 80 00       	mov    0x803030,%eax
  801c29:	39 c2                	cmp    %eax,%edx
  801c2b:	72 d7                	jb     801c04 <free+0xf>
			break;
		}
	}

	//get num of pages
	int num_of_pages = pages[index].num_of_pages;
  801c2d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801c30:	c1 e0 04             	shl    $0x4,%eax
  801c33:	05 68 31 80 00       	add    $0x803168,%eax
  801c38:	8b 00                	mov    (%eax),%eax
  801c3a:	89 45 e8             	mov    %eax,-0x18(%ebp)
	pages[index].num_of_pages=0;
  801c3d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801c40:	c1 e0 04             	shl    $0x4,%eax
  801c43:	05 68 31 80 00       	add    $0x803168,%eax
  801c48:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	uint32 va = pages[index].address;
  801c4e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801c51:	c1 e0 04             	shl    $0x4,%eax
  801c54:	05 60 31 80 00       	add    $0x803160,%eax
  801c59:	8b 00                	mov    (%eax),%eax
  801c5b:	89 45 e4             	mov    %eax,-0x1c(%ebp)

	//set used to 0
	for(int i=0;i<num_of_pages;i++)
  801c5e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  801c65:	eb 17                	jmp    801c7e <free+0x89>
	{
		pages[index].used=0;
  801c67:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801c6a:	c1 e0 04             	shl    $0x4,%eax
  801c6d:	05 64 31 80 00       	add    $0x803164,%eax
  801c72:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		index++;
  801c78:	ff 45 f4             	incl   -0xc(%ebp)
	int num_of_pages = pages[index].num_of_pages;
	pages[index].num_of_pages=0;
	uint32 va = pages[index].address;

	//set used to 0
	for(int i=0;i<num_of_pages;i++)
  801c7b:	ff 45 ec             	incl   -0x14(%ebp)
  801c7e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801c81:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801c84:	7c e1                	jl     801c67 <free+0x72>
	{
		pages[index].used=0;
		index++;
	}
	// Swap from user heap to kernel
	sys_freeMem(va, num_of_pages*PAGE_SIZE);
  801c86:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801c89:	c1 e0 0c             	shl    $0xc,%eax
  801c8c:	83 ec 08             	sub    $0x8,%esp
  801c8f:	50                   	push   %eax
  801c90:	ff 75 e4             	pushl  -0x1c(%ebp)
  801c93:	e8 01 03 00 00       	call   801f99 <sys_freeMem>
  801c98:	83 c4 10             	add    $0x10,%esp
}
  801c9b:	90                   	nop
  801c9c:	c9                   	leave  
  801c9d:	c3                   	ret    

00801c9e <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801c9e:	55                   	push   %ebp
  801c9f:	89 e5                	mov    %esp,%ebp
  801ca1:	83 ec 18             	sub    $0x18,%esp
  801ca4:	8b 45 10             	mov    0x10(%ebp),%eax
  801ca7:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801caa:	83 ec 04             	sub    $0x4,%esp
  801cad:	68 10 2e 80 00       	push   $0x802e10
  801cb2:	68 a0 00 00 00       	push   $0xa0
  801cb7:	68 33 2e 80 00       	push   $0x802e33
  801cbc:	e8 3b ec ff ff       	call   8008fc <_panic>

00801cc1 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801cc1:	55                   	push   %ebp
  801cc2:	89 e5                	mov    %esp,%ebp
  801cc4:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801cc7:	83 ec 04             	sub    $0x4,%esp
  801cca:	68 10 2e 80 00       	push   $0x802e10
  801ccf:	68 a6 00 00 00       	push   $0xa6
  801cd4:	68 33 2e 80 00       	push   $0x802e33
  801cd9:	e8 1e ec ff ff       	call   8008fc <_panic>

00801cde <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  801cde:	55                   	push   %ebp
  801cdf:	89 e5                	mov    %esp,%ebp
  801ce1:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801ce4:	83 ec 04             	sub    $0x4,%esp
  801ce7:	68 10 2e 80 00       	push   $0x802e10
  801cec:	68 ac 00 00 00       	push   $0xac
  801cf1:	68 33 2e 80 00       	push   $0x802e33
  801cf6:	e8 01 ec ff ff       	call   8008fc <_panic>

00801cfb <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size)
{
  801cfb:	55                   	push   %ebp
  801cfc:	89 e5                	mov    %esp,%ebp
  801cfe:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801d01:	83 ec 04             	sub    $0x4,%esp
  801d04:	68 10 2e 80 00       	push   $0x802e10
  801d09:	68 b1 00 00 00       	push   $0xb1
  801d0e:	68 33 2e 80 00       	push   $0x802e33
  801d13:	e8 e4 eb ff ff       	call   8008fc <_panic>

00801d18 <expand>:
	return 0;
}

void expand(uint32 newSize)
{
  801d18:	55                   	push   %ebp
  801d19:	89 e5                	mov    %esp,%ebp
  801d1b:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801d1e:	83 ec 04             	sub    $0x4,%esp
  801d21:	68 10 2e 80 00       	push   $0x802e10
  801d26:	68 b7 00 00 00       	push   $0xb7
  801d2b:	68 33 2e 80 00       	push   $0x802e33
  801d30:	e8 c7 eb ff ff       	call   8008fc <_panic>

00801d35 <shrink>:
}
void shrink(uint32 newSize)
{
  801d35:	55                   	push   %ebp
  801d36:	89 e5                	mov    %esp,%ebp
  801d38:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801d3b:	83 ec 04             	sub    $0x4,%esp
  801d3e:	68 10 2e 80 00       	push   $0x802e10
  801d43:	68 bb 00 00 00       	push   $0xbb
  801d48:	68 33 2e 80 00       	push   $0x802e33
  801d4d:	e8 aa eb ff ff       	call   8008fc <_panic>

00801d52 <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  801d52:	55                   	push   %ebp
  801d53:	89 e5                	mov    %esp,%ebp
  801d55:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801d58:	83 ec 04             	sub    $0x4,%esp
  801d5b:	68 10 2e 80 00       	push   $0x802e10
  801d60:	68 c0 00 00 00       	push   $0xc0
  801d65:	68 33 2e 80 00       	push   $0x802e33
  801d6a:	e8 8d eb ff ff       	call   8008fc <_panic>

00801d6f <halfLast>:
}

void halfLast(){
  801d6f:	55                   	push   %ebp
  801d70:	89 e5                	mov    %esp,%ebp
  801d72:	83 ec 18             	sub    $0x18,%esp
	for(i=array_size;i>pa/2;--i)
	{
		pages[va].used=0;
		va+=PAGE_SIZE;
	}*/
	uint32 halfAdd = ad+si;
  801d75:	a1 20 31 80 00       	mov    0x803120,%eax
  801d7a:	8b 15 38 31 80 00    	mov    0x803138,%edx
  801d80:	01 d0                	add    %edx,%eax
  801d82:	89 45 f0             	mov    %eax,-0x10(%ebp)
	ind+=nump;
  801d85:	8b 15 3c 31 80 00    	mov    0x80313c,%edx
  801d8b:	a1 40 31 80 00       	mov    0x803140,%eax
  801d90:	01 d0                	add    %edx,%eax
  801d92:	a3 3c 31 80 00       	mov    %eax,0x80313c
	for(int i=0;i<nump;i++){
  801d97:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801d9e:	eb 21                	jmp    801dc1 <halfLast+0x52>
		pages[ind].used=0;
  801da0:	a1 3c 31 80 00       	mov    0x80313c,%eax
  801da5:	c1 e0 04             	shl    $0x4,%eax
  801da8:	05 64 31 80 00       	add    $0x803164,%eax
  801dad:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		ind++;
  801db3:	a1 3c 31 80 00       	mov    0x80313c,%eax
  801db8:	40                   	inc    %eax
  801db9:	a3 3c 31 80 00       	mov    %eax,0x80313c
		pages[va].used=0;
		va+=PAGE_SIZE;
	}*/
	uint32 halfAdd = ad+si;
	ind+=nump;
	for(int i=0;i<nump;i++){
  801dbe:	ff 45 f4             	incl   -0xc(%ebp)
  801dc1:	a1 40 31 80 00       	mov    0x803140,%eax
  801dc6:	39 45 f4             	cmp    %eax,-0xc(%ebp)
  801dc9:	7c d5                	jl     801da0 <halfLast+0x31>
		pages[ind].used=0;
		ind++;
	}
	sys_freeMem(halfAdd,si);
  801dcb:	a1 38 31 80 00       	mov    0x803138,%eax
  801dd0:	83 ec 08             	sub    $0x8,%esp
  801dd3:	50                   	push   %eax
  801dd4:	ff 75 f0             	pushl  -0x10(%ebp)
  801dd7:	e8 bd 01 00 00       	call   801f99 <sys_freeMem>
  801ddc:	83 c4 10             	add    $0x10,%esp
	//free((void*)ad);
	//malloc(nup);
}
  801ddf:	90                   	nop
  801de0:	c9                   	leave  
  801de1:	c3                   	ret    

00801de2 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801de2:	55                   	push   %ebp
  801de3:	89 e5                	mov    %esp,%ebp
  801de5:	57                   	push   %edi
  801de6:	56                   	push   %esi
  801de7:	53                   	push   %ebx
  801de8:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801deb:	8b 45 08             	mov    0x8(%ebp),%eax
  801dee:	8b 55 0c             	mov    0xc(%ebp),%edx
  801df1:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801df4:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801df7:	8b 7d 18             	mov    0x18(%ebp),%edi
  801dfa:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801dfd:	cd 30                	int    $0x30
  801dff:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801e02:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801e05:	83 c4 10             	add    $0x10,%esp
  801e08:	5b                   	pop    %ebx
  801e09:	5e                   	pop    %esi
  801e0a:	5f                   	pop    %edi
  801e0b:	5d                   	pop    %ebp
  801e0c:	c3                   	ret    

00801e0d <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801e0d:	55                   	push   %ebp
  801e0e:	89 e5                	mov    %esp,%ebp
  801e10:	83 ec 04             	sub    $0x4,%esp
  801e13:	8b 45 10             	mov    0x10(%ebp),%eax
  801e16:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801e19:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801e1d:	8b 45 08             	mov    0x8(%ebp),%eax
  801e20:	6a 00                	push   $0x0
  801e22:	6a 00                	push   $0x0
  801e24:	52                   	push   %edx
  801e25:	ff 75 0c             	pushl  0xc(%ebp)
  801e28:	50                   	push   %eax
  801e29:	6a 00                	push   $0x0
  801e2b:	e8 b2 ff ff ff       	call   801de2 <syscall>
  801e30:	83 c4 18             	add    $0x18,%esp
}
  801e33:	90                   	nop
  801e34:	c9                   	leave  
  801e35:	c3                   	ret    

00801e36 <sys_cgetc>:

int
sys_cgetc(void)
{
  801e36:	55                   	push   %ebp
  801e37:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801e39:	6a 00                	push   $0x0
  801e3b:	6a 00                	push   $0x0
  801e3d:	6a 00                	push   $0x0
  801e3f:	6a 00                	push   $0x0
  801e41:	6a 00                	push   $0x0
  801e43:	6a 01                	push   $0x1
  801e45:	e8 98 ff ff ff       	call   801de2 <syscall>
  801e4a:	83 c4 18             	add    $0x18,%esp
}
  801e4d:	c9                   	leave  
  801e4e:	c3                   	ret    

00801e4f <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801e4f:	55                   	push   %ebp
  801e50:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801e52:	8b 45 08             	mov    0x8(%ebp),%eax
  801e55:	6a 00                	push   $0x0
  801e57:	6a 00                	push   $0x0
  801e59:	6a 00                	push   $0x0
  801e5b:	6a 00                	push   $0x0
  801e5d:	50                   	push   %eax
  801e5e:	6a 05                	push   $0x5
  801e60:	e8 7d ff ff ff       	call   801de2 <syscall>
  801e65:	83 c4 18             	add    $0x18,%esp
}
  801e68:	c9                   	leave  
  801e69:	c3                   	ret    

00801e6a <sys_getenvid>:

int32 sys_getenvid(void)
{
  801e6a:	55                   	push   %ebp
  801e6b:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801e6d:	6a 00                	push   $0x0
  801e6f:	6a 00                	push   $0x0
  801e71:	6a 00                	push   $0x0
  801e73:	6a 00                	push   $0x0
  801e75:	6a 00                	push   $0x0
  801e77:	6a 02                	push   $0x2
  801e79:	e8 64 ff ff ff       	call   801de2 <syscall>
  801e7e:	83 c4 18             	add    $0x18,%esp
}
  801e81:	c9                   	leave  
  801e82:	c3                   	ret    

00801e83 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801e83:	55                   	push   %ebp
  801e84:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801e86:	6a 00                	push   $0x0
  801e88:	6a 00                	push   $0x0
  801e8a:	6a 00                	push   $0x0
  801e8c:	6a 00                	push   $0x0
  801e8e:	6a 00                	push   $0x0
  801e90:	6a 03                	push   $0x3
  801e92:	e8 4b ff ff ff       	call   801de2 <syscall>
  801e97:	83 c4 18             	add    $0x18,%esp
}
  801e9a:	c9                   	leave  
  801e9b:	c3                   	ret    

00801e9c <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801e9c:	55                   	push   %ebp
  801e9d:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801e9f:	6a 00                	push   $0x0
  801ea1:	6a 00                	push   $0x0
  801ea3:	6a 00                	push   $0x0
  801ea5:	6a 00                	push   $0x0
  801ea7:	6a 00                	push   $0x0
  801ea9:	6a 04                	push   $0x4
  801eab:	e8 32 ff ff ff       	call   801de2 <syscall>
  801eb0:	83 c4 18             	add    $0x18,%esp
}
  801eb3:	c9                   	leave  
  801eb4:	c3                   	ret    

00801eb5 <sys_env_exit>:


void sys_env_exit(void)
{
  801eb5:	55                   	push   %ebp
  801eb6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801eb8:	6a 00                	push   $0x0
  801eba:	6a 00                	push   $0x0
  801ebc:	6a 00                	push   $0x0
  801ebe:	6a 00                	push   $0x0
  801ec0:	6a 00                	push   $0x0
  801ec2:	6a 06                	push   $0x6
  801ec4:	e8 19 ff ff ff       	call   801de2 <syscall>
  801ec9:	83 c4 18             	add    $0x18,%esp
}
  801ecc:	90                   	nop
  801ecd:	c9                   	leave  
  801ece:	c3                   	ret    

00801ecf <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801ecf:	55                   	push   %ebp
  801ed0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801ed2:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ed5:	8b 45 08             	mov    0x8(%ebp),%eax
  801ed8:	6a 00                	push   $0x0
  801eda:	6a 00                	push   $0x0
  801edc:	6a 00                	push   $0x0
  801ede:	52                   	push   %edx
  801edf:	50                   	push   %eax
  801ee0:	6a 07                	push   $0x7
  801ee2:	e8 fb fe ff ff       	call   801de2 <syscall>
  801ee7:	83 c4 18             	add    $0x18,%esp
}
  801eea:	c9                   	leave  
  801eeb:	c3                   	ret    

00801eec <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801eec:	55                   	push   %ebp
  801eed:	89 e5                	mov    %esp,%ebp
  801eef:	56                   	push   %esi
  801ef0:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801ef1:	8b 75 18             	mov    0x18(%ebp),%esi
  801ef4:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801ef7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801efa:	8b 55 0c             	mov    0xc(%ebp),%edx
  801efd:	8b 45 08             	mov    0x8(%ebp),%eax
  801f00:	56                   	push   %esi
  801f01:	53                   	push   %ebx
  801f02:	51                   	push   %ecx
  801f03:	52                   	push   %edx
  801f04:	50                   	push   %eax
  801f05:	6a 08                	push   $0x8
  801f07:	e8 d6 fe ff ff       	call   801de2 <syscall>
  801f0c:	83 c4 18             	add    $0x18,%esp
}
  801f0f:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801f12:	5b                   	pop    %ebx
  801f13:	5e                   	pop    %esi
  801f14:	5d                   	pop    %ebp
  801f15:	c3                   	ret    

00801f16 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801f16:	55                   	push   %ebp
  801f17:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801f19:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f1c:	8b 45 08             	mov    0x8(%ebp),%eax
  801f1f:	6a 00                	push   $0x0
  801f21:	6a 00                	push   $0x0
  801f23:	6a 00                	push   $0x0
  801f25:	52                   	push   %edx
  801f26:	50                   	push   %eax
  801f27:	6a 09                	push   $0x9
  801f29:	e8 b4 fe ff ff       	call   801de2 <syscall>
  801f2e:	83 c4 18             	add    $0x18,%esp
}
  801f31:	c9                   	leave  
  801f32:	c3                   	ret    

00801f33 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801f33:	55                   	push   %ebp
  801f34:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801f36:	6a 00                	push   $0x0
  801f38:	6a 00                	push   $0x0
  801f3a:	6a 00                	push   $0x0
  801f3c:	ff 75 0c             	pushl  0xc(%ebp)
  801f3f:	ff 75 08             	pushl  0x8(%ebp)
  801f42:	6a 0a                	push   $0xa
  801f44:	e8 99 fe ff ff       	call   801de2 <syscall>
  801f49:	83 c4 18             	add    $0x18,%esp
}
  801f4c:	c9                   	leave  
  801f4d:	c3                   	ret    

00801f4e <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801f4e:	55                   	push   %ebp
  801f4f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801f51:	6a 00                	push   $0x0
  801f53:	6a 00                	push   $0x0
  801f55:	6a 00                	push   $0x0
  801f57:	6a 00                	push   $0x0
  801f59:	6a 00                	push   $0x0
  801f5b:	6a 0b                	push   $0xb
  801f5d:	e8 80 fe ff ff       	call   801de2 <syscall>
  801f62:	83 c4 18             	add    $0x18,%esp
}
  801f65:	c9                   	leave  
  801f66:	c3                   	ret    

00801f67 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801f67:	55                   	push   %ebp
  801f68:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801f6a:	6a 00                	push   $0x0
  801f6c:	6a 00                	push   $0x0
  801f6e:	6a 00                	push   $0x0
  801f70:	6a 00                	push   $0x0
  801f72:	6a 00                	push   $0x0
  801f74:	6a 0c                	push   $0xc
  801f76:	e8 67 fe ff ff       	call   801de2 <syscall>
  801f7b:	83 c4 18             	add    $0x18,%esp
}
  801f7e:	c9                   	leave  
  801f7f:	c3                   	ret    

00801f80 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801f80:	55                   	push   %ebp
  801f81:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801f83:	6a 00                	push   $0x0
  801f85:	6a 00                	push   $0x0
  801f87:	6a 00                	push   $0x0
  801f89:	6a 00                	push   $0x0
  801f8b:	6a 00                	push   $0x0
  801f8d:	6a 0d                	push   $0xd
  801f8f:	e8 4e fe ff ff       	call   801de2 <syscall>
  801f94:	83 c4 18             	add    $0x18,%esp
}
  801f97:	c9                   	leave  
  801f98:	c3                   	ret    

00801f99 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801f99:	55                   	push   %ebp
  801f9a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801f9c:	6a 00                	push   $0x0
  801f9e:	6a 00                	push   $0x0
  801fa0:	6a 00                	push   $0x0
  801fa2:	ff 75 0c             	pushl  0xc(%ebp)
  801fa5:	ff 75 08             	pushl  0x8(%ebp)
  801fa8:	6a 11                	push   $0x11
  801faa:	e8 33 fe ff ff       	call   801de2 <syscall>
  801faf:	83 c4 18             	add    $0x18,%esp
	return;
  801fb2:	90                   	nop
}
  801fb3:	c9                   	leave  
  801fb4:	c3                   	ret    

00801fb5 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801fb5:	55                   	push   %ebp
  801fb6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801fb8:	6a 00                	push   $0x0
  801fba:	6a 00                	push   $0x0
  801fbc:	6a 00                	push   $0x0
  801fbe:	ff 75 0c             	pushl  0xc(%ebp)
  801fc1:	ff 75 08             	pushl  0x8(%ebp)
  801fc4:	6a 12                	push   $0x12
  801fc6:	e8 17 fe ff ff       	call   801de2 <syscall>
  801fcb:	83 c4 18             	add    $0x18,%esp
	return ;
  801fce:	90                   	nop
}
  801fcf:	c9                   	leave  
  801fd0:	c3                   	ret    

00801fd1 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801fd1:	55                   	push   %ebp
  801fd2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801fd4:	6a 00                	push   $0x0
  801fd6:	6a 00                	push   $0x0
  801fd8:	6a 00                	push   $0x0
  801fda:	6a 00                	push   $0x0
  801fdc:	6a 00                	push   $0x0
  801fde:	6a 0e                	push   $0xe
  801fe0:	e8 fd fd ff ff       	call   801de2 <syscall>
  801fe5:	83 c4 18             	add    $0x18,%esp
}
  801fe8:	c9                   	leave  
  801fe9:	c3                   	ret    

00801fea <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801fea:	55                   	push   %ebp
  801feb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801fed:	6a 00                	push   $0x0
  801fef:	6a 00                	push   $0x0
  801ff1:	6a 00                	push   $0x0
  801ff3:	6a 00                	push   $0x0
  801ff5:	ff 75 08             	pushl  0x8(%ebp)
  801ff8:	6a 0f                	push   $0xf
  801ffa:	e8 e3 fd ff ff       	call   801de2 <syscall>
  801fff:	83 c4 18             	add    $0x18,%esp
}
  802002:	c9                   	leave  
  802003:	c3                   	ret    

00802004 <sys_scarce_memory>:

void sys_scarce_memory()
{
  802004:	55                   	push   %ebp
  802005:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  802007:	6a 00                	push   $0x0
  802009:	6a 00                	push   $0x0
  80200b:	6a 00                	push   $0x0
  80200d:	6a 00                	push   $0x0
  80200f:	6a 00                	push   $0x0
  802011:	6a 10                	push   $0x10
  802013:	e8 ca fd ff ff       	call   801de2 <syscall>
  802018:	83 c4 18             	add    $0x18,%esp
}
  80201b:	90                   	nop
  80201c:	c9                   	leave  
  80201d:	c3                   	ret    

0080201e <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80201e:	55                   	push   %ebp
  80201f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  802021:	6a 00                	push   $0x0
  802023:	6a 00                	push   $0x0
  802025:	6a 00                	push   $0x0
  802027:	6a 00                	push   $0x0
  802029:	6a 00                	push   $0x0
  80202b:	6a 14                	push   $0x14
  80202d:	e8 b0 fd ff ff       	call   801de2 <syscall>
  802032:	83 c4 18             	add    $0x18,%esp
}
  802035:	90                   	nop
  802036:	c9                   	leave  
  802037:	c3                   	ret    

00802038 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  802038:	55                   	push   %ebp
  802039:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80203b:	6a 00                	push   $0x0
  80203d:	6a 00                	push   $0x0
  80203f:	6a 00                	push   $0x0
  802041:	6a 00                	push   $0x0
  802043:	6a 00                	push   $0x0
  802045:	6a 15                	push   $0x15
  802047:	e8 96 fd ff ff       	call   801de2 <syscall>
  80204c:	83 c4 18             	add    $0x18,%esp
}
  80204f:	90                   	nop
  802050:	c9                   	leave  
  802051:	c3                   	ret    

00802052 <sys_cputc>:


void
sys_cputc(const char c)
{
  802052:	55                   	push   %ebp
  802053:	89 e5                	mov    %esp,%ebp
  802055:	83 ec 04             	sub    $0x4,%esp
  802058:	8b 45 08             	mov    0x8(%ebp),%eax
  80205b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80205e:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802062:	6a 00                	push   $0x0
  802064:	6a 00                	push   $0x0
  802066:	6a 00                	push   $0x0
  802068:	6a 00                	push   $0x0
  80206a:	50                   	push   %eax
  80206b:	6a 16                	push   $0x16
  80206d:	e8 70 fd ff ff       	call   801de2 <syscall>
  802072:	83 c4 18             	add    $0x18,%esp
}
  802075:	90                   	nop
  802076:	c9                   	leave  
  802077:	c3                   	ret    

00802078 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  802078:	55                   	push   %ebp
  802079:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  80207b:	6a 00                	push   $0x0
  80207d:	6a 00                	push   $0x0
  80207f:	6a 00                	push   $0x0
  802081:	6a 00                	push   $0x0
  802083:	6a 00                	push   $0x0
  802085:	6a 17                	push   $0x17
  802087:	e8 56 fd ff ff       	call   801de2 <syscall>
  80208c:	83 c4 18             	add    $0x18,%esp
}
  80208f:	90                   	nop
  802090:	c9                   	leave  
  802091:	c3                   	ret    

00802092 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  802092:	55                   	push   %ebp
  802093:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  802095:	8b 45 08             	mov    0x8(%ebp),%eax
  802098:	6a 00                	push   $0x0
  80209a:	6a 00                	push   $0x0
  80209c:	6a 00                	push   $0x0
  80209e:	ff 75 0c             	pushl  0xc(%ebp)
  8020a1:	50                   	push   %eax
  8020a2:	6a 18                	push   $0x18
  8020a4:	e8 39 fd ff ff       	call   801de2 <syscall>
  8020a9:	83 c4 18             	add    $0x18,%esp
}
  8020ac:	c9                   	leave  
  8020ad:	c3                   	ret    

008020ae <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8020ae:	55                   	push   %ebp
  8020af:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8020b1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8020b7:	6a 00                	push   $0x0
  8020b9:	6a 00                	push   $0x0
  8020bb:	6a 00                	push   $0x0
  8020bd:	52                   	push   %edx
  8020be:	50                   	push   %eax
  8020bf:	6a 1b                	push   $0x1b
  8020c1:	e8 1c fd ff ff       	call   801de2 <syscall>
  8020c6:	83 c4 18             	add    $0x18,%esp
}
  8020c9:	c9                   	leave  
  8020ca:	c3                   	ret    

008020cb <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8020cb:	55                   	push   %ebp
  8020cc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8020ce:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8020d4:	6a 00                	push   $0x0
  8020d6:	6a 00                	push   $0x0
  8020d8:	6a 00                	push   $0x0
  8020da:	52                   	push   %edx
  8020db:	50                   	push   %eax
  8020dc:	6a 19                	push   $0x19
  8020de:	e8 ff fc ff ff       	call   801de2 <syscall>
  8020e3:	83 c4 18             	add    $0x18,%esp
}
  8020e6:	90                   	nop
  8020e7:	c9                   	leave  
  8020e8:	c3                   	ret    

008020e9 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8020e9:	55                   	push   %ebp
  8020ea:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8020ec:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8020f2:	6a 00                	push   $0x0
  8020f4:	6a 00                	push   $0x0
  8020f6:	6a 00                	push   $0x0
  8020f8:	52                   	push   %edx
  8020f9:	50                   	push   %eax
  8020fa:	6a 1a                	push   $0x1a
  8020fc:	e8 e1 fc ff ff       	call   801de2 <syscall>
  802101:	83 c4 18             	add    $0x18,%esp
}
  802104:	90                   	nop
  802105:	c9                   	leave  
  802106:	c3                   	ret    

00802107 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  802107:	55                   	push   %ebp
  802108:	89 e5                	mov    %esp,%ebp
  80210a:	83 ec 04             	sub    $0x4,%esp
  80210d:	8b 45 10             	mov    0x10(%ebp),%eax
  802110:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  802113:	8b 4d 14             	mov    0x14(%ebp),%ecx
  802116:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80211a:	8b 45 08             	mov    0x8(%ebp),%eax
  80211d:	6a 00                	push   $0x0
  80211f:	51                   	push   %ecx
  802120:	52                   	push   %edx
  802121:	ff 75 0c             	pushl  0xc(%ebp)
  802124:	50                   	push   %eax
  802125:	6a 1c                	push   $0x1c
  802127:	e8 b6 fc ff ff       	call   801de2 <syscall>
  80212c:	83 c4 18             	add    $0x18,%esp
}
  80212f:	c9                   	leave  
  802130:	c3                   	ret    

00802131 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  802131:	55                   	push   %ebp
  802132:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  802134:	8b 55 0c             	mov    0xc(%ebp),%edx
  802137:	8b 45 08             	mov    0x8(%ebp),%eax
  80213a:	6a 00                	push   $0x0
  80213c:	6a 00                	push   $0x0
  80213e:	6a 00                	push   $0x0
  802140:	52                   	push   %edx
  802141:	50                   	push   %eax
  802142:	6a 1d                	push   $0x1d
  802144:	e8 99 fc ff ff       	call   801de2 <syscall>
  802149:	83 c4 18             	add    $0x18,%esp
}
  80214c:	c9                   	leave  
  80214d:	c3                   	ret    

0080214e <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  80214e:	55                   	push   %ebp
  80214f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  802151:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802154:	8b 55 0c             	mov    0xc(%ebp),%edx
  802157:	8b 45 08             	mov    0x8(%ebp),%eax
  80215a:	6a 00                	push   $0x0
  80215c:	6a 00                	push   $0x0
  80215e:	51                   	push   %ecx
  80215f:	52                   	push   %edx
  802160:	50                   	push   %eax
  802161:	6a 1e                	push   $0x1e
  802163:	e8 7a fc ff ff       	call   801de2 <syscall>
  802168:	83 c4 18             	add    $0x18,%esp
}
  80216b:	c9                   	leave  
  80216c:	c3                   	ret    

0080216d <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  80216d:	55                   	push   %ebp
  80216e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  802170:	8b 55 0c             	mov    0xc(%ebp),%edx
  802173:	8b 45 08             	mov    0x8(%ebp),%eax
  802176:	6a 00                	push   $0x0
  802178:	6a 00                	push   $0x0
  80217a:	6a 00                	push   $0x0
  80217c:	52                   	push   %edx
  80217d:	50                   	push   %eax
  80217e:	6a 1f                	push   $0x1f
  802180:	e8 5d fc ff ff       	call   801de2 <syscall>
  802185:	83 c4 18             	add    $0x18,%esp
}
  802188:	c9                   	leave  
  802189:	c3                   	ret    

0080218a <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  80218a:	55                   	push   %ebp
  80218b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  80218d:	6a 00                	push   $0x0
  80218f:	6a 00                	push   $0x0
  802191:	6a 00                	push   $0x0
  802193:	6a 00                	push   $0x0
  802195:	6a 00                	push   $0x0
  802197:	6a 20                	push   $0x20
  802199:	e8 44 fc ff ff       	call   801de2 <syscall>
  80219e:	83 c4 18             	add    $0x18,%esp
}
  8021a1:	c9                   	leave  
  8021a2:	c3                   	ret    

008021a3 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8021a3:	55                   	push   %ebp
  8021a4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8021a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8021a9:	6a 00                	push   $0x0
  8021ab:	ff 75 14             	pushl  0x14(%ebp)
  8021ae:	ff 75 10             	pushl  0x10(%ebp)
  8021b1:	ff 75 0c             	pushl  0xc(%ebp)
  8021b4:	50                   	push   %eax
  8021b5:	6a 21                	push   $0x21
  8021b7:	e8 26 fc ff ff       	call   801de2 <syscall>
  8021bc:	83 c4 18             	add    $0x18,%esp
}
  8021bf:	c9                   	leave  
  8021c0:	c3                   	ret    

008021c1 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8021c1:	55                   	push   %ebp
  8021c2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8021c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8021c7:	6a 00                	push   $0x0
  8021c9:	6a 00                	push   $0x0
  8021cb:	6a 00                	push   $0x0
  8021cd:	6a 00                	push   $0x0
  8021cf:	50                   	push   %eax
  8021d0:	6a 22                	push   $0x22
  8021d2:	e8 0b fc ff ff       	call   801de2 <syscall>
  8021d7:	83 c4 18             	add    $0x18,%esp
}
  8021da:	90                   	nop
  8021db:	c9                   	leave  
  8021dc:	c3                   	ret    

008021dd <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8021dd:	55                   	push   %ebp
  8021de:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8021e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8021e3:	6a 00                	push   $0x0
  8021e5:	6a 00                	push   $0x0
  8021e7:	6a 00                	push   $0x0
  8021e9:	6a 00                	push   $0x0
  8021eb:	50                   	push   %eax
  8021ec:	6a 23                	push   $0x23
  8021ee:	e8 ef fb ff ff       	call   801de2 <syscall>
  8021f3:	83 c4 18             	add    $0x18,%esp
}
  8021f6:	90                   	nop
  8021f7:	c9                   	leave  
  8021f8:	c3                   	ret    

008021f9 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8021f9:	55                   	push   %ebp
  8021fa:	89 e5                	mov    %esp,%ebp
  8021fc:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8021ff:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802202:	8d 50 04             	lea    0x4(%eax),%edx
  802205:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802208:	6a 00                	push   $0x0
  80220a:	6a 00                	push   $0x0
  80220c:	6a 00                	push   $0x0
  80220e:	52                   	push   %edx
  80220f:	50                   	push   %eax
  802210:	6a 24                	push   $0x24
  802212:	e8 cb fb ff ff       	call   801de2 <syscall>
  802217:	83 c4 18             	add    $0x18,%esp
	return result;
  80221a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80221d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802220:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802223:	89 01                	mov    %eax,(%ecx)
  802225:	89 51 04             	mov    %edx,0x4(%ecx)
}
  802228:	8b 45 08             	mov    0x8(%ebp),%eax
  80222b:	c9                   	leave  
  80222c:	c2 04 00             	ret    $0x4

0080222f <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80222f:	55                   	push   %ebp
  802230:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  802232:	6a 00                	push   $0x0
  802234:	6a 00                	push   $0x0
  802236:	ff 75 10             	pushl  0x10(%ebp)
  802239:	ff 75 0c             	pushl  0xc(%ebp)
  80223c:	ff 75 08             	pushl  0x8(%ebp)
  80223f:	6a 13                	push   $0x13
  802241:	e8 9c fb ff ff       	call   801de2 <syscall>
  802246:	83 c4 18             	add    $0x18,%esp
	return ;
  802249:	90                   	nop
}
  80224a:	c9                   	leave  
  80224b:	c3                   	ret    

0080224c <sys_rcr2>:
uint32 sys_rcr2()
{
  80224c:	55                   	push   %ebp
  80224d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  80224f:	6a 00                	push   $0x0
  802251:	6a 00                	push   $0x0
  802253:	6a 00                	push   $0x0
  802255:	6a 00                	push   $0x0
  802257:	6a 00                	push   $0x0
  802259:	6a 25                	push   $0x25
  80225b:	e8 82 fb ff ff       	call   801de2 <syscall>
  802260:	83 c4 18             	add    $0x18,%esp
}
  802263:	c9                   	leave  
  802264:	c3                   	ret    

00802265 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  802265:	55                   	push   %ebp
  802266:	89 e5                	mov    %esp,%ebp
  802268:	83 ec 04             	sub    $0x4,%esp
  80226b:	8b 45 08             	mov    0x8(%ebp),%eax
  80226e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  802271:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  802275:	6a 00                	push   $0x0
  802277:	6a 00                	push   $0x0
  802279:	6a 00                	push   $0x0
  80227b:	6a 00                	push   $0x0
  80227d:	50                   	push   %eax
  80227e:	6a 26                	push   $0x26
  802280:	e8 5d fb ff ff       	call   801de2 <syscall>
  802285:	83 c4 18             	add    $0x18,%esp
	return ;
  802288:	90                   	nop
}
  802289:	c9                   	leave  
  80228a:	c3                   	ret    

0080228b <rsttst>:
void rsttst()
{
  80228b:	55                   	push   %ebp
  80228c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  80228e:	6a 00                	push   $0x0
  802290:	6a 00                	push   $0x0
  802292:	6a 00                	push   $0x0
  802294:	6a 00                	push   $0x0
  802296:	6a 00                	push   $0x0
  802298:	6a 28                	push   $0x28
  80229a:	e8 43 fb ff ff       	call   801de2 <syscall>
  80229f:	83 c4 18             	add    $0x18,%esp
	return ;
  8022a2:	90                   	nop
}
  8022a3:	c9                   	leave  
  8022a4:	c3                   	ret    

008022a5 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8022a5:	55                   	push   %ebp
  8022a6:	89 e5                	mov    %esp,%ebp
  8022a8:	83 ec 04             	sub    $0x4,%esp
  8022ab:	8b 45 14             	mov    0x14(%ebp),%eax
  8022ae:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8022b1:	8b 55 18             	mov    0x18(%ebp),%edx
  8022b4:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8022b8:	52                   	push   %edx
  8022b9:	50                   	push   %eax
  8022ba:	ff 75 10             	pushl  0x10(%ebp)
  8022bd:	ff 75 0c             	pushl  0xc(%ebp)
  8022c0:	ff 75 08             	pushl  0x8(%ebp)
  8022c3:	6a 27                	push   $0x27
  8022c5:	e8 18 fb ff ff       	call   801de2 <syscall>
  8022ca:	83 c4 18             	add    $0x18,%esp
	return ;
  8022cd:	90                   	nop
}
  8022ce:	c9                   	leave  
  8022cf:	c3                   	ret    

008022d0 <chktst>:
void chktst(uint32 n)
{
  8022d0:	55                   	push   %ebp
  8022d1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8022d3:	6a 00                	push   $0x0
  8022d5:	6a 00                	push   $0x0
  8022d7:	6a 00                	push   $0x0
  8022d9:	6a 00                	push   $0x0
  8022db:	ff 75 08             	pushl  0x8(%ebp)
  8022de:	6a 29                	push   $0x29
  8022e0:	e8 fd fa ff ff       	call   801de2 <syscall>
  8022e5:	83 c4 18             	add    $0x18,%esp
	return ;
  8022e8:	90                   	nop
}
  8022e9:	c9                   	leave  
  8022ea:	c3                   	ret    

008022eb <inctst>:

void inctst()
{
  8022eb:	55                   	push   %ebp
  8022ec:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8022ee:	6a 00                	push   $0x0
  8022f0:	6a 00                	push   $0x0
  8022f2:	6a 00                	push   $0x0
  8022f4:	6a 00                	push   $0x0
  8022f6:	6a 00                	push   $0x0
  8022f8:	6a 2a                	push   $0x2a
  8022fa:	e8 e3 fa ff ff       	call   801de2 <syscall>
  8022ff:	83 c4 18             	add    $0x18,%esp
	return ;
  802302:	90                   	nop
}
  802303:	c9                   	leave  
  802304:	c3                   	ret    

00802305 <gettst>:
uint32 gettst()
{
  802305:	55                   	push   %ebp
  802306:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802308:	6a 00                	push   $0x0
  80230a:	6a 00                	push   $0x0
  80230c:	6a 00                	push   $0x0
  80230e:	6a 00                	push   $0x0
  802310:	6a 00                	push   $0x0
  802312:	6a 2b                	push   $0x2b
  802314:	e8 c9 fa ff ff       	call   801de2 <syscall>
  802319:	83 c4 18             	add    $0x18,%esp
}
  80231c:	c9                   	leave  
  80231d:	c3                   	ret    

0080231e <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  80231e:	55                   	push   %ebp
  80231f:	89 e5                	mov    %esp,%ebp
  802321:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802324:	6a 00                	push   $0x0
  802326:	6a 00                	push   $0x0
  802328:	6a 00                	push   $0x0
  80232a:	6a 00                	push   $0x0
  80232c:	6a 00                	push   $0x0
  80232e:	6a 2c                	push   $0x2c
  802330:	e8 ad fa ff ff       	call   801de2 <syscall>
  802335:	83 c4 18             	add    $0x18,%esp
  802338:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80233b:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  80233f:	75 07                	jne    802348 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802341:	b8 01 00 00 00       	mov    $0x1,%eax
  802346:	eb 05                	jmp    80234d <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  802348:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80234d:	c9                   	leave  
  80234e:	c3                   	ret    

0080234f <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  80234f:	55                   	push   %ebp
  802350:	89 e5                	mov    %esp,%ebp
  802352:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802355:	6a 00                	push   $0x0
  802357:	6a 00                	push   $0x0
  802359:	6a 00                	push   $0x0
  80235b:	6a 00                	push   $0x0
  80235d:	6a 00                	push   $0x0
  80235f:	6a 2c                	push   $0x2c
  802361:	e8 7c fa ff ff       	call   801de2 <syscall>
  802366:	83 c4 18             	add    $0x18,%esp
  802369:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  80236c:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  802370:	75 07                	jne    802379 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  802372:	b8 01 00 00 00       	mov    $0x1,%eax
  802377:	eb 05                	jmp    80237e <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  802379:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80237e:	c9                   	leave  
  80237f:	c3                   	ret    

00802380 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  802380:	55                   	push   %ebp
  802381:	89 e5                	mov    %esp,%ebp
  802383:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802386:	6a 00                	push   $0x0
  802388:	6a 00                	push   $0x0
  80238a:	6a 00                	push   $0x0
  80238c:	6a 00                	push   $0x0
  80238e:	6a 00                	push   $0x0
  802390:	6a 2c                	push   $0x2c
  802392:	e8 4b fa ff ff       	call   801de2 <syscall>
  802397:	83 c4 18             	add    $0x18,%esp
  80239a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  80239d:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8023a1:	75 07                	jne    8023aa <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8023a3:	b8 01 00 00 00       	mov    $0x1,%eax
  8023a8:	eb 05                	jmp    8023af <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8023aa:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8023af:	c9                   	leave  
  8023b0:	c3                   	ret    

008023b1 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8023b1:	55                   	push   %ebp
  8023b2:	89 e5                	mov    %esp,%ebp
  8023b4:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8023b7:	6a 00                	push   $0x0
  8023b9:	6a 00                	push   $0x0
  8023bb:	6a 00                	push   $0x0
  8023bd:	6a 00                	push   $0x0
  8023bf:	6a 00                	push   $0x0
  8023c1:	6a 2c                	push   $0x2c
  8023c3:	e8 1a fa ff ff       	call   801de2 <syscall>
  8023c8:	83 c4 18             	add    $0x18,%esp
  8023cb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8023ce:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8023d2:	75 07                	jne    8023db <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8023d4:	b8 01 00 00 00       	mov    $0x1,%eax
  8023d9:	eb 05                	jmp    8023e0 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8023db:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8023e0:	c9                   	leave  
  8023e1:	c3                   	ret    

008023e2 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8023e2:	55                   	push   %ebp
  8023e3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8023e5:	6a 00                	push   $0x0
  8023e7:	6a 00                	push   $0x0
  8023e9:	6a 00                	push   $0x0
  8023eb:	6a 00                	push   $0x0
  8023ed:	ff 75 08             	pushl  0x8(%ebp)
  8023f0:	6a 2d                	push   $0x2d
  8023f2:	e8 eb f9 ff ff       	call   801de2 <syscall>
  8023f7:	83 c4 18             	add    $0x18,%esp
	return ;
  8023fa:	90                   	nop
}
  8023fb:	c9                   	leave  
  8023fc:	c3                   	ret    

008023fd <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8023fd:	55                   	push   %ebp
  8023fe:	89 e5                	mov    %esp,%ebp
  802400:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  802401:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802404:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802407:	8b 55 0c             	mov    0xc(%ebp),%edx
  80240a:	8b 45 08             	mov    0x8(%ebp),%eax
  80240d:	6a 00                	push   $0x0
  80240f:	53                   	push   %ebx
  802410:	51                   	push   %ecx
  802411:	52                   	push   %edx
  802412:	50                   	push   %eax
  802413:	6a 2e                	push   $0x2e
  802415:	e8 c8 f9 ff ff       	call   801de2 <syscall>
  80241a:	83 c4 18             	add    $0x18,%esp
}
  80241d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  802420:	c9                   	leave  
  802421:	c3                   	ret    

00802422 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  802422:	55                   	push   %ebp
  802423:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  802425:	8b 55 0c             	mov    0xc(%ebp),%edx
  802428:	8b 45 08             	mov    0x8(%ebp),%eax
  80242b:	6a 00                	push   $0x0
  80242d:	6a 00                	push   $0x0
  80242f:	6a 00                	push   $0x0
  802431:	52                   	push   %edx
  802432:	50                   	push   %eax
  802433:	6a 2f                	push   $0x2f
  802435:	e8 a8 f9 ff ff       	call   801de2 <syscall>
  80243a:	83 c4 18             	add    $0x18,%esp
}
  80243d:	c9                   	leave  
  80243e:	c3                   	ret    
  80243f:	90                   	nop

00802440 <__udivdi3>:
  802440:	55                   	push   %ebp
  802441:	57                   	push   %edi
  802442:	56                   	push   %esi
  802443:	53                   	push   %ebx
  802444:	83 ec 1c             	sub    $0x1c,%esp
  802447:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80244b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80244f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802453:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  802457:	89 ca                	mov    %ecx,%edx
  802459:	89 f8                	mov    %edi,%eax
  80245b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80245f:	85 f6                	test   %esi,%esi
  802461:	75 2d                	jne    802490 <__udivdi3+0x50>
  802463:	39 cf                	cmp    %ecx,%edi
  802465:	77 65                	ja     8024cc <__udivdi3+0x8c>
  802467:	89 fd                	mov    %edi,%ebp
  802469:	85 ff                	test   %edi,%edi
  80246b:	75 0b                	jne    802478 <__udivdi3+0x38>
  80246d:	b8 01 00 00 00       	mov    $0x1,%eax
  802472:	31 d2                	xor    %edx,%edx
  802474:	f7 f7                	div    %edi
  802476:	89 c5                	mov    %eax,%ebp
  802478:	31 d2                	xor    %edx,%edx
  80247a:	89 c8                	mov    %ecx,%eax
  80247c:	f7 f5                	div    %ebp
  80247e:	89 c1                	mov    %eax,%ecx
  802480:	89 d8                	mov    %ebx,%eax
  802482:	f7 f5                	div    %ebp
  802484:	89 cf                	mov    %ecx,%edi
  802486:	89 fa                	mov    %edi,%edx
  802488:	83 c4 1c             	add    $0x1c,%esp
  80248b:	5b                   	pop    %ebx
  80248c:	5e                   	pop    %esi
  80248d:	5f                   	pop    %edi
  80248e:	5d                   	pop    %ebp
  80248f:	c3                   	ret    
  802490:	39 ce                	cmp    %ecx,%esi
  802492:	77 28                	ja     8024bc <__udivdi3+0x7c>
  802494:	0f bd fe             	bsr    %esi,%edi
  802497:	83 f7 1f             	xor    $0x1f,%edi
  80249a:	75 40                	jne    8024dc <__udivdi3+0x9c>
  80249c:	39 ce                	cmp    %ecx,%esi
  80249e:	72 0a                	jb     8024aa <__udivdi3+0x6a>
  8024a0:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8024a4:	0f 87 9e 00 00 00    	ja     802548 <__udivdi3+0x108>
  8024aa:	b8 01 00 00 00       	mov    $0x1,%eax
  8024af:	89 fa                	mov    %edi,%edx
  8024b1:	83 c4 1c             	add    $0x1c,%esp
  8024b4:	5b                   	pop    %ebx
  8024b5:	5e                   	pop    %esi
  8024b6:	5f                   	pop    %edi
  8024b7:	5d                   	pop    %ebp
  8024b8:	c3                   	ret    
  8024b9:	8d 76 00             	lea    0x0(%esi),%esi
  8024bc:	31 ff                	xor    %edi,%edi
  8024be:	31 c0                	xor    %eax,%eax
  8024c0:	89 fa                	mov    %edi,%edx
  8024c2:	83 c4 1c             	add    $0x1c,%esp
  8024c5:	5b                   	pop    %ebx
  8024c6:	5e                   	pop    %esi
  8024c7:	5f                   	pop    %edi
  8024c8:	5d                   	pop    %ebp
  8024c9:	c3                   	ret    
  8024ca:	66 90                	xchg   %ax,%ax
  8024cc:	89 d8                	mov    %ebx,%eax
  8024ce:	f7 f7                	div    %edi
  8024d0:	31 ff                	xor    %edi,%edi
  8024d2:	89 fa                	mov    %edi,%edx
  8024d4:	83 c4 1c             	add    $0x1c,%esp
  8024d7:	5b                   	pop    %ebx
  8024d8:	5e                   	pop    %esi
  8024d9:	5f                   	pop    %edi
  8024da:	5d                   	pop    %ebp
  8024db:	c3                   	ret    
  8024dc:	bd 20 00 00 00       	mov    $0x20,%ebp
  8024e1:	89 eb                	mov    %ebp,%ebx
  8024e3:	29 fb                	sub    %edi,%ebx
  8024e5:	89 f9                	mov    %edi,%ecx
  8024e7:	d3 e6                	shl    %cl,%esi
  8024e9:	89 c5                	mov    %eax,%ebp
  8024eb:	88 d9                	mov    %bl,%cl
  8024ed:	d3 ed                	shr    %cl,%ebp
  8024ef:	89 e9                	mov    %ebp,%ecx
  8024f1:	09 f1                	or     %esi,%ecx
  8024f3:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8024f7:	89 f9                	mov    %edi,%ecx
  8024f9:	d3 e0                	shl    %cl,%eax
  8024fb:	89 c5                	mov    %eax,%ebp
  8024fd:	89 d6                	mov    %edx,%esi
  8024ff:	88 d9                	mov    %bl,%cl
  802501:	d3 ee                	shr    %cl,%esi
  802503:	89 f9                	mov    %edi,%ecx
  802505:	d3 e2                	shl    %cl,%edx
  802507:	8b 44 24 08          	mov    0x8(%esp),%eax
  80250b:	88 d9                	mov    %bl,%cl
  80250d:	d3 e8                	shr    %cl,%eax
  80250f:	09 c2                	or     %eax,%edx
  802511:	89 d0                	mov    %edx,%eax
  802513:	89 f2                	mov    %esi,%edx
  802515:	f7 74 24 0c          	divl   0xc(%esp)
  802519:	89 d6                	mov    %edx,%esi
  80251b:	89 c3                	mov    %eax,%ebx
  80251d:	f7 e5                	mul    %ebp
  80251f:	39 d6                	cmp    %edx,%esi
  802521:	72 19                	jb     80253c <__udivdi3+0xfc>
  802523:	74 0b                	je     802530 <__udivdi3+0xf0>
  802525:	89 d8                	mov    %ebx,%eax
  802527:	31 ff                	xor    %edi,%edi
  802529:	e9 58 ff ff ff       	jmp    802486 <__udivdi3+0x46>
  80252e:	66 90                	xchg   %ax,%ax
  802530:	8b 54 24 08          	mov    0x8(%esp),%edx
  802534:	89 f9                	mov    %edi,%ecx
  802536:	d3 e2                	shl    %cl,%edx
  802538:	39 c2                	cmp    %eax,%edx
  80253a:	73 e9                	jae    802525 <__udivdi3+0xe5>
  80253c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80253f:	31 ff                	xor    %edi,%edi
  802541:	e9 40 ff ff ff       	jmp    802486 <__udivdi3+0x46>
  802546:	66 90                	xchg   %ax,%ax
  802548:	31 c0                	xor    %eax,%eax
  80254a:	e9 37 ff ff ff       	jmp    802486 <__udivdi3+0x46>
  80254f:	90                   	nop

00802550 <__umoddi3>:
  802550:	55                   	push   %ebp
  802551:	57                   	push   %edi
  802552:	56                   	push   %esi
  802553:	53                   	push   %ebx
  802554:	83 ec 1c             	sub    $0x1c,%esp
  802557:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80255b:	8b 74 24 34          	mov    0x34(%esp),%esi
  80255f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802563:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802567:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80256b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80256f:	89 f3                	mov    %esi,%ebx
  802571:	89 fa                	mov    %edi,%edx
  802573:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802577:	89 34 24             	mov    %esi,(%esp)
  80257a:	85 c0                	test   %eax,%eax
  80257c:	75 1a                	jne    802598 <__umoddi3+0x48>
  80257e:	39 f7                	cmp    %esi,%edi
  802580:	0f 86 a2 00 00 00    	jbe    802628 <__umoddi3+0xd8>
  802586:	89 c8                	mov    %ecx,%eax
  802588:	89 f2                	mov    %esi,%edx
  80258a:	f7 f7                	div    %edi
  80258c:	89 d0                	mov    %edx,%eax
  80258e:	31 d2                	xor    %edx,%edx
  802590:	83 c4 1c             	add    $0x1c,%esp
  802593:	5b                   	pop    %ebx
  802594:	5e                   	pop    %esi
  802595:	5f                   	pop    %edi
  802596:	5d                   	pop    %ebp
  802597:	c3                   	ret    
  802598:	39 f0                	cmp    %esi,%eax
  80259a:	0f 87 ac 00 00 00    	ja     80264c <__umoddi3+0xfc>
  8025a0:	0f bd e8             	bsr    %eax,%ebp
  8025a3:	83 f5 1f             	xor    $0x1f,%ebp
  8025a6:	0f 84 ac 00 00 00    	je     802658 <__umoddi3+0x108>
  8025ac:	bf 20 00 00 00       	mov    $0x20,%edi
  8025b1:	29 ef                	sub    %ebp,%edi
  8025b3:	89 fe                	mov    %edi,%esi
  8025b5:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8025b9:	89 e9                	mov    %ebp,%ecx
  8025bb:	d3 e0                	shl    %cl,%eax
  8025bd:	89 d7                	mov    %edx,%edi
  8025bf:	89 f1                	mov    %esi,%ecx
  8025c1:	d3 ef                	shr    %cl,%edi
  8025c3:	09 c7                	or     %eax,%edi
  8025c5:	89 e9                	mov    %ebp,%ecx
  8025c7:	d3 e2                	shl    %cl,%edx
  8025c9:	89 14 24             	mov    %edx,(%esp)
  8025cc:	89 d8                	mov    %ebx,%eax
  8025ce:	d3 e0                	shl    %cl,%eax
  8025d0:	89 c2                	mov    %eax,%edx
  8025d2:	8b 44 24 08          	mov    0x8(%esp),%eax
  8025d6:	d3 e0                	shl    %cl,%eax
  8025d8:	89 44 24 04          	mov    %eax,0x4(%esp)
  8025dc:	8b 44 24 08          	mov    0x8(%esp),%eax
  8025e0:	89 f1                	mov    %esi,%ecx
  8025e2:	d3 e8                	shr    %cl,%eax
  8025e4:	09 d0                	or     %edx,%eax
  8025e6:	d3 eb                	shr    %cl,%ebx
  8025e8:	89 da                	mov    %ebx,%edx
  8025ea:	f7 f7                	div    %edi
  8025ec:	89 d3                	mov    %edx,%ebx
  8025ee:	f7 24 24             	mull   (%esp)
  8025f1:	89 c6                	mov    %eax,%esi
  8025f3:	89 d1                	mov    %edx,%ecx
  8025f5:	39 d3                	cmp    %edx,%ebx
  8025f7:	0f 82 87 00 00 00    	jb     802684 <__umoddi3+0x134>
  8025fd:	0f 84 91 00 00 00    	je     802694 <__umoddi3+0x144>
  802603:	8b 54 24 04          	mov    0x4(%esp),%edx
  802607:	29 f2                	sub    %esi,%edx
  802609:	19 cb                	sbb    %ecx,%ebx
  80260b:	89 d8                	mov    %ebx,%eax
  80260d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802611:	d3 e0                	shl    %cl,%eax
  802613:	89 e9                	mov    %ebp,%ecx
  802615:	d3 ea                	shr    %cl,%edx
  802617:	09 d0                	or     %edx,%eax
  802619:	89 e9                	mov    %ebp,%ecx
  80261b:	d3 eb                	shr    %cl,%ebx
  80261d:	89 da                	mov    %ebx,%edx
  80261f:	83 c4 1c             	add    $0x1c,%esp
  802622:	5b                   	pop    %ebx
  802623:	5e                   	pop    %esi
  802624:	5f                   	pop    %edi
  802625:	5d                   	pop    %ebp
  802626:	c3                   	ret    
  802627:	90                   	nop
  802628:	89 fd                	mov    %edi,%ebp
  80262a:	85 ff                	test   %edi,%edi
  80262c:	75 0b                	jne    802639 <__umoddi3+0xe9>
  80262e:	b8 01 00 00 00       	mov    $0x1,%eax
  802633:	31 d2                	xor    %edx,%edx
  802635:	f7 f7                	div    %edi
  802637:	89 c5                	mov    %eax,%ebp
  802639:	89 f0                	mov    %esi,%eax
  80263b:	31 d2                	xor    %edx,%edx
  80263d:	f7 f5                	div    %ebp
  80263f:	89 c8                	mov    %ecx,%eax
  802641:	f7 f5                	div    %ebp
  802643:	89 d0                	mov    %edx,%eax
  802645:	e9 44 ff ff ff       	jmp    80258e <__umoddi3+0x3e>
  80264a:	66 90                	xchg   %ax,%ax
  80264c:	89 c8                	mov    %ecx,%eax
  80264e:	89 f2                	mov    %esi,%edx
  802650:	83 c4 1c             	add    $0x1c,%esp
  802653:	5b                   	pop    %ebx
  802654:	5e                   	pop    %esi
  802655:	5f                   	pop    %edi
  802656:	5d                   	pop    %ebp
  802657:	c3                   	ret    
  802658:	3b 04 24             	cmp    (%esp),%eax
  80265b:	72 06                	jb     802663 <__umoddi3+0x113>
  80265d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802661:	77 0f                	ja     802672 <__umoddi3+0x122>
  802663:	89 f2                	mov    %esi,%edx
  802665:	29 f9                	sub    %edi,%ecx
  802667:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80266b:	89 14 24             	mov    %edx,(%esp)
  80266e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802672:	8b 44 24 04          	mov    0x4(%esp),%eax
  802676:	8b 14 24             	mov    (%esp),%edx
  802679:	83 c4 1c             	add    $0x1c,%esp
  80267c:	5b                   	pop    %ebx
  80267d:	5e                   	pop    %esi
  80267e:	5f                   	pop    %edi
  80267f:	5d                   	pop    %ebp
  802680:	c3                   	ret    
  802681:	8d 76 00             	lea    0x0(%esi),%esi
  802684:	2b 04 24             	sub    (%esp),%eax
  802687:	19 fa                	sbb    %edi,%edx
  802689:	89 d1                	mov    %edx,%ecx
  80268b:	89 c6                	mov    %eax,%esi
  80268d:	e9 71 ff ff ff       	jmp    802603 <__umoddi3+0xb3>
  802692:	66 90                	xchg   %ax,%ax
  802694:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802698:	72 ea                	jb     802684 <__umoddi3+0x134>
  80269a:	89 d9                	mov    %ebx,%ecx
  80269c:	e9 62 ff ff ff       	jmp    802603 <__umoddi3+0xb3>
