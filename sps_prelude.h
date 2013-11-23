/*
 * The magic prelude that needs to be included with the generated Pre-Scheme
 * GNU-C code.  The only bindings in here are those needed by the compiler
 * to compile itself.  
 */

#include <errno.h>
#include <stdlib.h>
#include <stdio.h>

typedef unsigned int sps_val;

#define sps_word_add(a,b) (((sps_val)(a))+((sps_val)(b)))
#define sps_word_sub(a,b) (((sps_val)(a))-((sps_val)(b)))
#define sps_int_lt(a,b) (((int)a)<((int)b))
#define sps_int_le(a,b) (((int)a)<=((int)b))
#define sps_int_gt(a,b) (((int)a)>((int)b))
#define sps_int_ge(a,b) (((int)a)>=((int)b))
#define sps_word_eq(a,b) ((a)==(b))
#define sps_word_mul(a,b) (((sps_val)(a))*((sps_val)(b)))
#define sps_rel_not(a) (!(a))
#define sps_word_quotient(a,b) (((sps_val)(a))/((sps_val)(b)))
#define sps_word_remainder(a,b) (((sps_val)(a))%((sps_val)(b)))
#define sps_word_lsl(a,b) (((sps_val)(a))<<((sps_val)(b)))
#define sps_word_lsr(a,b) (((sps_val)(a))>>((sps_val)(b)))
#define sps_word_and(a,b) (((sps_val)(a))&((sps_val)(b)))
#define sps_word_or(a,b) (((sps_val)(a))|((sps_val)(b)))
#define sps_word_xor(a,b) (((sps_val)(a))^((sps_val)(b)))
#define sps_word_not(a) (~((sps_val)(a)))
#define sps_byte_vector_ref(s,i) ((sps_val)(((unsigned char *)(s))[(i)]))
#define sps_string_ref(s,i) sps_byte_vector_ref(s, i)
#define sps_unspecified() ({ printf("<unspecified>\n"); (*(int *)0); })


#define trace_byte_vector_set 0

static sps_val sps_byte_vector_set(sps_val s, sps_val i, sps_val v)
{
	unsigned char * b = (unsigned char*)s;
	if (trace_byte_vector_set) printf("sps_byte_vector_set %x %d %x/%d\n", s, i, v, v);
	b[i] = v;
}

#define trace_vector_set 0

static sps_val sps_word_vector_set(sps_val s, sps_val i, sps_val v)
{
	sps_val * b = (sps_val *)s;
	if (trace_vector_set) printf("sps_word_vector_set %x %d %x/%d\n", s, i, v, v);
	b[i] = v;
}

#define trace_vector_ref 0

static sps_val sps_word_vector_ref(sps_val s, sps_val i)
{
	sps_val * b = (sps_val *)s;
	sps_val v;
	if (trace_vector_ref) printf("sps_word_vector_ref %x %d\n", s, i);
	v = b[i];
	if (trace_vector_ref) printf("sps_word_vector_ref %x %d = %x/%d\n", s, i, v, v);
	return v;
}

#define sps_int_to_char(i) (i)

#define trace_word_ref 0

static sps_val sps_word_ref(sps_val s)
{
	sps_val * b = (sps_val *)s;
	sps_val v;
	if (trace_word_ref) printf("sps_word_ref %x\n", s);
	v = *b;
	if (trace_word_ref) printf("sps_word_ref %x = %x/%d\n", s, v, v);
	return v;
}

#define trace_word_set 0

static sps_val sps_word_set(sps_val a, sps_val v)
{
	sps_val * b = (sps_val *)a;
	if (trace_word_set) printf("sps_word_set: %x = %d/%x\n", a, v, v);
	*b = v;
}


static sps_val sps_io_open_input(sps_val file_name_val)
{
	char const * file_name = (char const *)file_name_val;
	FILE * f = fopen(file_name, "r");
	return (sps_val)f;
}

static sps_val sps_io_open_output(sps_val file_name_val)
{
	char const * file_name = (char const *)file_name_val;
	FILE * f = fopen(file_name, "w");
	return (sps_val)f;
}


static sps_val sps_io_read(sps_val port, sps_val buffer, sps_val nbytes)
{
	FILE * f = (FILE *)port;
	void * b = (void *)buffer;
	size_t nobj = (size_t)nbytes;
	size_t nread = fread(b, 1, nobj, f); 
	return (sps_val)nread;
}


static sps_val sps_io_write(sps_val port, sps_val buffer, sps_val nbytes)
{
	FILE * f = (FILE *)port;
	const void * b = (const void *)buffer;
	size_t nobj = (size_t)nbytes;
	size_t nwritten = fwrite(b, 1, nobj, f); 
	return (sps_val)nwritten;
}


static sps_val sps_io_close(sps_val port)
{
	FILE * f = (FILE *)port;
	fclose(f);
}

#if sps_use_malloc
static sps_val sps_mem_range_alloc(sps_val n)
{
	size_t npages = (size_t)n;
	size_t nbytes = n*4096;
	void * r;
	if ((r = malloc(nbytes)) == 0) {
		fprintf(stdout, "sps_mem_range_alloc: error 0\n");
	}
	return (sps_val)r;
}

static sps_val sps_mem_range_free(sps_val from, sps_val to)
{
	void * a = (void *)from;
	printf("sps_mem_range_free: [%x, %x]\n", from, to);
	free(a);
	return 0;
}

#endif

/*
 * Currently hardwired to use mmap rather than the more portable malloc
 * since mmap does not allocate any extra memory and so tends to highlight
 * out of bounds errors that malloc masks
 */

#include <unistd.h>
#include <sys/mman.h>
static sps_val sps_mem_range_alloc(sps_val n)
{
	size_t npages = (size_t)n;
	size_t nbytes = n*4096;
	void * r;
	r= mmap(0, nbytes, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANON, 0, 0);
	if (r == MAP_FAILED) {
		fprintf(stdout, "sps_mem_range_alloc: error %d\n", errno);
	}
	return (sps_val)r;
}

static sps_val sps_mem_range_free(sps_val from, sps_val to)
{
	void * a = (void *)from;
	return munmap(a, to-from);
}


#if 0
#define sps_assert(expr) ({ if (!expr) { fprintf(stdout, "ASSERT ERROR: %s %d\n", __FILE__, __LINE__); abort();} 1; })
#endif
#define sps_assert(expr) 1

static sps_val sps_abort(void)
{
	fprintf(stderr, "sps_abort\n");
	abort();
}

#define sps_char_to_int(x) (x)
#define sps_io_stdout() ((sps_val)stdout)
#define sps_static_string(x) (x)

static sps_val sps_io_print_int(sps_val port, sps_val i)
{
	FILE * f = (FILE *)port;
	int d = (int)i;
	return (sps_val)fprintf(f, "%d", d);
}

static sps_val sps_io_print_hex_int(sps_val port, sps_val i)
{
	FILE * f = (FILE *)port;
	unsigned int d = (unsigned int)i;
	return (sps_val)fprintf(f, "0x%x", d);
}


static sps_val sps_io_newline(sps_val port)
{
	FILE * f = (FILE *)port;
	return (sps_val)fprintf(f, "\n");
}

#define sps_trace 0
