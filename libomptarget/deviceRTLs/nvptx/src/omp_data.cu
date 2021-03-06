//===------------- objects.cu - NVPTX OpenMP GPU objects --------- CUDA -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is dual licensed under the MIT and the University of Illinois Open
// Source Licenses. See LICENSE.txt for details.
//
//===----------------------------------------------------------------------===//
//
// This file contains the data objects used on the GPU device.
//
//===----------------------------------------------------------------------===//

#include "omptarget-nvptx.h"
#include "state-queue.h"

////////////////////////////////////////////////////////////////////////////////
// global data holding OpenMP state information
////////////////////////////////////////////////////////////////////////////////

__device__
omptarget_nvptx_Queue<omptarget_nvptx_ThreadPrivateContext, OMP_STATE_COUNT>
    omptarget_nvptx_device_State[MAX_SM];

// Pointer to this team's OpenMP state object
__device__ __shared__ omptarget_nvptx_ThreadPrivateContext
    *omptarget_nvptx_threadPrivateContext;

////////////////////////////////////////////////////////////////////////////////
// The team master sets the outlined parallel function in this variable to
// communicate with the workers.  Since it is in shared memory, there is one
// copy of these variables for each kernel, instance, and team.
////////////////////////////////////////////////////////////////////////////////
volatile __device__ __shared__ omptarget_nvptx_WorkFn   omptarget_nvptx_workFn;

////////////////////////////////////////////////////////////////////////////////
// OpenMP kernel execution parameters
////////////////////////////////////////////////////////////////////////////////
__device__ __shared__ uint32_t execution_param;

////////////////////////////////////////////////////////////////////////////////
// Data sharing state
////////////////////////////////////////////////////////////////////////////////
__device__ __shared__ DataSharingStateTy DataSharingState;


////////////////////////////////////////////////////////////////////////////////
// Scratchpad for teams reduction.  FIXME: allocate it in the offload library.
////////////////////////////////////////////////////////////////////////////////
// FIXME
__device__ char scratchpad[262144];
__device__ unsigned timestamp = 0;

