
//CODIGO EN C
extern gdt_desc

void tareaActual(uint32_t virt);

void isr_100(uint32_t virt, uint32_t phy, uint16_t task_sel) {
    pushad();
    cargar_gdt();
    (gdt_entry_t*) gdt = gdt_desc->addr;
    (tss_t*) tss = gdt[(task_sel)>>3];

    uint32_t cr3Actual = rcr3();
    uint32_t cr3Siguiente = tss->cr3;
    uint32_t attrs = 0x117; //dudosisimo, pero creo que incluye U/S = 1 
    
    mmu_map_page(cr3Actual, virt, phy, attrs);
    mmu_map_page(cr3Siguiente, virt, phy, attrs);

    tss->eip = virt;
    tss->esp = ebp; 
    tss->esp0 = (tss->esp0 || 0xFFF); //pongo los ultimos 12 bits en 1 para mandarlo al final de la página

    tareaActual(virt);

    iret();
}


/*
a) para que la syscall pueda ser invocada, hay que definir el descriptor correspondiente a la misma 
en la IDT. tendríamos que ir a la IDT (sacando la dirección de IDTR) y cargar un descriptor con los siguientes atributos:
-offset y selector de segmento correspondientes a la ubicación de la rutina de atención
-P = 1
-DPL = 11
-type = 1110 (inchequeable)

c)La idea es primero buscar el CR3TSS de la tarea siguiente usando su selector (task_sel) en la GDT. 
Una vez conseguida, se consigue su CR3, y se mapea la dirección virtual a la física tanto 
en la tarea actual (usando rcr3() para conseguir el cr3 actual) y la tarea siguiente (buscando CR3 en la TSS).
Luego, se modifican los registros que contiene el TSS de la tarea siguiente: se cambia el puntero a la pila de nivel 0 y 3 cada uno a su base,
y el EIP a la dirección virtual que fue mapeada antes.
Una vez hechos los cambios para la tarea siguiente, se hacen para la actual. Se cambia el puntero a la pila de nivel 3 a su base, y se accede 
al EIP en la pila (que quedó de hacer el pushad al comienzo de la syscall) antes de hacer el iret, para que una vez terminada la interrupción,
recupere los registros

*/
