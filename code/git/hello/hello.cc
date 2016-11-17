#include <iostream>
#include <stddef.h>
#include <math.h>

using std::cout; using std::cin; using std::endl;

class X {
	private:
	int foobar;

	public:
	X() : foobar(2), derp(2){
		cout << "Object X at address: \"" <<
		    this << "\" constructed" << endl;
	}
	~X() {
		cout << "Object X at address: \"" <<
		    this << "\" destructed" << endl;
	}

	/*
	X& operator=(const int a) {
		derp = foobar = a;
		return *this;
	}
	X& operator=(const X a) {
		derp = foobar = a.foobar;
		return *this;
	}
	*/

	int derp;
	int operator+(const X &a);
	template <class T>
	X &operator=(const T &a);
};

int X::operator+(const X &a) {
	return this->foobar + a.foobar;
}

template <class T>
X &X::operator=(const T &a) {
	derp = foobar = a;
	return *this;
}

template <class T>
T expon(T n, T e) {
	T c = 0;
	for(int k = 0; k < abs(e); k++)
	    c = c*n;
	c = (e < 0) ? 1/c : c;
	return c;
}

template <class T>
int get_bit(T x) {
	int i = 0, b = 0;
	bool a;
	//for (i=0; i < 8; i++) {
	while (i < sizeof(x) * 8) {
		a = ((1 << i) & x)/pow(2, i);
		//printf("%d %d\n",a,i);
		b += (pow(10, i) * a);
		i++;
	}
	return b;
		//a += x % 2 **
	//return (1 << 0) & x
}

int main(int argc, char **argv)
{
	X x, y, z, *a, b[3];
	a = &b[0];
	char c[3] = { 'a', 'b', 'c' };
	for (int i=0; i < 3; i++)
		cout << (int *)&c[i] << endl;
	cout << c[0] << " in binary: " << get_bit(c[0]) << endl;
	cout << x.derp << " in binary: " << get_bit(x.derp) << endl;
	cout << x.derp << " " <<  y.derp << " " << z.derp << endl;
	z = y + x;
	x = z;
	cout << "Size of int: " << sizeof(int) << endl;
	cout << x.derp << " " <<  y.derp << " " << z.derp << endl;
	cout << b[0].derp << " " <<  b[1].derp << " " << b[2].derp << endl;
	for (int i=0; i < 3; i++) {
		cout << "Object at \"" << a << "\" is " << sizeof(X) << " bytes" << endl;
		cout << a->derp << " " << endl;
		//a = (X *)((char *)a - 1);
		a++;
	}
	cout << "Hello World!" << endl;
	cout << "Total: " << argc << endl;
	for (int i=0; i < argc; i++)
	    cout << "argv[" << i << "]: " << *(argv+i) << endl;
	return 0;
}

