/*
 * Updater1DTE.cpp
 *
 *  Created on: 01 февр. 2016 г.
 *      Author: aleksandr
 */

#include "Updater1DTE.h"
#include <iostream>

Updater1DTE::Updater1DTE() : grid(nullptr), source(nullptr) {}

void Updater1DTE::addSource(Source* _source) {
	source = _source;
}

void Updater1DTE::addGrid(Grid1DTE* _grid) {
	grid = _grid;
	updaterHz.setParams(grid->Ey.getDevicePtr(),
						grid->Hz.getDevicePtr(),
						grid->Ceye.getDevicePtr(),
						grid->Ceyh.getDevicePtr(),
						grid->size);
	updaterEy.setParams(grid->Ey.getDevicePtr(),
						grid->Hz.getDevicePtr(),
						grid->Chzh.getDevicePtr(),
						grid->Chze.getDevicePtr(),
						grid->size);
}

void Updater1DTE::updateFields() {
	updateEy();
	updateHz();
	int xCoord = source->getPositionX();
	auto dptr = &(grid->Hz.getDevicePtr())[xCoord];
	source->updateField(dptr, grid->time);
	(grid->time)++;
}

void Updater1DTE::updateSources() {}

