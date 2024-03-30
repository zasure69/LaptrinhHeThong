#include <stdio.h>

void PrintBits(unsigned int x)
{
	int i;
	for (i = 8 * sizeof(x) - 1; i >= 0; i--)
	{
		(x & (1 << i)) ? putchar('1') : putchar('0');
	}
	printf("\n");
}
void PrintBitsOfByte(unsigned int x)
{
	int i;
	for (i = 7; i >= 0; i--)
	{
		(x & (1 << i)) ? putchar('1') : putchar('0');
	}
	printf("\n");
}

// 1.1
int bitOr(int x, int y)
{
	//PrintBits(x);
	//PrintBits(y);
	return ~(~x & ~y);
}

// 1.2
int negative(int x)
{
	//chuyển bù 1 ~x
	//+1 để thành bù 2
	return (~x)+1;
}

// 1.3
int getHexcha(int x, int n)
{
	//đưa Hexchar cần về 4 bit cuối --> x >> (n << 2)
	//lấy 4 bit dùng mask 0xf --> & 0xf
	return (x >> (n << 2)) & 0xf;
}

// 1.4
int flipByte(int x, int n)
{
	//lật byte (8 bits) sẽ lấy mask 0..11111111..0
	//để lật bit dùng phép xor
	//dịch đến vị trí byte thứ n sẽ là sẽ dịch 8n bits
	//8n = n << 3 
	return (x ^ (0xff << (n << 3)));
}

// 1.5
int divpw2(int x, int n)
{	
	//n dương thì x/2^n hay x >> n 
	//n âm thì x/2^n hay x * 2^(-n) hay x << (~n+1)
	//n dương --> n >> 31 sẽ có 32 bit 0 --> ((n >> 31) & ( x << (~n+1)) sẽ bằng 0) or (~(n >> 31) & (x >> n) sẽ bằng x >> n) --> lấy x >> n
	//n âm --> n >> 31 sẽ có 32 bit 1 --> ((n >> 31) & (x << (~n+1)) sẽ bằng (x << (~n+1))) or (~(n >> 31) & (x >> n) sẽ bằng 0) 
	//--> lấy (x << (~n+1))
	return (~(n >> 31) & (x >> n)) | ((n >> 31) & ( x << (~n+1)));
}



// 2.1
int isEqual(int x, int y)
{
	//2 số giống nhau xor sẽ bằng 0
	return !(x ^ y);
}

// 2.2
int is16x(int x)
{
	// những số chia hết cho 16 sẽ có 4 bit cuối đều bằng 0
	//lấy 4 bit cuối x & 0xf --> và kiểm tra có bằng 0 hay không
	return !(x & 0xf);
}

// 2.3
int isPositive(int x)
{
	return !(x >> 31) ^ !x;
}

// 2.4
int isGE2n(int x, int y)
{
	//lấy x - 2 ^ n nếu >= 0 thì trả về 1, < 0 thì trả về 0
	int i = ~(1 << y) + 1;
	x = x + i;
	return (!(x >> 31));
}

//hàm max(int x, int y)
int max(int x, int y) {
	return (~((x + (~y + 1)) >> 31) & x) | (((x + (~y + 1)) >> 31) & y);
}

int main()
{
	int score = 0;
	printf("Your evaluation result:");
	printf("\n1.1 bitOr");
	if (bitOr(3, -9) == (3 | -9))
	{
		printf("\tPass.");
		score += 1;
	}
	else
		printf("\tFailed.");

	printf("\n1.2 negative");
	if (negative(0) == 0 && negative(9) == -9 && negative(-5) == 5)
	{
		printf("\tPass.");
		score += 1;
	}
	else
		printf("\tFailed.");

	//1.3
	printf("\n1.3 getHexcha");
	if (getHexcha(26, 0) == 0xa && getHexcha(0x11223344, 1) == 0x4)
	{
		printf("\tPass.");
		score += 2;
	}
	else
		printf("\tFailed.");

	printf("\n1.4 flipByte");
	if (flipByte(10, 0) == 245 && flipByte(0, 1) == 65280 && flipByte(0x5501, 1) == 0xaa01)
	{
		printf("\tPass.");
		score += 3;
	}
	else
		printf("\tFailed.");
	//1.5
	printf("\n1.5 divpw2");
	if (divpw2(10, -1) == 20 && divpw2(15, -2) == 60 && divpw2(2, -4) == 32)
	{
		if (divpw2(10, 1) == 5 && divpw2(50, 2) == 12)
		{
			printf("\tAdvanced Pass.");
			score += 4;
		}
		else
		{
			printf("\tPass.");
			score += 3;
		}
	}
	else
		printf("\tFailed.");

	printf("\n2.1 isEqual");
	if (isEqual(4, 2) == 0 && isEqual(-4, -4) == 1 && isEqual(0, 10) == 0)
	{
		printf("\tPass.");
		score += 2;
	}
	else
		printf("\tFailed.");

	//2.2
	printf("\n2.2 is16x");
	if (is16x(16) == 1 && is16x(23) == 0 && is16x(0) == 1)
	{
		printf("\tPass.");
		score += 2;
	}
	else
		printf("\tFailed.");

	printf("\n2.3 isPositive");
	if (isPositive(10) == 1 && isPositive(-5) == 0 && isPositive(0) == 0)
	{
		printf("\tPass.");
		score += 3;
	}
	else
		printf("\tFailed.");


	//2.4
	printf("\n2.4 isGE2n");
	if (isGE2n(12, 4) == 0 && isGE2n(8, 3) == 1 && isGE2n(15, 2) == 1)
	{
		printf("\tPass.");
		score += 3;
	}
	else
		printf("\tFailed.");

	printf("\n--- FINAL RESULT ---");
	printf("\nScore: %.1f", (float)score / 2);
	if (score < 5)
		printf("\nTrouble when solving these problems? Contact your instructor to get some hints :)");
	else
	{
		if (score < 8)
			printf("\nNice work. But try harder.");
		else
		{
			if (score >= 10)
				printf("\nExcellent. We found a master in bit-wise operations :D");
			else
				printf("\nYou're almost there. Think more carefully in failed problems.");
		}
	}

	printf("\n----Function max(x, y)----\n");
	printf("max(5, 6): %i\n", max(5, 6));
	printf("max(5, 5): %i\n", max(5, 5));
	printf("max(10, 6): %i\n", max(10, 6));
	printf("\n\n\n");
}