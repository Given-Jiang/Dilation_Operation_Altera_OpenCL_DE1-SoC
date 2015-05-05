#define ROWS 1078
#define COLS 1920

__kernel
__attribute__((task))
void dilation(__global uchar* restrict img_in, __global uchar* restrict img_out, const unsigned int iterations)
{
    unsigned int count = 0;

	uchar rows[2 * COLS + 17];

    while(count != iterations)
    {	
		bool isMax = 0;

		#pragma unroll
		for (int i = COLS * 2 + 16; i > 0; --i)
		{
			rows[i] = rows[i - 1];
		}
		rows[0] = img_in[count];

		#pragma unroll
		for (int i = 0; i < 3 ; ++i)
		{
			#pragma unroll
			for (int j = 0; j < 17; ++j)
			{
				uchar pixel = rows[i * COLS + j];
				if (pixel == 255)
				{
					isMax = 1;
				}else if (isMax != 1)
				{
					isMax = 0;
				}
			}
		}
		uchar temp = 0;
		if (isMax)
		{
			temp = 255;
		}else
		{
			temp = 0;
		}
		img_out[count++] = temp;
	}
}


