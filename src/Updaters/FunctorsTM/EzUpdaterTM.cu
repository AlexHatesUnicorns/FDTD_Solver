/*
 * EzUpdaterTM.cpp
 *
 *  Created on: 11 янв. 2016 г.
 *      Author: aleksandr
 */

#include "EzUpdaterTM.h"
#include "SmartIndex.h"

#include <thrust/device_vector.h>
#include <thrust/functional.h>

//   x x x x x
//   x o o o x
//   x o o o x
//   x o o o x
//   x x x x x

/*__host__ __device__
void EzUpdaterTM::operator() (const int indx) {
	// m и n - индексы в полноценных массивах
	// sizeY - размер полноценнго массива
	int m = indx/(sizeY-2) + 1;
	int n = indx%(sizeY-2) + 1;
	float Cezh = S * 377.0;
	Ez(m, n) = Ez(m, n) + Cezh * ((Hy(m, n) - Hy(m-1, n)) - (Hx(m, n) - Hx(m, n-1)));
}*/

__host__ __device__
void EzUpdaterTM::operator() (const int indx) {
	// m и n - индексы в полноценных массивах
	// sizeY - размер полноценнго массива
	int m = indx/(sizeY);
	int n = indx%(sizeY);
	float Cezh = S * 377.0;
	if ( (m>0 && m<sizeX-1) && (n>0 && n<sizeY-1) ) {
		Ez(m, n) = Ez(m, n) + Cezh / epsilon(m,n) * ((Hy(m, n) - Hy(m-1, n)) - (Hx(m, n) - Hx(m, n-1)));
	}
}