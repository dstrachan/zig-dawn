const std = @import("std");
const wgpu = @import("wgpu");

test {
    std.testing.refAllDecls(@This());
}

pub const StringView = extern struct {
    data: ?[*]const u8 = null,
    length: usize = wgpu.WGPU_STRLEN,

    pub fn toSlice(view: StringView) []const u8 {
        return if (view.data) |data| data[0..view.length] else "";
    }

    pub fn fromSlice(slice: ?[]const u8) StringView {
        return if (slice) |s| .{ .data = s.ptr, .length = s.len } else .{};
    }

    pub fn fromSliceSentinel(slice: ?[:0]const u8) StringView {
        return if (slice) |s| .{ .data = s.ptr } else .{};
    }
};

pub const Bool = enum(u32) {
    false = 0,
    true = 1,
};

//
// Opaque types
//

pub const Adapter = *opaque {
    pub fn createDevice(adapter: Adapter, descriptor: ?*const DeviceDescriptor) Device {
        return wgpuAdapterCreateDevice(adapter, descriptor);
    }
    pub fn getFeatures(adapter: Adapter, features: *SupportedFeatures) void {
        return wgpuAdapterGetFeatures(adapter, features);
    }
    pub fn getFormatCapabilities(adapter: Adapter, format: TextureFormat, capabilities: *DawnFormatCapabilities) Status {
        return wgpuAdapterGetFormatCapabilities(adapter, format, capabilities);
    }
    pub fn getInfo(adapter: Adapter, info: *AdapterInfo) Status {
        return wgpuAdapterGetInfo(adapter, info);
    }
    pub fn getInstance(adapter: Adapter) Instance {
        return wgpuAdapterGetInstance(adapter);
    }
    pub fn getLimits(adapter: Adapter, limits: *Limits) Status {
        return wgpuAdapterGetLimits(adapter, limits);
    }
    pub fn hasFeature(adapter: Adapter, feature: FeatureName) Bool {
        return wgpuAdapterHasFeature(adapter, feature);
    }
    pub fn requestDevice(adapter: Adapter, descriptor: ?*const DeviceDescriptor, callback_info: RequestDeviceCallbackInfo) Future {
        return wgpuAdapterRequestDevice(adapter, descriptor, callback_info);
    }
    pub fn addRef(adapter: Adapter) void {
        return wgpuAdapterAddRef(adapter);
    }
    pub fn release(adapter: Adapter) void {
        return wgpuAdapterRelease(adapter);
    }
};

pub const BindGroup = *opaque {
    pub fn setLabel(bindGroup: BindGroup, label: StringView) void {
        return wgpuBindGroupSetLabel(bindGroup, label);
    }
    pub fn addRef(bindGroup: BindGroup) void {
        return wgpuBindGroupAddRef(bindGroup);
    }
    pub fn release(bindGroup: BindGroup) void {
        return wgpuBindGroupRelease(bindGroup);
    }
};

pub const BindGroupLayout = *opaque {
    pub fn setLabel(bindGroupLayout: BindGroupLayout, label: StringView) void {
        return wgpuBindGroupLayoutSetLabel(bindGroupLayout, label);
    }
    pub fn addRef(bindGroupLayout: BindGroupLayout) void {
        return wgpuBindGroupLayoutAddRef(bindGroupLayout);
    }
    pub fn release(bindGroupLayout: BindGroupLayout) void {
        return wgpuBindGroupLayoutRelease(bindGroupLayout);
    }
};

pub const Buffer = *opaque {
    pub fn createTexelView(buffer: Buffer, descriptor: *const TexelBufferViewDescriptor) TexelBufferView {
        return wgpuBufferCreateTexelView(buffer, descriptor);
    }
    pub fn destroy(buffer: Buffer) void {
        return wgpuBufferDestroy(buffer);
    }
    pub fn getConstMappedRange(buffer: Buffer, offset: usize, size: usize) ?*const anyopaque {
        return wgpuBufferGetConstMappedRange(buffer, offset, size);
    }
    pub fn getMappedRange(buffer: Buffer, offset: usize, size: usize) ?*anyopaque {
        return wgpuBufferGetMappedRange(buffer, offset, size);
    }
    pub fn getMapState(buffer: Buffer) BufferMapState {
        return wgpuBufferGetMapState(buffer);
    }
    pub fn getSize(buffer: Buffer) u64 {
        return wgpuBufferGetSize(buffer);
    }
    pub fn getUsage(buffer: Buffer) BufferUsage {
        return wgpuBufferGetUsage(buffer);
    }
    pub fn mapAsync(buffer: Buffer, mode: MapMode, offset: usize, size: usize, callback_info: BufferMapCallbackInfo) Future {
        return wgpuBufferMapAsync(buffer, mode, offset, size, callback_info);
    }
    pub fn readMappedRange(buffer: Buffer, offset: usize, data: ?*anyopaque, size: usize) Status {
        return wgpuBufferReadMappedRange(buffer, offset, data, size);
    }
    pub fn setLabel(buffer: Buffer, label: StringView) void {
        return wgpuBufferSetLabel(buffer, label);
    }
    pub fn unmap(buffer: Buffer) void {
        return wgpuBufferUnmap(buffer);
    }
    pub fn writeMappedRange(buffer: Buffer, offset: usize, data: ?*const anyopaque, size: usize) Status {
        return wgpuBufferWriteMappedRange(buffer, offset, data, size);
    }
    pub fn addRef(buffer: Buffer) void {
        return wgpuBufferAddRef(buffer);
    }
    pub fn release(buffer: Buffer) void {
        return wgpuBufferRelease(buffer);
    }
};

pub const CommandBuffer = *opaque {
    pub fn setLabel(command_buffer: CommandBuffer, label: StringView) void {
        return wgpuCommandBufferSetLabel(command_buffer, label);
    }
    pub fn addRef(command_buffer: CommandBuffer) void {
        return wgpuCommandBufferAddRef(command_buffer);
    }
    pub fn release(command_buffer: CommandBuffer) void {
        return wgpuCommandBufferRelease(command_buffer);
    }
};

pub const CommandEncoder = *opaque {
    pub fn beginComputePass(command_encoder: CommandEncoder, descriptor: ?*const ComputePassDescriptor) ComputePassEncoder {
        return wgpuCommandEncoderBeginComputePass(command_encoder, descriptor);
    }
    pub fn beginRenderPass(command_encoder: CommandEncoder, descriptor: *const RenderPassDescriptor) RenderPassEncoder {
        return wgpuCommandEncoderBeginRenderPass(command_encoder, descriptor);
    }
    pub fn clearBuffer(command_encoder: CommandEncoder, buffer: Buffer, offset: u64, size: u64) void {
        return wgpuCommandEncoderClearBuffer(command_encoder, buffer, offset, size);
    }
    pub fn copyBufferToBuffer(command_encoder: CommandEncoder, source: Buffer, source_offset: u64, destination: Buffer, destination_offset: u64, size: u64) void {
        return wgpuCommandEncoderCopyBufferToBuffer(command_encoder, source, source_offset, destination, destination_offset, size);
    }
    pub fn copyBufferToTexture(command_encoder: CommandEncoder, source: *const TexelCopyBufferInfo, destination: *const TexelCopyTextureInfo, copy_size: *const Extent3D) void {
        return wgpuCommandEncoderCopyBufferToTexture(command_encoder, source, destination, copy_size);
    }
    pub fn copyTextureToBuffer(command_encoder: CommandEncoder, source: *const TexelCopyTextureInfo, destination: *const TexelCopyBufferInfo, copy_size: *const Extent3D) void {
        return wgpuCommandEncoderCopyTextureToBuffer(command_encoder, source, destination, copy_size);
    }
    pub fn copyTextureToTexture(command_encoder: CommandEncoder, source: *const TexelCopyTextureInfo, destination: *const TexelCopyTextureInfo, copy_size: *const Extent3D) void {
        return wgpuCommandEncoderCopyTextureToTexture(command_encoder, source, destination, copy_size);
    }
    pub fn finish(command_encoder: CommandEncoder, descriptor: ?*const CommandBufferDescriptor) CommandBuffer {
        return wgpuCommandEncoderFinish(command_encoder, descriptor);
    }
    pub fn injectValidationError(command_encoder: CommandEncoder, message: StringView) void {
        return wgpuCommandEncoderInjectValidationError(command_encoder, message);
    }
    pub fn insertDebugMarker(command_encoder: CommandEncoder, marker_label: StringView) void {
        return wgpuCommandEncoderInsertDebugMarker(command_encoder, marker_label);
    }
    pub fn popDebugGroup(command_encoder: CommandEncoder) void {
        return wgpuCommandEncoderPopDebugGroup(command_encoder);
    }
    pub fn pushDebugGroup(command_encoder: CommandEncoder, group_label: StringView) void {
        return wgpuCommandEncoderPushDebugGroup(command_encoder, group_label);
    }
    pub fn resolveQuerySet(command_encoder: CommandEncoder, query_set: QuerySet, first_query: u32, query_count: u32, destination: Buffer, destination_offset: u64) void {
        return wgpuCommandEncoderResolveQuerySet(command_encoder, query_set, first_query, query_count, destination, destination_offset);
    }
    pub fn setLabel(command_encoder: CommandEncoder, label: StringView) void {
        return wgpuCommandEncoderSetLabel(command_encoder, label);
    }
    pub fn writeBuffer(command_encoder: CommandEncoder, buffer: Buffer, buffer_offset: u64, data: *const u8, size: u64) void {
        return wgpuCommandEncoderWriteBuffer(command_encoder, buffer, buffer_offset, data, size);
    }
    pub fn writeTimestamp(command_encoder: CommandEncoder, query_set: QuerySet, query_index: u32) void {
        return wgpuCommandEncoderWriteTimestamp(command_encoder, query_set, query_index);
    }
    pub fn addRef(command_encoder: CommandEncoder) void {
        return wgpuCommandEncoderAddRef(command_encoder);
    }
    pub fn release(command_encoder: CommandEncoder) void {
        return wgpuCommandEncoderRelease(command_encoder);
    }
};

pub const ComputePassEncoder = *opaque {
    pub fn dispatchWorkgroups(compute_pass_encoder: ComputePassEncoder, workgroup_count_x: u32, workgroup_count_y: u32, workgroup_count_z: u32) void {
        return wgpuComputePassEncoderDispatchWorkgroups(compute_pass_encoder, workgroup_count_x, workgroup_count_y, workgroup_count_z);
    }
    pub fn dispatchWorkgroupsIndirect(compute_pass_encoder: ComputePassEncoder, indirect_buffer: Buffer, indirect_offset: u64) void {
        return wgpuComputePassEncoderDispatchWorkgroupsIndirect(compute_pass_encoder, indirect_buffer, indirect_offset);
    }
    pub fn end(compute_pass_encoder: ComputePassEncoder) void {
        return wgpuComputePassEncoderEnd(compute_pass_encoder);
    }
    pub fn insertDebugMarker(compute_pass_encoder: ComputePassEncoder, marker_label: StringView) void {
        return wgpuComputePassEncoderInsertDebugMarker(compute_pass_encoder, marker_label);
    }
    pub fn popDebugGroup(compute_pass_encoder: ComputePassEncoder) void {
        return wgpuComputePassEncoderPopDebugGroup(compute_pass_encoder);
    }
    pub fn pushDebugGroup(compute_pass_encoder: ComputePassEncoder, group_label: StringView) void {
        return wgpuComputePassEncoderPushDebugGroup(compute_pass_encoder, group_label);
    }
    pub fn setBindGroup(compute_pass_encoder: ComputePassEncoder, group_index: u32, group: ?BindGroup, dynamic_offsets: []const u32) void {
        return wgpuComputePassEncoderSetBindGroup(compute_pass_encoder, group_index, group, dynamic_offsets.len, dynamic_offsets.ptr);
    }
    pub fn setImmediates(compute_pass_encoder: ComputePassEncoder, offset: u32, data: ?*const anyopaque, size: usize) void {
        return wgpuComputePassEncoderSetImmediates(compute_pass_encoder, offset, data, size);
    }
    pub fn setLabel(compute_pass_encoder: ComputePassEncoder, label: StringView) void {
        return wgpuComputePassEncoderSetLabel(compute_pass_encoder, label);
    }
    pub fn setPipeline(compute_pass_encoder: ComputePassEncoder, pipeline: ComputePipeline) void {
        return wgpuComputePassEncoderSetPipeline(compute_pass_encoder, pipeline);
    }
    pub fn setResourceTable(compute_pass_encoder: ComputePassEncoder, table: ?ResourceTable) void {
        return wgpuComputePassEncoderSetResourceTable(compute_pass_encoder, table);
    }
    pub fn writeTimestamp(compute_pass_encoder: ComputePassEncoder, query_set: QuerySet, query_index: u32) void {
        return wgpuComputePassEncoderWriteTimestamp(compute_pass_encoder, query_set, query_index);
    }
    pub fn addRef(compute_pass_encoder: ComputePassEncoder) void {
        return wgpuComputePassEncoderAddRef(compute_pass_encoder);
    }
    pub fn release(compute_pass_encoder: ComputePassEncoder) void {
        return wgpuComputePassEncoderRelease(compute_pass_encoder);
    }
};

pub const ComputePipeline = *opaque {
    pub fn getBindGroupLayout(compute_pipeline: ComputePipeline, group_index: u32) BindGroupLayout {
        return wgpuComputePipelineGetBindGroupLayout(compute_pipeline, group_index);
    }
    pub fn setLabel(compute_pipeline: ComputePipeline, label: StringView) void {
        return wgpuComputePipelineSetLabel(compute_pipeline, label);
    }
    pub fn addRef(compute_pipeline: ComputePipeline) void {
        return wgpuComputePipelineAddRef(compute_pipeline);
    }
    pub fn release(compute_pipeline: ComputePipeline) void {
        return wgpuComputePipelineRelease(compute_pipeline);
    }
};

pub const Device = *opaque {
    pub fn createBindGroup(device: Device, descriptor: *const BindGroupDescriptor) BindGroup {
        return wgpuDeviceCreateBindGroup(device, descriptor);
    }
    pub fn createBindGroupLayout(device: Device, descriptor: *const BindGroupLayoutDescriptor) BindGroupLayout {
        return wgpuDeviceCreateBindGroupLayout(device, descriptor);
    }
    pub fn createBuffer(device: Device, descriptor: *const BufferDescriptor) ?Buffer {
        return wgpuDeviceCreateBuffer(device, descriptor);
    }
    pub fn createCommandEncoder(device: Device, descriptor: ?*const CommandEncoderDescriptor) CommandEncoder {
        return wgpuDeviceCreateCommandEncoder(device, descriptor);
    }
    pub fn createComputePipeline(device: Device, descriptor: *const ComputePipelineDescriptor) ComputePipeline {
        return wgpuDeviceCreateComputePipeline(device, descriptor);
    }
    pub fn createComputePipelineAsync(device: Device, descriptor: *const ComputePipelineDescriptor, callback_info: CreateComputePipelineAsyncCallbackInfo) Future {
        return wgpuDeviceCreateComputePipelineAsync(device, descriptor, callback_info);
    }
    pub fn createErrorBuffer(device: Device, descriptor: *const BufferDescriptor) Buffer {
        return wgpuDeviceCreateErrorBuffer(device, descriptor);
    }
    pub fn createErrorExternalTexture(device: Device) ExternalTexture {
        return wgpuDeviceCreateErrorExternalTexture(device);
    }
    pub fn createErrorShaderModule(device: Device, descriptor: *const ShaderModuleDescriptor, error_message: StringView) ShaderModule {
        return wgpuDeviceCreateErrorShaderModule(device, descriptor, error_message);
    }
    pub fn createErrorTexture(device: Device, descriptor: *const TextureDescriptor) Texture {
        return wgpuDeviceCreateErrorTexture(device, descriptor);
    }
    pub fn createExternalTexture(device: Device, external_texture_descriptor: *const ExternalTextureDescriptor) ExternalTexture {
        return wgpuDeviceCreateExternalTexture(device, external_texture_descriptor);
    }
    pub fn createPipelineLayout(device: Device, descriptor: *const PipelineLayoutDescriptor) PipelineLayout {
        return wgpuDeviceCreatePipelineLayout(device, descriptor);
    }
    pub fn createQuerySet(device: Device, descriptor: *const QuerySetDescriptor) QuerySet {
        return wgpuDeviceCreateQuerySet(device, descriptor);
    }
    pub fn createRenderBundleEncoder(device: Device, descriptor: *const RenderBundleEncoderDescriptor) RenderBundleEncoder {
        return wgpuDeviceCreateRenderBundleEncoder(device, descriptor);
    }
    pub fn createRenderPipeline(device: Device, descriptor: *const RenderPipelineDescriptor) RenderPipeline {
        return wgpuDeviceCreateRenderPipeline(device, descriptor);
    }
    pub fn createRenderPipelineAsync(device: Device, descriptor: *const RenderPipelineDescriptor, callback_info: CreateRenderPipelineAsyncCallbackInfo) Future {
        return wgpuDeviceCreateRenderPipelineAsync(device, descriptor, callback_info);
    }
    pub fn createResourceTable(device: Device, descriptor: *const ResourceTableDescriptor) ResourceTable {
        return wgpuDeviceCreateResourceTable(device, descriptor);
    }
    pub fn createSampler(device: Device, descriptor: ?*const SamplerDescriptor) Sampler {
        return wgpuDeviceCreateSampler(device, descriptor);
    }
    pub fn createShaderModule(device: Device, descriptor: *const ShaderModuleDescriptor) ShaderModule {
        return wgpuDeviceCreateShaderModule(device, descriptor);
    }
    pub fn createTexture(device: Device, descriptor: *const TextureDescriptor) Texture {
        return wgpuDeviceCreateTexture(device, descriptor);
    }
    pub fn destroy(device: Device) void {
        return wgpuDeviceDestroy(device);
    }
    pub fn forceLoss(device: Device, reason: DeviceLostReason, message: StringView) void {
        return wgpuDeviceForceLoss(device, reason, message);
    }
    pub fn getAdapter(device: Device) Adapter {
        return wgpuDeviceGetAdapter(device);
    }
    pub fn getAdapterInfo(device: Device, adapter_info: *AdapterInfo) Status {
        return wgpuDeviceGetAdapterInfo(device, adapter_info);
    }
    pub fn getAHardwareBufferProperties(device: Device, handle: ?*anyopaque, properties: *AHardwareBufferProperties) Status {
        return wgpuDeviceGetAHardwareBufferProperties(device, handle, properties);
    }
    pub fn getFeatures(device: Device, features: *SupportedFeatures) void {
        return wgpuDeviceGetFeatures(device, features);
    }
    pub fn getLimits(device: Device, limits: *Limits) Status {
        return wgpuDeviceGetLimits(device, limits);
    }
    pub fn getLostFuture(device: Device) Future {
        return wgpuDeviceGetLostFuture(device);
    }
    pub fn getQueue(device: Device) Queue {
        return wgpuDeviceGetQueue(device);
    }
    pub fn hasFeature(device: Device, feature: FeatureName) Bool {
        return wgpuDeviceHasFeature(device, feature);
    }
    pub fn importSharedBufferMemory(device: Device, descriptor: *const SharedBufferMemoryDescriptor) SharedBufferMemory {
        return wgpuDeviceImportSharedBufferMemory(device, descriptor);
    }
    pub fn importSharedFence(device: Device, descriptor: *const SharedFenceDescriptor) SharedFence {
        return wgpuDeviceImportSharedFence(device, descriptor);
    }
    pub fn importSharedTextureMemory(device: Device, descriptor: *const SharedTextureMemoryDescriptor) SharedTextureMemory {
        return wgpuDeviceImportSharedTextureMemory(device, descriptor);
    }
    pub fn injectError(device: Device, error_type: ErrorType, message: StringView) void {
        return wgpuDeviceInjectError(device, error_type, message);
    }
    pub fn popErrorScope(device: Device, callback_info: PopErrorScopeCallbackInfo) Future {
        return wgpuDevicePopErrorScope(device, callback_info);
    }
    pub fn pushErrorScope(device: Device, filter: ErrorFilter) void {
        return wgpuDevicePushErrorScope(device, filter);
    }
    pub fn setLabel(device: Device, label: StringView) void {
        return wgpuDeviceSetLabel(device, label);
    }
    pub fn setLoggingCallback(device: Device, callback_info: LoggingCallbackInfo) void {
        return wgpuDeviceSetLoggingCallback(device, callback_info);
    }
    pub fn tick(device: Device) void {
        return wgpuDeviceTick(device);
    }
    pub fn validateTextureDescriptor(device: Device, descriptor: *const TextureDescriptor) void {
        return wgpuDeviceValidateTextureDescriptor(device, descriptor);
    }
    pub fn addRef(device: Device) void {
        return wgpuDeviceAddRef(device);
    }
    pub fn release(device: Device) void {
        return wgpuDeviceRelease(device);
    }
};

pub const ExternalTexture = *opaque {
    pub fn destroy(external_texture: ExternalTexture) void {
        return wgpuExternalTextureDestroy(external_texture);
    }
    pub fn expire(external_texture: ExternalTexture) void {
        return wgpuExternalTextureExpire(external_texture);
    }
    pub fn refresh(external_texture: ExternalTexture) void {
        return wgpuExternalTextureRefresh(external_texture);
    }
    pub fn setLabel(external_texture: ExternalTexture, label: StringView) void {
        return wgpuExternalTextureSetLabel(external_texture, label);
    }
    pub fn addRef(external_texture: ExternalTexture) void {
        return wgpuExternalTextureAddRef(external_texture);
    }
    pub fn release(external_texture: ExternalTexture) void {
        return wgpuExternalTextureRelease(external_texture);
    }
};

pub const Instance = *opaque {
    pub fn create(descriptor: ?*const InstanceDescriptor) Instance {
        return wgpuCreateInstance(descriptor);
    }
    pub fn createSurface(instance: Instance, descriptor: *const SurfaceDescriptor) Surface {
        return wgpuInstanceCreateSurface(instance, descriptor);
    }
    pub fn getWGSLLanguageFeatures(instance: Instance, features: *SupportedWGSLLanguageFeatures) void {
        return wgpuInstanceGetWGSLLanguageFeatures(instance, features);
    }
    pub fn hasWGSLLanguageFeature(instance: Instance, feature: WGSLLanguageFeatureName) Bool {
        return wgpuInstanceHasWGSLLanguageFeature(instance, feature);
    }
    pub fn processEvents(instance: Instance) void {
        return wgpuInstanceProcessEvents(instance);
    }
    pub fn requestAdapter(instance: Instance, options: ?*const RequestAdapterOptions, callback_info: RequestAdapterCallbackInfo) Future {
        return wgpuInstanceRequestAdapter(instance, options, callback_info);
    }
    pub fn waitAny(instance: Instance, futures: []FutureWaitInfo, timeout_ns: u64) WaitStatus {
        return wgpuInstanceWaitAny(instance, futures.len, futures.ptr, timeout_ns);
    }
    pub fn addRef(instance: Instance) void {
        return wgpuInstanceAddRef(instance);
    }
    pub fn release(instance: Instance) void {
        return wgpuInstanceRelease(instance);
    }
};

pub const PipelineLayout = *opaque {
    pub fn setLabel(pipeline_layout: PipelineLayout, label: StringView) void {
        return wgpuPipelineLayoutSetLabel(pipeline_layout, label);
    }
    pub fn addRef(pipeline_layout: PipelineLayout) void {
        return wgpuPipelineLayoutAddRef(pipeline_layout);
    }
    pub fn release(pipeline_layout: PipelineLayout) void {
        return wgpuPipelineLayoutRelease(pipeline_layout);
    }
};

pub const QuerySet = *opaque {
    pub fn destroy(query_set: QuerySet) void {
        return wgpuQuerySetDestroy(query_set);
    }
    pub fn getCount(query_set: QuerySet) u32 {
        return wgpuQuerySetGetCount(query_set);
    }
    pub fn getType(query_set: QuerySet) QueryType {
        return wgpuQuerySetGetType(query_set);
    }
    pub fn setLabel(query_set: QuerySet, label: StringView) void {
        return wgpuQuerySetSetLabel(query_set, label);
    }
    pub fn addRef(query_set: QuerySet) void {
        return wgpuQuerySetAddRef(query_set);
    }
    pub fn release(query_set: QuerySet) void {
        return wgpuQuerySetRelease(query_set);
    }
};

pub const Queue = *opaque {
    pub fn copyExternalTextureForBrowser(queue: Queue, source: *const ImageCopyExternalTexture, destination: *const TexelCopyTextureInfo, copy_size: *const Extent3D, options: *const CopyTextureForBrowserOptions) void {
        return wgpuQueueCopyExternalTextureForBrowser(queue, source, destination, copy_size, options);
    }
    pub fn copyTextureForBrowser(queue: Queue, source: *const TexelCopyTextureInfo, destination: *const TexelCopyTextureInfo, copy_size: *const Extent3D, options: *const CopyTextureForBrowserOptions) void {
        return wgpuQueueCopyTextureForBrowser(queue, source, destination, copy_size, options);
    }
    pub fn onSubmittedWorkDone(queue: Queue, callback_info: QueueWorkDoneCallbackInfo) Future {
        return wgpuQueueOnSubmittedWorkDone(queue, callback_info);
    }
    pub fn setLabel(queue: Queue, label: StringView) void {
        return wgpuQueueSetLabel(queue, label);
    }
    pub fn submit(queue: Queue, commands: []const CommandBuffer) void {
        return wgpuQueueSubmit(queue, commands.len, commands.ptr);
    }
    pub fn writeBuffer(queue: Queue, buffer: Buffer, buffer_offset: u64, data: ?*const anyopaque, size: usize) void {
        return wgpuQueueWriteBuffer(queue, buffer, buffer_offset, data, size);
    }
    pub fn writeTexture(queue: Queue, destination: *const TexelCopyTextureInfo, data: ?*const anyopaque, data_size: usize, data_layout: *const TexelCopyBufferLayout, write_size: *const Extent3D) void {
        return wgpuQueueWriteTexture(queue, destination, data, data_size, data_layout, write_size);
    }
    pub fn addRef(queue: Queue) void {
        return wgpuQueueAddRef(queue);
    }
    pub fn release(queue: Queue) void {
        return wgpuQueueRelease(queue);
    }
};

pub const RenderBundle = *opaque {
    pub fn setLabel(render_bundle: RenderBundle, label: StringView) void {
        return wgpuRenderBundleSetLabel(render_bundle, label);
    }
    pub fn addRef(render_bundle: RenderBundle) void {
        return wgpuRenderBundleAddRef(render_bundle);
    }
    pub fn release(render_bundle: RenderBundle) void {
        return wgpuRenderBundleRelease(render_bundle);
    }
};

pub const RenderBundleEncoder = *opaque {
    pub fn draw(render_bundle_encoder: RenderBundleEncoder, vertex_count: u32, instance_count: u32, first_vertex: u32, first_instance: u32) void {
        return wgpuRenderBundleEncoderDraw(render_bundle_encoder, vertex_count, instance_count, first_vertex, first_instance);
    }
    pub fn drawIndexed(render_bundle_encoder: RenderBundleEncoder, index_count: u32, instance_count: u32, first_index: u32, base_vertex: i32, first_instance: u32) void {
        return wgpuRenderBundleEncoderDrawIndexed(render_bundle_encoder, index_count, instance_count, first_index, base_vertex, first_instance);
    }
    pub fn drawIndexedIndirect(render_bundle_encoder: RenderBundleEncoder, indirect_buffer: Buffer, indirect_offset: u64) void {
        return wgpuRenderBundleEncoderDrawIndexedIndirect(render_bundle_encoder, indirect_buffer, indirect_offset);
    }
    pub fn drawIndirect(render_bundle_encoder: RenderBundleEncoder, indirect_buffer: Buffer, indirect_offset: u64) void {
        return wgpuRenderBundleEncoderDrawIndirect(render_bundle_encoder, indirect_buffer, indirect_offset);
    }
    pub fn finish(render_bundle_encoder: RenderBundleEncoder, descriptor: ?*const RenderBundleDescriptor) RenderBundle {
        return wgpuRenderBundleEncoderFinish(render_bundle_encoder, descriptor);
    }
    pub fn insertDebugMarker(render_bundle_encoder: RenderBundleEncoder, marker_label: StringView) void {
        return wgpuRenderBundleEncoderInsertDebugMarker(render_bundle_encoder, marker_label);
    }
    pub fn popDebugGroup(render_bundle_encoder: RenderBundleEncoder) void {
        return wgpuRenderBundleEncoderPopDebugGroup(render_bundle_encoder);
    }
    pub fn pushDebugGroup(render_bundle_encoder: RenderBundleEncoder, group_label: StringView) void {
        return wgpuRenderBundleEncoderPushDebugGroup(render_bundle_encoder, group_label);
    }
    pub fn setBindGroup(render_bundle_encoder: RenderBundleEncoder, group_index: u32, group: ?BindGroup, dynamic_offsets: ?[]const u32) void {
        return wgpuRenderBundleEncoderSetBindGroup(render_bundle_encoder, group_index, group, dynamic_offsets.len, dynamic_offsets.ptr);
    }
    pub fn setImmediates(render_bundle_encoder: RenderBundleEncoder, offset: u32, data: ?*const anyopaque, size: usize) void {
        return wgpuRenderBundleEncoderSetImmediates(render_bundle_encoder, offset, data, size);
    }
    pub fn setIndexBuffer(render_bundle_encoder: RenderBundleEncoder, buffer: Buffer, format: IndexFormat, offset: u64, size: u64) void {
        return wgpuRenderBundleEncoderSetIndexBuffer(render_bundle_encoder, buffer, format, offset, size);
    }
    pub fn setLabel(render_bundle_encoder: RenderBundleEncoder, label: StringView) void {
        return wgpuRenderBundleEncoderSetLabel(render_bundle_encoder, label);
    }
    pub fn setPipeline(render_bundle_encoder: RenderBundleEncoder, pipeline: RenderPipeline) void {
        return wgpuRenderBundleEncoderSetPipeline(render_bundle_encoder, pipeline);
    }
    pub fn setResourceTable(render_bundle_encoder: RenderBundleEncoder, table: ?ResourceTable) void {
        return wgpuRenderBundleEncoderSetResourceTable(render_bundle_encoder, table);
    }
    pub fn setVertexBuffer(render_bundle_encoder: RenderBundleEncoder, slot: u32, buffer: ?Buffer, offset: u64, size: u64) void {
        return wgpuRenderBundleEncoderSetVertexBuffer(render_bundle_encoder, slot, buffer, offset, size);
    }
    pub fn addRef(render_bundle_encoder: RenderBundleEncoder) void {
        return wgpuRenderBundleEncoderAddRef(render_bundle_encoder);
    }
    pub fn release(render_bundle_encoder: RenderBundleEncoder) void {
        return wgpuRenderBundleEncoderRelease(render_bundle_encoder);
    }
};

pub const RenderPassEncoder = *opaque {
    pub fn beginOcclusionQuery(render_pass_encoder: RenderPassEncoder, query_index: u32) void {
        return wgpuRenderPassEncoderBeginOcclusionQuery(render_pass_encoder, query_index);
    }
    pub fn draw(render_pass_encoder: RenderPassEncoder, vertex_count: u32, instance_count: u32, first_vertex: u32, first_instance: u32) void {
        return wgpuRenderPassEncoderDraw(render_pass_encoder, vertex_count, instance_count, first_vertex, first_instance);
    }
    pub fn drawIndexed(render_pass_encoder: RenderPassEncoder, index_count: u32, instance_count: u32, first_index: u32, base_vertex: i32, first_instance: u32) void {
        return wgpuRenderPassEncoderDrawIndexed(render_pass_encoder, index_count, instance_count, first_index, base_vertex, first_instance);
    }
    pub fn drawIndexedIndirect(render_pass_encoder: RenderPassEncoder, indirect_buffer: Buffer, indirect_offset: u64) void {
        return wgpuRenderPassEncoderDrawIndexedIndirect(render_pass_encoder, indirect_buffer, indirect_offset);
    }
    pub fn drawIndirect(render_pass_encoder: RenderPassEncoder, indirect_buffer: Buffer, indirect_offset: u64) void {
        return wgpuRenderPassEncoderDrawIndirect(render_pass_encoder, indirect_buffer, indirect_offset);
    }
    pub fn end(render_pass_encoder: RenderPassEncoder) void {
        return wgpuRenderPassEncoderEnd(render_pass_encoder);
    }
    pub fn endOcclusionQuery(render_pass_encoder: RenderPassEncoder) void {
        return wgpuRenderPassEncoderEndOcclusionQuery(render_pass_encoder);
    }
    pub fn executeBundles(render_pass_encoder: RenderPassEncoder, bundles: ?[]const RenderBundle) void {
        return wgpuRenderPassEncoderExecuteBundles(render_pass_encoder, bundles.len, bundles.ptr);
    }
    pub fn insertDebugMarker(render_pass_encoder: RenderPassEncoder, marker_label: StringView) void {
        return wgpuRenderPassEncoderInsertDebugMarker(render_pass_encoder, marker_label);
    }
    pub fn multiDrawIndexedIndirect(render_pass_encoder: RenderPassEncoder, indirect_buffer: Buffer, indirect_offset: u64, max_draw_count: u32, draw_count_buffer: ?Buffer, draw_count_buffer_offset: u64) void {
        return wgpuRenderPassEncoderMultiDrawIndexedIndirect(render_pass_encoder, indirect_buffer, indirect_offset, max_draw_count, draw_count_buffer, draw_count_buffer_offset);
    }
    pub fn multiDrawIndirect(render_pass_encoder: RenderPassEncoder, indirect_buffer: Buffer, indirect_offset: u64, max_draw_count: u32, draw_count_buffer: ?Buffer, draw_count_buffer_offset: u64) void {
        return wgpuRenderPassEncoderMultiDrawIndirect(render_pass_encoder, indirect_buffer, indirect_offset, max_draw_count, draw_count_buffer, draw_count_buffer_offset);
    }
    pub fn pixelLocalStorageBarrier(render_pass_encoder: RenderPassEncoder) void {
        return wgpuRenderPassEncoderPixelLocalStorageBarrier(render_pass_encoder);
    }
    pub fn popDebugGroup(render_pass_encoder: RenderPassEncoder) void {
        return wgpuRenderPassEncoderPopDebugGroup(render_pass_encoder);
    }
    pub fn pushDebugGroup(render_pass_encoder: RenderPassEncoder, group_label: StringView) void {
        return wgpuRenderPassEncoderPushDebugGroup(render_pass_encoder, group_label);
    }
    pub fn setBindGroup(render_pass_encoder: RenderPassEncoder, group_index: u32, group: ?BindGroup, dynamic_offsets: ?[]const u32) void {
        return wgpuRenderPassEncoderSetBindGroup(render_pass_encoder, group_index, group, dynamic_offsets.len, dynamic_offsets.ptr);
    }
    pub fn setBlendConstant(render_pass_encoder: RenderPassEncoder, color: *const Color) void {
        return wgpuRenderPassEncoderSetBlendConstant(render_pass_encoder, color);
    }
    pub fn setImmediates(render_pass_encoder: RenderPassEncoder, offset: u32, data: ?*const anyopaque, size: usize) void {
        return wgpuRenderPassEncoderSetImmediates(render_pass_encoder, offset, data, size);
    }
    pub fn setIndexBuffer(render_pass_encoder: RenderPassEncoder, buffer: Buffer, format: IndexFormat, offset: u64, size: u64) void {
        return wgpuRenderPassEncoderSetIndexBuffer(render_pass_encoder, buffer, format, offset, size);
    }
    pub fn setLabel(render_pass_encoder: RenderPassEncoder, label: StringView) void {
        return wgpuRenderPassEncoderSetLabel(render_pass_encoder, label);
    }
    pub fn setPipeline(render_pass_encoder: RenderPassEncoder, pipeline: RenderPipeline) void {
        return wgpuRenderPassEncoderSetPipeline(render_pass_encoder, pipeline);
    }
    pub fn setResourceTable(render_pass_encoder: RenderPassEncoder, table: ?ResourceTable) void {
        return wgpuRenderPassEncoderSetResourceTable(render_pass_encoder, table);
    }
    pub fn setScissorRect(render_pass_encoder: RenderPassEncoder, x: u32, y: u32, width: u32, height: u32) void {
        return wgpuRenderPassEncoderSetScissorRect(render_pass_encoder, x, y, width, height);
    }
    pub fn setStencilReference(render_pass_encoder: RenderPassEncoder, reference: u32) void {
        return wgpuRenderPassEncoderSetStencilReference(render_pass_encoder, reference);
    }
    pub fn setVertexBuffer(render_pass_encoder: RenderPassEncoder, slot: u32, buffer: ?Buffer, offset: u64, size: u64) void {
        return wgpuRenderPassEncoderSetVertexBuffer(render_pass_encoder, slot, buffer, offset, size);
    }
    pub fn setViewport(render_pass_encoder: RenderPassEncoder, x: f32, y: f32, width: f32, height: f32, min_depth: f32, max_depth: f32) void {
        return wgpuRenderPassEncoderSetViewport(render_pass_encoder, x, y, width, height, min_depth, max_depth);
    }
    pub fn writeTimestamp(render_pass_encoder: RenderPassEncoder, query_set: QuerySet, query_index: u32) void {
        return wgpuRenderPassEncoderWriteTimestamp(render_pass_encoder, query_set, query_index);
    }
    pub fn addRef(render_pass_encoder: RenderPassEncoder) void {
        return wgpuRenderPassEncoderAddRef(render_pass_encoder);
    }
    pub fn release(render_pass_encoder: RenderPassEncoder) void {
        return wgpuRenderPassEncoderRelease(render_pass_encoder);
    }
};

pub const RenderPipeline = *opaque {
    pub fn getBindGroupLayout(render_pipeline: RenderPipeline, group_index: u32) BindGroupLayout {
        return wgpuRenderPipelineGetBindGroupLayout(render_pipeline, group_index);
    }
    pub fn setLabel(render_pipeline: RenderPipeline, label: StringView) void {
        return wgpuRenderPipelineSetLabel(render_pipeline, label);
    }
    pub fn addRef(render_pipeline: RenderPipeline) void {
        return wgpuRenderPipelineAddRef(render_pipeline);
    }
    pub fn release(render_pipeline: RenderPipeline) void {
        return wgpuRenderPipelineRelease(render_pipeline);
    }
};

pub const ResourceTable = *opaque {
    pub fn destroy(resource_table: ResourceTable) void {
        return wgpuResourceTableDestroy(resource_table);
    }
    pub fn getSize(resource_table: ResourceTable) u32 {
        return wgpuResourceTableGetSize(resource_table);
    }
    pub fn insertBinding(resource_table: ResourceTable, resource: *const BindingResource) u32 {
        return wgpuResourceTableInsertBinding(resource_table, resource);
    }
    pub fn removeBinding(resource_table: ResourceTable, slot: u32) Status {
        return wgpuResourceTableRemoveBinding(resource_table, slot);
    }
    pub fn update(resource_table: ResourceTable, slot: u32, resource: *const BindingResource) Status {
        return wgpuResourceTableUpdate(resource_table, slot, resource);
    }
    pub fn addRef(resource_table: ResourceTable) void {
        return wgpuResourceTableAddRef(resource_table);
    }
    pub fn release(resource_table: ResourceTable) void {
        return wgpuResourceTableRelease(resource_table);
    }
};

pub const Sampler = *opaque {
    pub fn setLabel(sampler: Sampler, label: StringView) void {
        return wgpuSamplerSetLabel(sampler, label);
    }
    pub fn addRef(sampler: Sampler) void {
        return wgpuSamplerAddRef(sampler);
    }
    pub fn release(sampler: Sampler) void {
        return wgpuSamplerRelease(sampler);
    }
};

pub const ShaderModule = *opaque {
    pub fn getCompilationInfo(shader_module: ShaderModule, callback_info: CompilationInfoCallbackInfo) Future {
        return wgpuShaderModuleGetCompilationInfo(shader_module, callback_info);
    }
    pub fn setLabel(shader_module: ShaderModule, label: StringView) void {
        return wgpuShaderModuleSetLabel(shader_module, label);
    }
    pub fn addRef(shader_module: ShaderModule) void {
        return wgpuShaderModuleAddRef(shader_module);
    }
    pub fn release(shader_module: ShaderModule) void {
        return wgpuShaderModuleRelease(shader_module);
    }
};

pub const SharedBufferMemory = *opaque {
    pub fn beginAccess(shared_buffer_memory: SharedBufferMemory, buffer: Buffer, descriptor: *const SharedBufferMemoryBeginAccessDescriptor) Status {
        return wgpuSharedBufferMemoryBeginAccess(shared_buffer_memory, buffer, descriptor);
    }
    pub fn createBuffer(shared_buffer_memory: SharedBufferMemory, descriptor: ?*const BufferDescriptor) Buffer {
        return wgpuSharedBufferMemoryCreateBuffer(shared_buffer_memory, descriptor);
    }
    pub fn endAccess(shared_buffer_memory: SharedBufferMemory, buffer: Buffer, descriptor: *SharedBufferMemoryEndAccessState) Status {
        return wgpuSharedBufferMemoryEndAccess(shared_buffer_memory, buffer, descriptor);
    }
    pub fn getProperties(shared_buffer_memory: SharedBufferMemory, properties: *SharedBufferMemoryProperties) Status {
        return wgpuSharedBufferMemoryGetProperties(shared_buffer_memory, properties);
    }
    pub fn isDeviceLost(shared_buffer_memory: SharedBufferMemory) Bool {
        return wgpuSharedBufferMemoryIsDeviceLost(shared_buffer_memory);
    }
    pub fn setLabel(shared_buffer_memory: SharedBufferMemory, label: StringView) void {
        return wgpuSharedBufferMemorySetLabel(shared_buffer_memory, label);
    }
    pub fn addRef(shared_buffer_memory: SharedBufferMemory) void {
        return wgpuSharedBufferMemoryAddRef(shared_buffer_memory);
    }
    pub fn release(shared_buffer_memory: SharedBufferMemory) void {
        return wgpuSharedBufferMemoryRelease(shared_buffer_memory);
    }
};

pub const SharedFence = *opaque {
    pub fn exportInfo(shared_fence: SharedFence, info: *SharedFenceExportInfo) void {
        return wgpuSharedFenceExportInfo(shared_fence, info);
    }
    pub fn setLabel(shared_fence: SharedFence, label: StringView) void {
        return wgpuSharedFenceSetLabel(shared_fence, label);
    }
    pub fn addRef(shared_fence: SharedFence) void {
        return wgpuSharedFenceAddRef(shared_fence);
    }
    pub fn release(shared_fence: SharedFence) void {
        return wgpuSharedFenceRelease(shared_fence);
    }
};

pub const SharedTextureMemory = *opaque {
    pub fn beginAccess(shared_texture_memory: SharedTextureMemory, texture: Texture, descriptor: *const SharedTextureMemoryBeginAccessDescriptor) Status {
        return wgpuSharedTextureMemoryBeginAccess(shared_texture_memory, texture, descriptor);
    }
    pub fn createTexture(shared_texture_memory: SharedTextureMemory, descriptor: ?*const TextureDescriptor) Texture {
        return wgpuSharedTextureMemoryCreateTexture(shared_texture_memory, descriptor);
    }
    pub fn endAccess(shared_texture_memory: SharedTextureMemory, texture: Texture, descriptor: *SharedTextureMemoryEndAccessState) Status {
        return wgpuSharedTextureMemoryEndAccess(shared_texture_memory, texture, descriptor);
    }
    pub fn getProperties(shared_texture_memory: SharedTextureMemory, properties: *SharedTextureMemoryProperties) Status {
        return wgpuSharedTextureMemoryGetProperties(shared_texture_memory, properties);
    }
    pub fn isDeviceLost(shared_texture_memory: SharedTextureMemory) Bool {
        return wgpuSharedTextureMemoryIsDeviceLost(shared_texture_memory);
    }
    pub fn setLabel(shared_texture_memory: SharedTextureMemory, label: StringView) void {
        return wgpuSharedTextureMemorySetLabel(shared_texture_memory, label);
    }
    pub fn addRef(shared_texture_memory: SharedTextureMemory) void {
        return wgpuSharedTextureMemoryAddRef(shared_texture_memory);
    }
    pub fn release(shared_texture_memory: SharedTextureMemory) void {
        return wgpuSharedTextureMemoryRelease(shared_texture_memory);
    }
};

pub const Surface = *opaque {
    pub fn configure(surface: Surface, config: *const SurfaceConfiguration) void {
        return wgpuSurfaceConfigure(surface, config);
    }
    pub fn getCapabilities(surface: Surface, adapter: Adapter, capabilities: *SurfaceCapabilities) Status {
        return wgpuSurfaceGetCapabilities(surface, adapter, capabilities);
    }
    pub fn getCurrentTexture(surface: Surface, surface_texture: *SurfaceTexture) void {
        return wgpuSurfaceGetCurrentTexture(surface, surface_texture);
    }
    pub fn present(surface: Surface) Status {
        return wgpuSurfacePresent(surface);
    }
    pub fn setLabel(surface: Surface, label: StringView) void {
        return wgpuSurfaceSetLabel(surface, label);
    }
    pub fn unconfigure(surface: Surface) void {
        return wgpuSurfaceUnconfigure(surface);
    }
    pub fn addRef(surface: Surface) void {
        return wgpuSurfaceAddRef(surface);
    }
    pub fn release(surface: Surface) void {
        return wgpuSurfaceRelease(surface);
    }
};

pub const TexelBufferView = *opaque {
    pub fn setLabel(texel_buffer_view: TexelBufferView, label: StringView) void {
        return wgpuTexelBufferViewSetLabel(texel_buffer_view, label);
    }
    pub fn addRef(texel_buffer_view: TexelBufferView) void {
        return wgpuTexelBufferViewAddRef(texel_buffer_view);
    }
    pub fn release(texel_buffer_view: TexelBufferView) void {
        return wgpuTexelBufferViewRelease(texel_buffer_view);
    }
};

pub const Texture = *opaque {
    pub fn createErrorView(texture: Texture, descriptor: ?*const TextureViewDescriptor) TextureView {
        return wgpuTextureCreateErrorView(texture, descriptor);
    }
    pub fn createView(texture: Texture, descriptor: ?*const TextureViewDescriptor) TextureView {
        return wgpuTextureCreateView(texture, descriptor);
    }
    pub fn destroy(texture: Texture) void {
        return wgpuTextureDestroy(texture);
    }
    pub fn getDepthOrArrayLayers(texture: Texture) u32 {
        return wgpuTextureGetDepthOrArrayLayers(texture);
    }
    pub fn getDimension(texture: Texture) TextureDimension {
        return wgpuTextureGetDimension(texture);
    }
    pub fn getFormat(texture: Texture) TextureFormat {
        return wgpuTextureGetFormat(texture);
    }
    pub fn getHeight(texture: Texture) u32 {
        return wgpuTextureGetHeight(texture);
    }
    pub fn getMipLevelCount(texture: Texture) u32 {
        return wgpuTextureGetMipLevelCount(texture);
    }
    pub fn getSampleCount(texture: Texture) u32 {
        return wgpuTextureGetSampleCount(texture);
    }
    pub fn getTextureBindingViewDimension(texture: Texture) TextureViewDimension {
        return wgpuTextureGetTextureBindingViewDimension(texture);
    }
    pub fn getUsage(texture: Texture) TextureUsage {
        return wgpuTextureGetUsage(texture);
    }
    pub fn getWidth(texture: Texture) u32 {
        return wgpuTextureGetWidth(texture);
    }
    pub fn pin(texture: Texture, usage: TextureUsage) void {
        return wgpuTexturePin(texture, usage);
    }
    pub fn setLabel(texture: Texture, label: StringView) void {
        return wgpuTextureSetLabel(texture, label);
    }
    pub fn setOwnershipForMemoryDump(texture: Texture, owner_guid: u64) void {
        return wgpuTextureSetOwnershipForMemoryDump(texture, owner_guid);
    }
    pub fn unpin(texture: Texture) void {
        return wgpuTextureUnpin(texture);
    }
    pub fn addRef(texture: Texture) void {
        return wgpuTextureAddRef(texture);
    }
    pub fn release(texture: Texture) void {
        return wgpuTextureRelease(texture);
    }
};

pub const TextureView = *opaque {
    pub fn setLabel(texture_view: TextureView, label: StringView) void {
        return wgpuTextureViewSetLabel(texture_view, label);
    }
    pub fn addRef(texture_view: TextureView) void {
        return wgpuTextureViewAddRef(texture_view);
    }
    pub fn release(texture_view: TextureView) void {
        return wgpuTextureViewRelease(texture_view);
    }
};

//
// Enums
//

pub const AdapterType = enum(u32) {
    discrete_gpu = 0x00000001,
    integrated_gpu = 0x00000002,
    cpu = 0x00000003,
    unknown = 0x00000004,
};

pub const AddressMode = enum(u32) {
    undefined = 0x00000000,
    clamp_to_edge = 0x00000001,
    repeat = 0x00000002,
    mirror_repeat = 0x00000003,
};

pub const AlphaMode = enum(u32) {
    @"opaque" = 0x00000001,
    premultiplied = 0x00000002,
    unpremultiplied = 0x00000003,
};

pub const BackendType = enum(u32) {
    undefined = 0x00000000,
    null = 0x00000001,
    web_gpu = 0x00000002,
    d3d11 = 0x00000003,
    d3d12 = 0x00000004,
    metal = 0x00000005,
    vulkan = 0x00000006,
    open_gl = 0x00000007,
    open_gles = 0x00000008,
};

pub const BlendFactor = enum(u32) {
    undefined = 0x00000000,
    zero = 0x00000001,
    one = 0x00000002,
    src = 0x00000003,
    one_minus_src = 0x00000004,
    src_alpha = 0x00000005,
    one_minus_src_alpha = 0x00000006,
    dst = 0x00000007,
    one_minus_dst = 0x00000008,
    dst_alpha = 0x00000009,
    one_minus_dst_alpha = 0x0000000A,
    src_alpha_saturated = 0x0000000B,
    constant = 0x0000000C,
    one_minus_constant = 0x0000000D,
    src1 = 0x0000000E,
    one_minus_src1 = 0x0000000F,
    src1_alpha = 0x00000010,
    one_minus_src1_alpha = 0x00000011,
};

pub const BlendOperation = enum(u32) {
    undefined = 0x00000000,
    add = 0x00000001,
    subtract = 0x00000002,
    reverse_subtract = 0x00000003,
    min = 0x00000004,
    max = 0x00000005,
};

pub const BufferBindingType = enum(u32) {
    binding_not_used = 0x00000000,
    undefined = 0x00000001,
    uniform = 0x00000002,
    storage = 0x00000003,
    read_only_storage = 0x00000004,
};

pub const BufferMapState = enum(u32) {
    unmapped = 0x00000001,
    pending = 0x00000002,
    mapped = 0x00000003,
};

pub const CallbackMode = enum(u32) {
    wait_any_only = 0x00000001,
    allow_process_events = 0x00000002,
    allow_spontaneous = 0x00000003,
};

pub const ColorSpacePrimariesDawn = enum(u32) {
    srgb = 0x00000001,
    // rec709 = 0x00000001,
    rec601 = 0x00000002,
    rec2020 = 0x00000003,
    display_p3 = 0x00000004,
};

pub const ColorSpaceTransferDawn = enum(u32) {
    identity = 0x00000001,
    srgb = 0x00000002,
    display_p3 = 0x00000003,
    smpte_170m = 0x00000004,
    hlg = 0x00000005,
    pq = 0x00000006,
};

pub const ColorSpaceYCbCrMatrixDawn = enum(u32) {
    identity = 0x00000001,
    rec601 = 0x00000002,
    rec709 = 0x00000003,
    rec2020 = 0x00000004,
};

pub const ColorSpaceYCbCrRangeDawn = enum(u32) {
    identity = 0x00000001,
    narrow = 0x00000002,
    full = 0x00000003,
};

pub const CompareFunction = enum(u32) {
    undefined = 0x00000000,
    never = 0x00000001,
    less = 0x00000002,
    equal = 0x00000003,
    less_equal = 0x00000004,
    greater = 0x00000005,
    not_equal = 0x00000006,
    greater_equal = 0x00000007,
    always = 0x00000008,
};

pub const CompilationInfoRequestStatus = enum(u32) {
    success = 0x00000001,
    callback_cancelled = 0x00000002,
};

pub const CompilationMessageType = enum(u32) {
    err = 0x00000001,
    warning = 0x00000002,
    info = 0x00000003,
};

pub const ComponentSwizzle = enum(u32) {
    undefined = 0x00000000,
    zero = 0x00000001,
    one = 0x00000002,
    r = 0x00000003,
    g = 0x00000004,
    b = 0x00000005,
    a = 0x00000006,
};

pub const CompositeAlphaMode = enum(u32) {
    auto = 0x00000000,
    @"opaque" = 0x00000001,
    premultiplied = 0x00000002,
    unpremultiplied = 0x00000003,
    inherit = 0x00000004,
};

pub const CreatePipelineAsyncStatus = enum(u32) {
    success = 0x00000001,
    callback_cancelled = 0x00000002,
    validation_error = 0x00000003,
    internal_error = 0x00000004,
};

pub const CullMode = enum(u32) {
    undefined = 0x00000000,
    none = 0x00000001,
    front = 0x00000002,
    back = 0x00000003,
};

pub const DeviceLostReason = enum(u32) {
    unknown = 0x00000001,
    destroyed = 0x00000002,
    callback_cancelled = 0x00000003,
    failed_creation = 0x00000004,
};

pub const ErrorFilter = enum(u32) {
    validation = 0x00000001,
    out_of_memory = 0x00000002,
    internal = 0x00000003,
};

pub const ErrorType = enum(u32) {
    no_error = 0x00000001,
    validation = 0x00000002,
    out_of_memory = 0x00000003,
    internal = 0x00000004,
    unknown = 0x00000005,
};

pub const ExternalTextureRotation = enum(u32) {
    rotate0_degrees = 0x00000001,
    rotate90_degrees = 0x00000002,
    rotate180_degrees = 0x00000003,
    rotate270_degrees = 0x00000004,
};

pub const FeatureLevel = enum(u32) {
    undefined = 0x00000000,
    compatibility = 0x00000001,
    core = 0x00000002,
};

pub const FeatureName = enum(u32) {
    core_features_and_limits = 0x00000001,
    depth_clip_control = 0x00000002,
    depth32_float_stencil8 = 0x00000003,
    texture_compression_bc = 0x00000004,
    texture_compression_bc_sliced3d = 0x00000005,
    texture_compression_etc2 = 0x00000006,
    texture_compression_astc = 0x00000007,
    texture_compression_astc_sliced3d = 0x00000008,
    timestamp_query = 0x00000009,
    indirect_first_instance = 0x0000000A,
    shader_f16 = 0x0000000B,
    rg11b10_ufloat_renderable = 0x0000000C,
    bgra8_unorm_storage = 0x0000000D,
    float32_filterable = 0x0000000E,
    float32_blendable = 0x0000000F,
    clip_distances = 0x00000010,
    dual_source_blending = 0x00000011,
    subgroups = 0x00000012,
    texture_formats_tier1 = 0x00000013,
    texture_formats_tier2 = 0x00000014,
    primitive_index = 0x00000015,
    texture_component_swizzle = 0x00000016,
    dawn_internal_usages = 0x00050000,
    dawn_multi_planar_formats = 0x00050001,
    dawn_native = 0x00050002,
    chromium_experimental_timestamp_query_inside_passes = 0x00050003,
    implicit_device_synchronization = 0x00050004,
    transient_attachments = 0x00050006,
    msaa_render_to_single_sampled = 0x00050007,
    d3d11_multithread_protected = 0x00050008,
    angle_texture_sharing = 0x00050009,
    pixel_local_storage_coherent = 0x0005000A,
    pixel_local_storage_non_coherent = 0x0005000B,
    unorm16_texture_formats = 0x0005000C,
    multi_planar_format_extended_usages = 0x0005000D,
    multi_planar_format_p010 = 0x0005000E,
    host_mapped_pointer = 0x0005000F,
    multi_planar_render_targets = 0x00050010,
    multi_planar_format_nv12a = 0x00050011,
    framebuffer_fetch = 0x00050012,
    buffer_map_extended_usages = 0x00050013,
    adapter_properties_memory_heaps = 0x00050014,
    adapter_properties_d3d = 0x00050015,
    adapter_properties_vk = 0x00050016,
    dawn_format_capabilities = 0x00050017,
    dawn_drm_format_capabilities = 0x00050018,
    multi_planar_format_nv16 = 0x00050019,
    multi_planar_format_nv24 = 0x0005001A,
    multi_planar_format_p210 = 0x0005001B,
    multi_planar_format_p410 = 0x0005001C,
    shared_texture_memory_vk_dedicated_allocation = 0x0005001D,
    shared_texture_memory_a_hardware_buffer = 0x0005001E,
    shared_texture_memory_dma_buf = 0x0005001F,
    shared_texture_memory_opaque_fd = 0x00050020,
    shared_texture_memory_zircon_handle = 0x00050021,
    shared_texture_memory_dxgi_shared_handle = 0x00050022,
    shared_texture_memory_d3d11_texture2d = 0x00050023,
    shared_texture_memory_io_surface = 0x00050024,
    shared_texture_memory_egl_image = 0x00050025,
    shared_fence_vk_semaphore_opaque_fd = 0x00050026,
    shared_fence_sync_fd = 0x00050027,
    shared_fence_vk_semaphore_zircon_handle = 0x00050028,
    shared_fence_dxgi_shared_handle = 0x00050029,
    shared_fence_mtl_shared_event = 0x0005002A,
    shared_buffer_memory_d3d12_resource = 0x0005002B,
    static_samplers = 0x0005002C,
    y_cb_cr_vulkan_samplers = 0x0005002D,
    shader_module_compilation_options = 0x0005002E,
    dawn_load_resolve_texture = 0x0005002F,
    dawn_partial_load_resolve_texture = 0x00050030,
    multi_draw_indirect = 0x00050031,
    dawn_texel_copy_buffer_row_alignment = 0x00050032,
    flexible_texture_views = 0x00050033,
    chromium_experimental_subgroup_matrix = 0x00050034,
    shared_fence_egl_sync = 0x00050035,
    dawn_device_allocator_control = 0x00050036,
    adapter_properties_wgpu = 0x00050037,
    shared_buffer_memory_d3d12_shared_memory_file_mapping_handle = 0x00050038,
    shared_texture_memory_d3d12_resource = 0x00050039,
    chromium_experimental_sampling_resource_table = 0x0005003A,
    chromium_experimental_subgroup_size_control = 0x0005003B,
    atomic_vec2u_min_max = 0x0005003C,
    unorm16_formats_for_external_texture = 0x0005003D,
    opaque_y_cb_cr_android_for_external_texture = 0x0005003E,
    unorm16_filterable = 0x0005003F,
    render_pass_render_area = 0x00050040,
    adapter_properties_drm = 0x00050041,
};

pub const FilterMode = enum(u32) {
    undefined = 0x00000000,
    nearest = 0x00000001,
    linear = 0x00000002,
};

pub const FrontFace = enum(u32) {
    undefined = 0x00000000,
    ccw = 0x00000001,
    cw = 0x00000002,
};

pub const IndexFormat = enum(u32) {
    undefined = 0x00000000,
    uint16 = 0x00000001,
    uint32 = 0x00000002,
};

pub const InstanceFeatureName = enum(u32) {
    timed_wait_any = 0x00000001,
    shader_source_spirv = 0x00000002,
    multiple_devices_per_adapter = 0x00000003,
};

pub const LoadOp = enum(u32) {
    undefined = 0x00000000,
    load = 0x00000001,
    clear = 0x00000002,
    expand_resolve_texture = 0x00050003,
};

pub const LoggingType = enum(u32) {
    verbose = 0x00000001,
    info = 0x00000002,
    warning = 0x00000003,
    err = 0x00000004,
};

pub const MapAsyncStatus = enum(u32) {
    success = 0x00000001,
    callback_cancelled = 0x00000002,
    err = 0x00000003,
    aborted = 0x00000004,
};

pub const MipmapFilterMode = enum(u32) {
    undefined = 0x00000000,
    nearest = 0x00000001,
    linear = 0x00000002,
};

pub const OptionalBool = enum(u32) {
    false = 0x00000000,
    true = 0x00000001,
    undefined = 0x00000002,
};

pub const PopErrorScopeStatus = enum(u32) {
    success = 0x00000001,
    callback_cancelled = 0x00000002,
    err = 0x00000003,
};

pub const PowerPreference = enum(u32) {
    undefined = 0x00000000,
    low_power = 0x00000001,
    high_performance = 0x00000002,
};

pub const PredefinedColorSpace = enum(u32) {
    srgb = 0x00000001,
    display_p3 = 0x00000002,
    srgb_linear = 0x00050003,
    display_p3_linear = 0x00050004,
};

pub const PresentMode = enum(u32) {
    undefined = 0x00000000,
    fifo = 0x00000001,
    fifo_relaxed = 0x00000002,
    immediate = 0x00000003,
    mailbox = 0x00000004,
};

pub const PrimitiveTopology = enum(u32) {
    undefined = 0x00000000,
    point_list = 0x00000001,
    line_list = 0x00000002,
    line_strip = 0x00000003,
    triangle_list = 0x00000004,
    triangle_strip = 0x00000005,
};

pub const QueryType = enum(u32) {
    occlusion = 0x00000001,
    timestamp = 0x00000002,
};

pub const QueueWorkDoneStatus = enum(u32) {
    success = 0x00000001,
    callback_cancelled = 0x00000002,
    err = 0x00000003,
};

pub const RequestAdapterStatus = enum(u32) {
    success = 0x00000001,
    callback_cancelled = 0x00000002,
    unavailable = 0x00000003,
    err = 0x00000004,
};

pub const RequestDeviceStatus = enum(u32) {
    success = 0x00000001,
    callback_cancelled = 0x00000002,
    err = 0x00000003,
};

pub const SamplerBindingType = enum(u32) {
    binding_not_used = 0x00000000,
    undefined = 0x00000001,
    filtering = 0x00000002,
    non_filtering = 0x00000003,
    comparison = 0x00000004,
};

pub const SharedFenceType = enum(u32) {
    vk_semaphore_opaque_fd = 0x00000001,
    sync_fd = 0x00000002,
    vk_semaphore_zircon_handle = 0x00000003,
    dxgi_shared_handle = 0x00000004,
    mtl_shared_event = 0x00000005,
    egl_sync = 0x00000006,
};

pub const Status = enum(u32) {
    success = 0x00000001,
    err = 0x00000002,
};

pub const StencilOperation = enum(u32) {
    undefined = 0x00000000,
    keep = 0x00000001,
    zero = 0x00000002,
    replace = 0x00000003,
    invert = 0x00000004,
    increment_clamp = 0x00000005,
    decrement_clamp = 0x00000006,
    increment_wrap = 0x00000007,
    decrement_wrap = 0x00000008,
};

pub const StorageTextureAccess = enum(u32) {
    binding_not_used = 0x00000000,
    undefined = 0x00000001,
    write_only = 0x00000002,
    read_only = 0x00000003,
    read_write = 0x00000004,
};

pub const StoreOp = enum(u32) {
    undefined = 0x00000000,
    store = 0x00000001,
    discard = 0x00000002,
};

pub const SType = enum(u32) {
    shader_source_spirv = 0x00000001,
    shader_source_wgsl = 0x00000002,
    render_pass_max_draw_count = 0x00000003,
    surface_source_metal_layer = 0x00000004,
    surface_source_windows_hwnd = 0x00000005,
    surface_source_xlib_window = 0x00000006,
    surface_source_wayland_surface = 0x00000007,
    surface_source_android_native_window = 0x00000008,
    surface_source_xcb_window = 0x00000009,
    surface_color_management = 0x0000000A,
    request_adapter_web_xr_options = 0x0000000B,
    texture_component_swizzle_descriptor = 0x0000000C,
    external_texture_binding_layout = 0x0000000D,
    external_texture_binding_entry = 0x0000000E,
    compatibility_mode_limits = 0x0000000F,
    texture_binding_view_dimension = 0x00000010,
    emscripten_surface_source_canvas_html_selector = 0x00040000,
    surface_descriptor_from_windows_core_window = 0x00050000,
    surface_descriptor_from_windows_uwp_swap_chain_panel = 0x00050003,
    dawn_texture_internal_usage_descriptor = 0x00050004,
    dawn_encoder_internal_usage_descriptor = 0x00050005,
    dawn_instance_descriptor = 0x00050006,
    dawn_cache_device_descriptor = 0x00050007,
    dawn_adapter_properties_power_preference = 0x00050008,
    dawn_buffer_descriptor_error_info_from_wire_client = 0x00050009,
    dawn_toggles_descriptor = 0x0005000A,
    dawn_shader_module_spirv_options_descriptor = 0x0005000B,
    request_adapter_options_luid = 0x0005000C,
    request_adapter_options_get_gl_proc = 0x0005000D,
    request_adapter_options_d3d11_device = 0x0005000E,
    dawn_render_pass_sample_count = 0x0005000F,
    render_pass_pixel_local_storage = 0x00050010,
    pipeline_layout_pixel_local_storage = 0x00050011,
    buffer_host_mapped_pointer = 0x00050012,
    adapter_properties_memory_heaps = 0x00050013,
    adapter_properties_d3d = 0x00050014,
    adapter_properties_vk = 0x00050015,
    dawn_wire_wgsl_control = 0x00050016,
    dawn_wgsl_blocklist = 0x00050017,
    dawn_drm_format_capabilities = 0x00050018,
    shader_module_compilation_options = 0x00050019,
    color_target_state_expand_resolve_texture_dawn = 0x0005001A,
    render_pass_render_area_rect = 0x0005001B,
    shared_texture_memory_vk_dedicated_allocation_descriptor = 0x0005001C,
    shared_texture_memory_a_hardware_buffer_descriptor = 0x0005001D,
    shared_texture_memory_dma_buf_descriptor = 0x0005001E,
    shared_texture_memory_opaque_fd_descriptor = 0x0005001F,
    shared_texture_memory_zircon_handle_descriptor = 0x00050020,
    shared_texture_memory_dxgi_shared_handle_descriptor = 0x00050021,
    shared_texture_memory_d3d11_texture2d_descriptor = 0x00050022,
    shared_texture_memory_io_surface_descriptor = 0x00050023,
    shared_texture_memory_egl_image_descriptor = 0x00050024,
    shared_texture_memory_initialized_begin_state = 0x00050025,
    shared_texture_memory_initialized_end_state = 0x00050026,
    shared_texture_memory_vk_image_layout_begin_state = 0x00050027,
    shared_texture_memory_vk_image_layout_end_state = 0x00050028,
    shared_texture_memory_d3d_swapchain_begin_state = 0x00050029,
    shared_fence_vk_semaphore_opaque_fd_descriptor = 0x0005002A,
    shared_fence_vk_semaphore_opaque_fd_export_info = 0x0005002B,
    shared_fence_sync_fd_descriptor = 0x0005002C,
    shared_fence_sync_fd_export_info = 0x0005002D,
    shared_fence_vk_semaphore_zircon_handle_descriptor = 0x0005002E,
    shared_fence_vk_semaphore_zircon_handle_export_info = 0x0005002F,
    shared_fence_dxgi_shared_handle_descriptor = 0x00050030,
    shared_fence_dxgi_shared_handle_export_info = 0x00050031,
    shared_fence_mtl_shared_event_descriptor = 0x00050032,
    shared_fence_mtl_shared_event_export_info = 0x00050033,
    shared_buffer_memory_d3d12_resource_descriptor = 0x00050034,
    static_sampler_binding_layout = 0x00050035,
    y_cb_cr_vk_descriptor = 0x00050036,
    shared_texture_memory_a_hardware_buffer_properties = 0x00050037,
    a_hardware_buffer_properties = 0x00050038,
    dawn_texel_copy_buffer_row_alignment_limits = 0x0005003A,
    adapter_properties_subgroup_matrix_configs = 0x0005003B,
    shared_fence_egl_sync_descriptor = 0x0005003C,
    shared_fence_egl_sync_export_info = 0x0005003D,
    dawn_injected_invalid_s_type = 0x0005003E,
    dawn_compilation_message_utf16 = 0x0005003F,
    dawn_fake_buffer_oom_for_testing = 0x00050040,
    surface_descriptor_from_windows_win_ui_swap_chain_panel = 0x00050041,
    dawn_device_allocator_control = 0x00050042,
    dawn_host_mapped_pointer_limits = 0x00050043,
    render_pass_descriptor_resolve_rect = 0x00050044,
    request_adapter_web_gpu_backend_options = 0x00050045,
    dawn_fake_device_initialize_error_for_testing = 0x00050046,
    shared_texture_memory_d3d11_begin_state = 0x00050047,
    dawn_consume_adapter_descriptor = 0x00050048,
    texel_buffer_binding_entry = 0x00050049,
    texel_buffer_binding_layout = 0x0005004A,
    shared_texture_memory_metal_end_access_state = 0x0005004B,
    adapter_properties_wgpu = 0x0005004C,
    shared_buffer_memory_d3d12_shared_memory_file_mapping_handle_descriptor = 0x0005004D,
    shared_texture_memory_d3d12_resource_descriptor = 0x0005004E,
    request_adapter_options_angle_virtualization_group = 0x0005004F,
    pipeline_layout_resource_table = 0x00050050,
    adapter_properties_explicit_compute_subgroup_size_configs = 0x00050051,
    adapter_properties_drm = 0x00050052,
};

pub const SubgroupMatrixComponentType = enum(u32) {
    f32 = 0x00000001,
    f16 = 0x00000002,
    u32 = 0x00000003,
    i32 = 0x00000004,
    u8 = 0x00000005,
    i8 = 0x00000006,
};

pub const SurfaceGetCurrentTextureStatus = enum(u32) {
    success_optimal = 0x00000001,
    success_suboptimal = 0x00000002,
    timeout = 0x00000003,
    outdated = 0x00000004,
    lost = 0x00000005,
    err = 0x00000006,
};

pub const TexelBufferAccess = enum(u32) {
    undefined = 0x00000000,
    read_only = 0x00000001,
    read_write = 0x00000002,
};

pub const TextureAspect = enum(u32) {
    undefined = 0x00000000,
    all = 0x00000001,
    stencil_only = 0x00000002,
    depth_only = 0x00000003,
    plane0_only = 0x00050000,
    plane1_only = 0x00050001,
    plane2_only = 0x00050002,
};

pub const TextureDimension = enum(u32) {
    undefined = 0x00000000,
    @"1d" = 0x00000001,
    @"2d" = 0x00000002,
    @"3d" = 0x00000003,
};

pub const TextureFormat = enum(u32) {
    undefined = 0x00000000,
    r8_unorm = 0x00000001,
    r8_snorm = 0x00000002,
    r8_uint = 0x00000003,
    r8_sint = 0x00000004,
    r16_unorm = 0x00000005,
    r16_snorm = 0x00000006,
    r16_uint = 0x00000007,
    r16_sint = 0x00000008,
    r16_float = 0x00000009,
    rg8_unorm = 0x0000000A,
    rg8_snorm = 0x0000000B,
    rg8_uint = 0x0000000C,
    rg8_sint = 0x0000000D,
    r32_float = 0x0000000E,
    r32_uint = 0x0000000F,
    r32_sint = 0x00000010,
    rg16_unorm = 0x00000011,
    rg16_snorm = 0x00000012,
    rg16_uint = 0x00000013,
    rg16_sint = 0x00000014,
    rg16_float = 0x00000015,
    rgba8_unorm = 0x00000016,
    rgba8_unorm_srgb = 0x00000017,
    rgba8_snorm = 0x00000018,
    rgba8_uint = 0x00000019,
    rgba8_sint = 0x0000001A,
    bgra8_unorm = 0x0000001B,
    bgra8_unorm_srgb = 0x0000001C,
    rgb10a2_uint = 0x0000001D,
    rgb10a2_unorm = 0x0000001E,
    rg11b10_ufloat = 0x0000001F,
    rgb9e5_ufloat = 0x00000020,
    rg32_float = 0x00000021,
    rg32_uint = 0x00000022,
    rg32_sint = 0x00000023,
    rgba16_unorm = 0x00000024,
    rgba16_snorm = 0x00000025,
    rgba16_uint = 0x00000026,
    rgba16_sint = 0x00000027,
    rgba16_float = 0x00000028,
    rgba32_float = 0x00000029,
    rgba32_uint = 0x0000002A,
    rgba32_sint = 0x0000002B,
    stencil8 = 0x0000002C,
    depth16_unorm = 0x0000002D,
    depth24_plus = 0x0000002E,
    depth24_plus_stencil8 = 0x0000002F,
    depth32_float = 0x00000030,
    depth32_float_stencil8 = 0x00000031,
    bc1rgba_unorm = 0x00000032,
    bc1rgba_unorm_srgb = 0x00000033,
    bc2rgba_unorm = 0x00000034,
    bc2rgba_unorm_srgb = 0x00000035,
    bc3rgba_unorm = 0x00000036,
    bc3rgba_unorm_srgb = 0x00000037,
    bc4r_unorm = 0x00000038,
    bc4r_snorm = 0x00000039,
    bc5rg_unorm = 0x0000003A,
    bc5rg_snorm = 0x0000003B,
    bc6hrgb_ufloat = 0x0000003C,
    bc6hrgb_float = 0x0000003D,
    bc7rgba_unorm = 0x0000003E,
    bc7rgba_unorm_srgb = 0x0000003F,
    etc2rgb8_unorm = 0x00000040,
    etc2rgb8_unorm_srgb = 0x00000041,
    etc2rgb8a1_unorm = 0x00000042,
    etc2rgb8a1_unorm_srgb = 0x00000043,
    etc2rgba8_unorm = 0x00000044,
    etc2rgba8_unorm_srgb = 0x00000045,
    eacr11_unorm = 0x00000046,
    eacr11_snorm = 0x00000047,
    eacrg11_unorm = 0x00000048,
    eacrg11_snorm = 0x00000049,
    astc4x4_unorm = 0x0000004A,
    astc4x4_unorm_srgb = 0x0000004B,
    astc5x4_unorm = 0x0000004C,
    astc5x4_unorm_srgb = 0x0000004D,
    astc5x5_unorm = 0x0000004E,
    astc5x5_unorm_srgb = 0x0000004F,
    astc6x5_unorm = 0x00000050,
    astc6x5_unorm_srgb = 0x00000051,
    astc6x6_unorm = 0x00000052,
    astc6x6_unorm_srgb = 0x00000053,
    astc8x5_unorm = 0x00000054,
    astc8x5_unorm_srgb = 0x00000055,
    astc8x6_unorm = 0x00000056,
    astc8x6_unorm_srgb = 0x00000057,
    astc8x8_unorm = 0x00000058,
    astc8x8_unorm_srgb = 0x00000059,
    astc10x5_unorm = 0x0000005A,
    astc10x5_unorm_srgb = 0x0000005B,
    astc10x6_unorm = 0x0000005C,
    astc10x6_unorm_srgb = 0x0000005D,
    astc10x8_unorm = 0x0000005E,
    astc10x8_unorm_srgb = 0x0000005F,
    astc10x10_unorm = 0x00000060,
    astc10x10_unorm_srgb = 0x00000061,
    astc12x10_unorm = 0x00000062,
    astc12x10_unorm_srgb = 0x00000063,
    astc12x12_unorm = 0x00000064,
    astc12x12_unorm_srgb = 0x00000065,
    r8bg8_biplanar420_unorm = 0x00050000,
    r10x6bg10x6_biplanar420_unorm = 0x00050001,
    r8bg8a8_triplanar420_unorm = 0x00050002,
    r8bg8_biplanar422_unorm = 0x00050003,
    r8bg8_biplanar444_unorm = 0x00050004,
    r10x6bg10x6_biplanar422_unorm = 0x00050005,
    r10x6bg10x6_biplanar444_unorm = 0x00050006,
    opaque_y_cb_cr_android = 0x00050007,
};

pub const TextureSampleType = enum(u32) {
    binding_not_used = 0x00000000,
    undefined = 0x00000001,
    float = 0x00000002,
    unfilterable_float = 0x00000003,
    depth = 0x00000004,
    sint = 0x00000005,
    uint = 0x00000006,
};

pub const TextureViewDimension = enum(u32) {
    undefined = 0x00000000,
    @"1d" = 0x00000001,
    @"2d" = 0x00000002,
    @"2d_array" = 0x00000003,
    cube = 0x00000004,
    cube_array = 0x00000005,
    @"3d" = 0x00000006,
};

pub const ToneMappingMode = enum(u32) {
    standard = 0x00000001,
    extended = 0x00000002,
};

pub const VertexFormat = enum(u32) {
    uint8 = 0x00000001,
    uint8x2 = 0x00000002,
    uint8x4 = 0x00000003,
    sint8 = 0x00000004,
    sint8x2 = 0x00000005,
    sint8x4 = 0x00000006,
    unorm8 = 0x00000007,
    unorm8x2 = 0x00000008,
    unorm8x4 = 0x00000009,
    snorm8 = 0x0000000A,
    snorm8x2 = 0x0000000B,
    snorm8x4 = 0x0000000C,
    uint16 = 0x0000000D,
    uint16x2 = 0x0000000E,
    uint16x4 = 0x0000000F,
    sint16 = 0x00000010,
    sint16x2 = 0x00000011,
    sint16x4 = 0x00000012,
    unorm16 = 0x00000013,
    unorm16x2 = 0x00000014,
    unorm16x4 = 0x00000015,
    snorm16 = 0x00000016,
    snorm16x2 = 0x00000017,
    snorm16x4 = 0x00000018,
    float16 = 0x00000019,
    float16x2 = 0x0000001A,
    float16x4 = 0x0000001B,
    float32 = 0x0000001C,
    float32x2 = 0x0000001D,
    float32x3 = 0x0000001E,
    float32x4 = 0x0000001F,
    uint32 = 0x00000020,
    uint32x2 = 0x00000021,
    uint32x3 = 0x00000022,
    uint32x4 = 0x00000023,
    sint32 = 0x00000024,
    sint32x2 = 0x00000025,
    sint32x3 = 0x00000026,
    sint32x4 = 0x00000027,
    unorm10_10_10_2 = 0x00000028,
    unorm8x4bgra = 0x00000029,
};

pub const VertexStepMode = enum(u32) {
    undefined = 0x00000000,
    vertex = 0x00000001,
    instance = 0x00000002,
};

pub const WaitStatus = enum(u32) {
    success = 0x00000001,
    timed_out = 0x00000002,
    err = 0x00000003,
};

pub const WGSLLanguageFeatureName = enum(u32) {
    readonly_and_readwrite_storage_textures = 0x00000001,
    packed4x8_integer_dot_product = 0x00000002,
    unrestricted_pointer_parameters = 0x00000003,
    pointer_composite_access = 0x00000004,
    uniform_buffer_standard_layout = 0x00000005,
    subgroup_id = 0x00000006,
    texture_and_sampler_let = 0x00000007,
    subgroup_uniformity = 0x00000008,
    texture_formats_tier1 = 0x00000009,
    linear_indexing = 0x0000000A,
    chromium_testing_unimplemented = 0x00050000,
    chromium_testing_unsafe_experimental = 0x00050001,
    chromium_testing_experimental = 0x00050002,
    chromium_testing_shipped_with_killswitch = 0x00050003,
    chromium_testing_shipped = 0x00050004,
    sized_binding_array = 0x00050005,
    texel_buffers = 0x00050006,
    chromium_print = 0x00050007,
    fragment_depth = 0x00050008,
    immediate_address_space = 0x00050009,
    buffer_view = 0x0005000B,
    filtering_parameters = 0x0005000C,
    swizzle_assignment = 0x0005000D,
};

//
// Packed structs
//

pub const BufferUsage = packed struct(u64) {
    map_read: bool = false, // 0x0000000000000001
    map_write: bool = false, // 0x0000000000000002
    copy_src: bool = false, // 0x0000000000000004
    copy_dst: bool = false, // 0x0000000000000008
    index: bool = false, // 0x0000000000000010
    vertex: bool = false, // 0x0000000000000020
    uniform: bool = false, // 0x0000000000000040
    storage: bool = false, // 0x0000000000000080
    indirect: bool = false, // 0x0000000000000100
    query_resolve: bool = false, // 0x0000000000000200
    texel_buffer: bool = false, // 0x0000000000000400
    _: u53 = 0,

    pub const none: BufferUsage = .{};
};

pub const ColorWriteMask = packed struct(u64) {
    red: bool = false, // 0x0000000000000001
    green: bool = false, // 0x0000000000000002
    blue: bool = false, // 0x0000000000000004
    alpha: bool = false, // 0x0000000000000008
    _: u60 = 0,

    pub const none: ColorWriteMask = .{};
    pub const all: ColorWriteMask = .{ .red = true, .green = true, .blue = true, .alpha = true };
};

pub const HeapProperty = packed struct(u64) {
    device_local: bool = false, // 0x0000000000000001
    host_visible: bool = false, // 0x0000000000000002
    host_coherent: bool = false, // 0x0000000000000004
    host_uncached: bool = false, // 0x0000000000000008
    host_cached: bool = false, // 0x0000000000000010
    _: u59 = 0,

    pub const none: HeapProperty = .{};
};

pub const MapMode = packed struct(u64) {
    read: bool = false, // 0x0000000000000001
    write: bool = false, // 0x0000000000000002
    _: u62 = 0,

    pub const none: MapMode = .{};
};

pub const ShaderStage = packed struct(u64) {
    vertex: bool = false, // 0x0000000000000001
    fragment: bool = false, // 0x0000000000000002
    compute: bool = false, // 0x0000000000000004
    _: u61 = 0,

    pub const none: ShaderStage = .{};
};

pub const TextureUsage = packed struct(u64) {
    copy_src: bool = false, // 0x0000000000000001
    copy_dst: bool = false, // 0x0000000000000002
    texture_binding: bool = false, // 0x0000000000000004
    storage_binding: bool = false, // 0x0000000000000008
    render_attachment: bool = false, // 0x0000000000000010
    transient_attachment: bool = false, // 0x0000000000000020
    storage_attachment: bool = false, // 0x0000000000000040
    _: u57 = 0,

    pub const none: TextureUsage = .{};
};

//
// Function pointers
//

pub const Callback = ?*const fn (userdata: ?*anyopaque) callconv(.c) void;

pub const DawnLoadCacheDataFunction = ?*const fn (
    key: ?*const anyopaque,
    key_size: usize,
    value: ?*anyopaque,
    value_size: usize,
    userdata: ?*anyopaque,
) callconv(.c) usize;

pub const DawnStoreCacheDataFunction = ?*const fn (
    key: ?*const anyopaque,
    key_size: usize,
    value: ?*const anyopaque,
    value_size: usize,
    userdata: ?*anyopaque,
) callconv(.c) void;

pub const Proc = ?*const fn () callconv(.c) void;

pub const BufferMapCallback = ?*const fn (
    status: MapAsyncStatus,
    message: StringView,
    userdata1: ?*anyopaque,
    userdata2: ?*anyopaque,
) callconv(.c) void;

pub const CompilationInfoCallback = ?*const fn (
    status: CompilationInfoRequestStatus,
    compilation_info: ?*const CompilationInfo,
    userdata1: ?*anyopaque,
    userdata2: ?*anyopaque,
) callconv(.c) void;

pub const CreateComputePipelineAsyncCallback = ?*const fn (
    status: CreatePipelineAsyncStatus,
    pipeline: ComputePipeline,
    message: StringView,
    userdata1: ?*anyopaque,
    userdata2: ?*anyopaque,
) callconv(.c) void;

pub const CreateRenderPipelineAsyncCallback = ?*const fn (
    status: CreatePipelineAsyncStatus,
    pipeline: RenderPipeline,
    message: StringView,
    userdata1: ?*anyopaque,
    userdata2: ?*anyopaque,
) callconv(.c) void;

pub const DeviceLostCallback = ?*const fn (
    device: ?*const Device,
    reason: DeviceLostReason,
    message: StringView,
    userdata1: ?*anyopaque,
    userdata2: ?*anyopaque,
) callconv(.c) void;

pub const LoggingCallback = ?*const fn (
    logging_type: LoggingType,
    message: StringView,
    userdata1: ?*anyopaque,
    userdata2: ?*anyopaque,
) callconv(.c) void;

pub const PopErrorScopeCallback = ?*const fn (
    status: PopErrorScopeStatus,
    error_type: ErrorType,
    message: StringView,
    userdata1: ?*anyopaque,
    userdata2: ?*anyopaque,
) callconv(.c) void;

pub const QueueWorkDoneCallback = ?*const fn (
    status: QueueWorkDoneStatus,
    message: StringView,
    userdata1: ?*anyopaque,
    userdata2: ?*anyopaque,
) callconv(.c) void;

pub const RequestAdapterCallback = ?*const fn (
    status: RequestAdapterStatus,
    adapter: Adapter,
    message: StringView,
    userdata1: ?*anyopaque,
    userdata2: ?*anyopaque,
) callconv(.c) void;

pub const RequestDeviceCallback = ?*const fn (
    status: RequestDeviceStatus,
    device: Device,
    message: StringView,
    userdata1: ?*anyopaque,
    userdata2: ?*anyopaque,
) callconv(.c) void;

pub const UncapturedErrorCallback = ?*const fn (
    device: ?*const Device,
    error_type: ErrorType,
    message: StringView,
    userdata1: ?*anyopaque,
    userdata2: ?*anyopaque,
) callconv(.c) void;

//
// extern structs
//

pub const ChainedStruct = extern struct {
    next: ?*const ChainedStruct = null,
    s_type: SType,
};

pub const BufferMapCallbackInfo = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    mode: CallbackMode = .wait_any_only,
    callback: BufferMapCallback = null,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,
};

pub const CompilationInfoCallbackInfo = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    mode: CallbackMode = .wait_any_only,
    callback: CompilationInfoCallback = null,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,
};

pub const CreateComputePipelineAsyncCallbackInfo = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    mode: CallbackMode = .wait_any_only,
    callback: CreateComputePipelineAsyncCallback = null,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,
};

pub const CreateRenderPipelineAsyncCallbackInfo = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    mode: CallbackMode = .wait_any_only,
    callback: CreateRenderPipelineAsyncCallback = null,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,
};

pub const DeviceLostCallbackInfo = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    mode: CallbackMode = .wait_any_only,
    callback: DeviceLostCallback = null,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,
};

pub const LoggingCallbackInfo = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    callback: LoggingCallback = null,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,
};

pub const PopErrorScopeCallbackInfo = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    mode: CallbackMode = .wait_any_only,
    callback: PopErrorScopeCallback = null,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,
};

pub const QueueWorkDoneCallbackInfo = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    mode: CallbackMode = .wait_any_only,
    callback: QueueWorkDoneCallback = null,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,
};

pub const RequestAdapterCallbackInfo = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    mode: CallbackMode = .wait_any_only,
    callback: RequestAdapterCallback = null,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,
};

pub const RequestDeviceCallbackInfo = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    mode: CallbackMode = .wait_any_only,
    callback: RequestDeviceCallback = null,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,
};

pub const UncapturedErrorCallbackInfo = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    callback: UncapturedErrorCallback = null,
    userdata1: ?*anyopaque = null,
    userdata2: ?*anyopaque = null,
};

/// Can be chained in AdapterInfo
pub const AdapterPropertiesD3D = extern struct {
    chain: ChainedStruct,
    shader_model: u32,
};

/// Can be chained in AdapterInfo
pub const AdapterPropertiesDrm = extern struct {
    chain: ChainedStruct,
    has_primary: Bool,
    has_render: Bool,
    primary_major: u64,
    primary_minor: u64,
    render_major: u64,
    render_minor: u64,
};

/// Can be chained in AdapterInfo
pub const AdapterPropertiesExplicitComputeSubgroupSizeConfigs = extern struct {
    chain: ChainedStruct,
    min_explicit_compute_subgroup_size: u32,
    max_explicit_compute_subgroup_size: u32,
    max_compute_workgroup_subgroups: u32,
};

/// Can be chained in AdapterInfo
pub const AdapterPropertiesVk = extern struct {
    chain: ChainedStruct,
    driver_version: u32,
};

/// Can be chained in AdapterInfo
pub const AdapterPropertiesWGPU = extern struct {
    chain: ChainedStruct,
    backend_type: BackendType,
};

pub const BindingResource = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    buffer: ?Buffer,
    offset: u64,
    size: u64,
    sampler: ?Sampler,
    texture_view: ?TextureView,
};

pub const BlendComponent = extern struct {
    operation: BlendOperation,
    src_factor: BlendFactor,
    dst_factor: BlendFactor,
};

pub const BufferBindingLayout = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    type: BufferBindingType = .binding_not_used,
    has_dynamic_offset: Bool = .false,
    min_binding_size: u64 = 0,
};

/// Can be chained in BufferDescriptor
pub const BufferHostMappedPointer = extern struct {
    chain: ChainedStruct,
    pointer: ?*anyopaque = null,
    dispose_callback: Callback,
    userdata: ?*anyopaque = null,
};

pub const Color = extern struct {
    r: f64 = 0,
    g: f64 = 0,
    b: f64 = 0,
    a: f64 = 0,
};

pub const ColorSpaceDawn = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    primaries: ColorSpacePrimariesDawn,
    transfer: ColorSpaceTransferDawn,
    y_cb_cr_range: ColorSpaceYCbCrRangeDawn,
    y_cb_cr_matrix: ColorSpaceYCbCrMatrixDawn,
};

/// Can be chained in ColorTargetState
pub const ColorTargetStateExpandResolveTextureDawn = extern struct {
    chain: ChainedStruct,
    enabled: Bool,
};

pub const CommandBufferDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: StringView = .{},
};

/// Can be chained in Limits
pub const CompatibilityModeLimits = extern struct {
    chain: ChainedStruct,
    max_storage_buffers_in_vertex_stage: u32,
    max_storage_textures_in_vertex_stage: u32,
    max_storage_buffers_in_fragment_stage: u32,
    max_storage_textures_in_fragment_stage: u32,
};

pub const ConstantEntry = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    key: StringView = .{},
    value: f64,
};

pub const CopyTextureForBrowserOptions = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    flip_y: Bool,
    needs_color_space_conversion: Bool,
    src_alpha_mode: AlphaMode,
    src_transfer_function_parameters: ?[*]const f32,
    conversion_matrix: ?[*]const f32,
    dst_transfer_function_parameters: ?[*]const f32,
    dst_alpha_mode: AlphaMode,
    internal_usage: Bool,
};

/// Can be chained in AdapterInfo
pub const DawnAdapterPropertiesPowerPreference = extern struct {
    chain: ChainedStruct,
    power_preference: PowerPreference,
};

/// Can be chained in BufferDescriptor
pub const DawnBufferDescriptorErrorInfoFromWireClient = extern struct {
    chain: ChainedStruct,
    out_of_memory: Bool,
};

/// Can be chained in DeviceDescriptor
pub const DawnCacheDeviceDescriptor = extern struct {
    chain: ChainedStruct,
    isolation_key: StringView = .{},
    load_data_function: DawnLoadCacheDataFunction,
    store_data_function: DawnStoreCacheDataFunction,
    function_userdata: ?*anyopaque = null,
};

/// Can be chained in CompilationMessage
pub const DawnCompilationMessageUtf16 = extern struct {
    chain: ChainedStruct,
    line_pos: u64,
    offset: u64,
    length: u64,
};

/// Can be chained in DeviceDescriptor
pub const DawnConsumeAdapterDescriptor = extern struct {
    chain: ChainedStruct,
    consume_adapter: Bool,
};

/// Can be chained in DeviceDescriptor
pub const DawnDeviceAllocatorControl = extern struct {
    chain: ChainedStruct,
    allocator_heap_block_size: usize,
};

pub const DawnDrmFormatProperties = extern struct {
    modifier: u64,
    modifier_plane_count: u32,
};

/// Can be chained in CommandEncoderDescriptor
pub const DawnEncoderInternalUsageDescriptor = extern struct {
    chain: ChainedStruct,
    use_internal_usages: Bool,
};

/// Can be chained in BufferDescriptor
pub const DawnFakeBufferOOMForTesting = extern struct {
    chain: ChainedStruct,
    fake_oom_at_wire_client_map: Bool,
    fake_oom_at_native_map: Bool,
    fake_oom_at_device: Bool,
};

/// Can be chained in DeviceDescriptor
pub const DawnFakeDeviceInitializeErrorForTesting = extern struct {
    chain: ChainedStruct,
};

/// Can be chained in Limits
pub const DawnHostMappedPointerLimits = extern struct {
    chain: ChainedStruct,
    host_mapped_pointer_alignment: u32,
};

pub const DawnInjectedInvalidSType = extern struct {
    chain: ChainedStruct,
    invalid_s_type: SType,
};

/// Can be chained in RenderPassDescriptor
pub const DawnRenderPassSampleCount = extern struct {
    chain: ChainedStruct,
    sample_count: u32,
};

/// Can be chained in ShaderModuleDescriptor
pub const DawnShaderModuleSPIRVOptionsDescriptor = extern struct {
    chain: ChainedStruct,
    allow_non_uniform_derivatives: Bool,
};

/// Can be chained in Limits
pub const DawnTexelCopyBufferRowAlignmentLimits = extern struct {
    chain: ChainedStruct,
    min_texel_copy_buffer_row_alignment: u32,
};

/// Can be chained in TextureDescriptor
pub const DawnTextureInternalUsageDescriptor = extern struct {
    chain: ChainedStruct,
    internal_usage: TextureUsage,
};

/// Can be chained in InstanceDescriptor
/// Can be chained in RequestAdapterOptions
/// Can be chained in DeviceDescriptor
pub const DawnTogglesDescriptor = extern struct {
    chain: ChainedStruct,
    enabled_toggle_count: usize = 0,
    enabled_toggles: ?[*]const [*:0]const u8 = null,
    disabled_toggle_count: usize = 0,
    disabled_toggles: ?[*]const [*:0]const u8 = null,
};

/// Can be chained in InstanceDescriptor
pub const DawnWGSLBlocklist = extern struct {
    chain: ChainedStruct,
    blocklisted_feature_count: usize = 0,
    blocklisted_features: ?[*]const [*:0]const u8 = null,
};

/// Can be chained in InstanceDescriptor
pub const DawnWireWGSLControl = extern struct {
    chain: ChainedStruct,
    enable_experimental: Bool,
    enable_unsafe: Bool,
    enable_testing: Bool,
};

/// Can be chained in SurfaceDescriptor
pub const EmscriptenSurfaceSourceCanvasHTMLSelector = extern struct {
    chain: ChainedStruct,
    selector: StringView = .{},
};

pub const Extent2D = extern struct {
    width: u32,
    height: u32 = 1,
};

pub const Extent3D = extern struct {
    width: u32,
    height: u32 = 1,
    depth_or_array_layers: u32 = 1,
};

/// Can be chained in BindGroupEntry
pub const ExternalTextureBindingEntry = extern struct {
    chain: ChainedStruct,
    external_texture: ExternalTexture,
};

/// Can be chained in BindGroupLayoutEntry
pub const ExternalTextureBindingLayout = extern struct {
    chain: ChainedStruct,
};

pub const Future = extern struct {
    id: u64 = 0,
};

pub const InstanceLimits = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    timed_wait_any_max_count: usize,
};

pub const INTERNAL_HAVE_EMDAWNWEBGPU_HEADER = extern struct {
    unused: Bool,
};

pub const MemoryHeapInfo = extern struct {
    properties: HeapProperty,
    size: u64,
};

pub const MultisampleState = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    count: u32 = 1,
    mask: u32 = 0xffff_ffff,
    alpha_to_coverage_enabled: Bool = .false,
};

pub const Origin2D = extern struct {
    x: u32,
    y: u32,
};

pub const Origin3D = extern struct {
    x: u32,
    y: u32,
    z: u32,
};

pub const PassTimestampWrites = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    query_set: QuerySet,
    beginning_of_pass_write_index: u32,
    end_of_pass_write_index: u32,
};

/// Can be chained in PipelineLayoutDescriptor
pub const PipelineLayoutResourceTable = extern struct {
    chain: ChainedStruct,
    uses_resource_table: Bool,
};

pub const PipelineLayoutStorageAttachment = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    offset: u64,
    format: TextureFormat,
};

pub const PrimitiveState = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    topology: PrimitiveTopology = .triangle_list,
    strip_index_format: IndexFormat = .undefined,
    front_face: FrontFace = .ccw,
    cull_mode: CullMode = .none,
    unclipped_depth: Bool = .false,
};

pub const QuerySetDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: StringView = .{},
    type: QueryType,
    count: u32,
};

pub const QueueDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: StringView = .{},
};

pub const RenderBundleDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: StringView = .{},
};

pub const RenderBundleEncoderDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: StringView = .{},
    color_format_count: usize = 0,
    color_formats: ?[*]const TextureFormat = null,
    depth_stencil_format: TextureFormat,
    sample_count: u32,
    depth_read_only: Bool,
    stencil_read_only: Bool,
};

pub const RenderPassDepthStencilAttachment = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    view: TextureView,
    depth_load_op: LoadOp = .undefined,
    depth_store_op: StoreOp = .undefined,
    depth_clear_value: f32 = 0,
    depth_read_only: Bool = .false,
    stencil_load_op: LoadOp = .undefined,
    stencil_store_op: StoreOp = .undefined,
    stencil_clear_value: u32 = 0,
    stencil_read_only: Bool = .false,
};

/// Can be chained in RenderPassDescriptor
pub const RenderPassDescriptorResolveRect = extern struct {
    chain: ChainedStruct,
    color_offset_x: u32,
    color_offset_y: u32,
    resolve_offset_x: u32,
    resolve_offset_y: u32,
    width: u32,
    height: u32,
};

/// Can be chained in RenderPassDescriptor
pub const RenderPassMaxDrawCount = extern struct {
    chain: ChainedStruct,
    max_draw_count: u64,
};

/// Can be chained in RequestAdapterOptions
pub const RequestAdapterWebGPUBackendOptions = extern struct {
    chain: ChainedStruct,
};

/// Can be chained in RequestAdapterOptions
pub const RequestAdapterWebXROptions = extern struct {
    chain: ChainedStruct,
    xr_compatible: Bool,
};

pub const ResourceTableDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: StringView = .{},
    size: u32,
};

pub const SamplerBindingLayout = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    type: SamplerBindingType = .binding_not_used,
};

/// Can be chained in ShaderModuleDescriptor
pub const ShaderModuleCompilationOptions = extern struct {
    chain: ChainedStruct,
    strict_math: Bool,
};

/// Can be chained in ShaderModuleDescriptor
pub const ShaderSourceSPIRV = extern struct {
    chain: ChainedStruct,
    code_size: u32 = 0,
    code: ?[*]const u32 = null,
};

/// Can be chained in ShaderModuleDescriptor
pub const ShaderSourceWGSL = extern struct {
    chain: ChainedStruct,
    code: StringView = .{},
};

pub const SharedBufferMemoryBeginAccessDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    initialized: Bool,
    fence_count: usize = 0,
    fences: ?[*]SharedFence = null,
    signaled_values: ?[*]const u64 = null,
};

/// Can be chained in SharedBufferMemoryDescriptor
pub const SharedBufferMemoryD3D12SharedMemoryFileMappingHandleDescriptor = extern struct {
    chain: ChainedStruct,
    handle: ?*anyopaque = null,
    size: u64,
};

pub const SharedBufferMemoryEndAccessState = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    initialized: Bool,
    fence_count: usize = 0,
    fences: ?[*]const SharedFence = null,
    signaled_values: ?[*]const u64 = null,

    pub fn freeMembers(shared_buffer_memory_end_access_state: SharedBufferMemoryEndAccessState) void {
        return wgpuSharedBufferMemoryEndAccessStateFreeMembers(shared_buffer_memory_end_access_state);
    }
};

pub const SharedBufferMemoryProperties = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    usage: BufferUsage,
    size: u64,
};

/// Can be chained in SharedFenceDescriptor
pub const SharedFenceDXGISharedHandleDescriptor = extern struct {
    chain: ChainedStruct,
    handle: ?*anyopaque = null,
};

/// Can be chained in SharedFenceExportInfo
pub const SharedFenceDXGISharedHandleExportInfo = extern struct {
    chain: ChainedStruct,
    handle: ?*anyopaque = null,
};

/// Can be chained in SharedFenceDescriptor
pub const SharedFenceEGLSyncDescriptor = extern struct {
    chain: ChainedStruct,
    sync: ?*anyopaque = null,
};

/// Can be chained in SharedFenceExportInfo
pub const SharedFenceEGLSyncExportInfo = extern struct {
    chain: ChainedStruct,
    sync: ?*anyopaque = null,
};

/// Can be chained in SharedFenceDescriptor
pub const SharedFenceMTLSharedEventDescriptor = extern struct {
    chain: ChainedStruct,
    shared_event: ?*anyopaque = null,
};

/// Can be chained in SharedFenceExportInfo
pub const SharedFenceMTLSharedEventExportInfo = extern struct {
    chain: ChainedStruct,
    shared_event: ?*anyopaque = null,
};

/// Can be chained in SharedFenceDescriptor
pub const SharedFenceSyncFDDescriptor = extern struct {
    chain: ChainedStruct,
    handle: c_int,
};

/// Can be chained in SharedFenceExportInfo
pub const SharedFenceSyncFDExportInfo = extern struct {
    chain: ChainedStruct,
    handle: c_int,
};

/// Can be chained in SharedFenceDescriptor
pub const SharedFenceVkSemaphoreOpaqueFDDescriptor = extern struct {
    chain: ChainedStruct,
    handle: c_int,
};

/// Can be chained in SharedFenceExportInfo
pub const SharedFenceVkSemaphoreOpaqueFDExportInfo = extern struct {
    chain: ChainedStruct,
    handle: c_int,
};

/// Can be chained in SharedFenceDescriptor
pub const SharedFenceVkSemaphoreZirconHandleDescriptor = extern struct {
    chain: ChainedStruct,
    handle: u32,
};

/// Can be chained in SharedFenceExportInfo
pub const SharedFenceVkSemaphoreZirconHandleExportInfo = extern struct {
    chain: ChainedStruct,
    handle: u32,
};

/// Can be chained in SharedTextureMemoryDescriptor
pub const SharedTextureMemoryAHardwareBufferDescriptor = extern struct {
    chain: ChainedStruct,
    handle: ?*anyopaque = null,
};

/// Can be chained in SharedTextureMemoryBeginAccessDescriptor
pub const SharedTextureMemoryD3D11BeginState = extern struct {
    chain: ChainedStruct,
    requires_end_access_fence: Bool,
};

/// Can be chained in SharedTextureMemoryBeginAccessDescriptor
pub const SharedTextureMemoryD3DSwapchainBeginState = extern struct {
    chain: ChainedStruct,
    is_swapchain: Bool,
};

pub const SharedTextureMemoryDmaBufPlane = extern struct {
    fd: c_int,
    offset: u64,
    stride: u32,
};

/// Can be chained in SharedTextureMemoryDescriptor
pub const SharedTextureMemoryDXGISharedHandleDescriptor = extern struct {
    chain: ChainedStruct,
    handle: ?*anyopaque = null,
    use_keyed_mutex: Bool,
};

/// Can be chained in SharedTextureMemoryDescriptor
pub const SharedTextureMemoryEGLImageDescriptor = extern struct {
    chain: ChainedStruct,
    image: ?*anyopaque = null,
};

/// Can be chained in SharedTextureMemoryDescriptor
pub const SharedTextureMemoryIOSurfaceDescriptor = extern struct {
    chain: ChainedStruct,
    io_surface: ?*anyopaque = null,
    allow_storage_binding: Bool,
};

/// Can be chained in SharedTextureMemoryDescriptor
pub const SharedTextureMemoryOpaqueFDDescriptor = extern struct {
    chain: ChainedStruct,
    vk_image_create_info: ?*const anyopaque,
    memory_fd: c_int,
    memory_type_index: u32,
    allocation_size: u64,
    dedicated_allocation: Bool,
};

/// Can be chained in SharedTextureMemoryDescriptor
pub const SharedTextureMemoryVkDedicatedAllocationDescriptor = extern struct {
    chain: ChainedStruct,
    dedicated_allocation: Bool,
};

/// Can be chained in SharedTextureMemoryBeginAccessDescriptor
pub const SharedTextureMemoryVkImageLayoutBeginState = extern struct {
    chain: ChainedStruct,
    old_layout: i32,
    new_layout: i32,
};

/// Can be chained in SharedTextureMemoryEndAccessState
pub const SharedTextureMemoryVkImageLayoutEndState = extern struct {
    chain: ChainedStruct,
    old_layout: i32,
    new_layout: i32,
};

/// Can be chained in SharedTextureMemoryDescriptor
pub const SharedTextureMemoryZirconHandleDescriptor = extern struct {
    chain: ChainedStruct,
    memory_fd: u32,
    allocation_size: u64,
};

/// Can be chained in BindGroupLayoutEntry
pub const StaticSamplerBindingLayout = extern struct {
    chain: ChainedStruct,
    sampler: Sampler,
    sampled_texture_binding: u32,
};

pub const StencilFaceState = extern struct {
    compare: CompareFunction,
    fail_op: StencilOperation,
    depth_fail_op: StencilOperation,
    pass_op: StencilOperation,
};

pub const StorageTextureBindingLayout = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    access: StorageTextureAccess = .binding_not_used,
    format: TextureFormat = .undefined,
    view_dimension: TextureViewDimension = .undefined,
};

pub const SubgroupMatrixConfig = extern struct {
    component_type: SubgroupMatrixComponentType,
    result_component_type: SubgroupMatrixComponentType,
    m: u32,
    n: u32,
    k: u32,
};

pub const SupportedFeatures = extern struct {
    feature_count: usize = 0,
    features: ?[*]const FeatureName = null,

    pub fn freeMembers(supported_features: SupportedFeatures) void {
        return wgpuSupportedFeaturesFreeMembers(supported_features);
    }
};

pub const SupportedInstanceFeatures = extern struct {
    feature_count: usize = 0,
    features: ?[*]const InstanceFeatureName = null,

    pub fn freeMembers(supported_instance_features: SupportedInstanceFeatures) void {
        return wgpuSupportedInstanceFeaturesFreeMembers(supported_instance_features);
    }
};

pub const SupportedWGSLLanguageFeatures = extern struct {
    feature_count: usize = 0,
    features: ?[*]const WGSLLanguageFeatureName = null,

    pub fn freeMembers(supported_wgsl_language_features: SupportedWGSLLanguageFeatures) void {
        return wgpuSupportedWGSLLanguageFeaturesFreeMembers(supported_wgsl_language_features);
    }
};

pub const SurfaceCapabilities = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    usages: TextureUsage = .none,
    format_count: usize = 0,
    formats: ?[*]const TextureFormat = null,
    present_mode_count: usize = 0,
    present_modes: ?[*]const PresentMode = null,
    alpha_mode_count: usize = 0,
    alpha_modes: ?[*]const CompositeAlphaMode = null,

    pub fn freeMembers(surface_capabilities: SurfaceCapabilities) void {
        return wgpuSurfaceCapabilitiesFreeMembers(surface_capabilities);
    }
};

/// Can be chained in SurfaceDescriptor
pub const SurfaceColorManagement = extern struct {
    chain: ChainedStruct,
    color_space: PredefinedColorSpace,
    tone_mapping_mode: ToneMappingMode,
};

pub const SurfaceConfiguration = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    device: Device,
    format: TextureFormat,
    usage: TextureUsage,
    width: u32,
    height: u32,
    view_format_count: usize = 0,
    view_formats: ?[*]const TextureFormat = null,
    alpha_mode: CompositeAlphaMode = .auto,
    present_mode: PresentMode = .undefined,
};

/// Can be chained in SurfaceDescriptor
pub const SurfaceDescriptorFromWindowsCoreWindow = extern struct {
    chain: ChainedStruct,
    core_window: ?*anyopaque = null,
};

/// Can be chained in SurfaceDescriptor
pub const SurfaceDescriptorFromWindowsUWPSwapChainPanel = extern struct {
    chain: ChainedStruct,
    swap_chain_panel: ?*anyopaque = null,
};

/// Can be chained in SurfaceDescriptor
pub const SurfaceDescriptorFromWindowsWinUISwapChainPanel = extern struct {
    chain: ChainedStruct,
    swap_chain_panel: ?*anyopaque = null,
};

/// Can be chained in SurfaceDescriptor
pub const SurfaceSourceAndroidNativeWindow = extern struct {
    chain: ChainedStruct,
    window: ?*anyopaque = null,
};

/// Can be chained in SurfaceDescriptor
pub const SurfaceSourceMetalLayer = extern struct {
    chain: ChainedStruct,
    layer: ?*anyopaque = null,
};

/// Can be chained in SurfaceDescriptor
pub const SurfaceSourceWaylandSurface = extern struct {
    chain: ChainedStruct,
    display: ?*anyopaque = null,
    surface: ?*anyopaque = null,
};

/// Can be chained in SurfaceDescriptor
pub const SurfaceSourceWindowsHWND = extern struct {
    chain: ChainedStruct,
    hinstance: ?*anyopaque = null,
    hwnd: ?*anyopaque = null,
};

/// Can be chained in SurfaceDescriptor
pub const SurfaceSourceXCBWindow = extern struct {
    chain: ChainedStruct,
    connection: ?*anyopaque = null,
    window: u32,
};

/// Can be chained in SurfaceDescriptor
pub const SurfaceSourceXlibWindow = extern struct {
    chain: ChainedStruct,
    display: ?*anyopaque = null,
    window: u64,
};

pub const SurfaceTexture = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    texture: ?Texture = null,
    status: SurfaceGetCurrentTextureStatus = .err,
};

/// Can be chained in BindGroupEntry
pub const TexelBufferBindingEntry = extern struct {
    chain: ChainedStruct,
    texel_buffer_view: TexelBufferView,
};

/// Can be chained in BindGroupLayoutEntry
pub const TexelBufferBindingLayout = extern struct {
    chain: ChainedStruct,
    access: TexelBufferAccess,
    format: TextureFormat,
};

pub const TexelBufferViewDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: StringView = .{},
    format: TextureFormat,
    offset: u64,
    size: u64,
};

pub const TexelCopyBufferLayout = extern struct {
    offset: u64,
    bytes_per_row: u32,
    rows_per_image: u32,
};

pub const TextureBindingLayout = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    sample_type: TextureSampleType = .binding_not_used,
    view_dimension: TextureViewDimension = .undefined,
    multisampled: Bool = .false,
};

/// Can be chained in TextureDescriptor
pub const TextureBindingViewDimension = extern struct {
    chain: ChainedStruct,
    texture_binding_view_dimension: TextureViewDimension,
};

pub const TextureComponentSwizzle = extern struct {
    r: ComponentSwizzle,
    g: ComponentSwizzle,
    b: ComponentSwizzle,
    a: ComponentSwizzle,
};

pub const VertexAttribute = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    format: VertexFormat,
    offset: u64,
    shader_location: u32,
};

/// Can be chained in SamplerDescriptor
/// Can be chained in TextureViewDescriptor
pub const YCbCrVkDescriptor = extern struct {
    chain: ChainedStruct,
    vk_format: u32,
    vk_y_cb_cr_model: u32,
    vk_y_cb_cr_range: u32,
    vk_component_swizzle_red: u32,
    vk_component_swizzle_green: u32,
    vk_component_swizzle_blue: u32,
    vk_component_swizzle_alpha: u32,
    vk_x_chroma_offset: u32,
    vk_y_chroma_offset: u32,
    vk_chroma_filter: FilterMode,
    force_explicit_reconstruction: Bool,
    external_format: u64,
};

/// Can be chained in AdapterInfo
pub const AdapterPropertiesMemoryHeaps = extern struct {
    chain: ChainedStruct,
    heap_count: usize = 0,
    heap_info: ?[*]const MemoryHeapInfo = null,

    pub fn freeMembers(adapter_properties_memory_heaps: AdapterPropertiesMemoryHeaps) void {
        return wgpuAdapterPropertiesMemoryHeapsFreeMembers(adapter_properties_memory_heaps);
    }
};

/// Can be chained in AdapterInfo
pub const AdapterPropertiesSubgroupMatrixConfigs = extern struct {
    chain: ChainedStruct,
    config_count: usize = 0,
    configs: ?[*]const SubgroupMatrixConfig = null,

    pub fn freeMembers(adapter_properties_subgroup_matrix_configs: AdapterPropertiesSubgroupMatrixConfigs) void {
        return wgpuAdapterPropertiesSubgroupMatrixConfigsFreeMembers(adapter_properties_subgroup_matrix_configs);
    }
};

pub const AHardwareBufferProperties = extern struct {
    y_cb_cr_info: YCbCrVkDescriptor,
};

pub const BindGroupEntry = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    binding: u32,
    buffer: ?Buffer,
    offset: u64,
    size: u64,
    sampler: ?Sampler,
    texture_view: ?TextureView,
};

pub const BindGroupLayoutEntry = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    binding: u32,
    visibility: ShaderStage,
    binding_array_size: u32 = 0,
    buffer: BufferBindingLayout = .{},
    sampler: SamplerBindingLayout = .{},
    texture: TextureBindingLayout = .{},
    storage_texture: StorageTextureBindingLayout = .{},
};

pub const BlendState = extern struct {
    color: BlendComponent,
    alpha: BlendComponent,
};

pub const BufferDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: StringView = .{},
    usage: BufferUsage,
    size: u64,
    mapped_at_creation: Bool = .false,
};

pub const CommandEncoderDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: StringView = .{},
};

pub const CompilationMessage = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    message: StringView = .{},
    type: CompilationMessageType,
    line_num: u64,
    line_pos: u64,
    offset: u64,
    length: u64,
};

pub const ComputePassDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: StringView = .{},
    timestamp_writes: ?*const PassTimestampWrites = null,
};

pub const ComputeState = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    module: ShaderModule,
    entry_point: StringView = .{},
    constant_count: usize = 0,
    constants: ?[*]const ConstantEntry = null,
};

/// Can be chained in DawnFormatCapabilities
pub const DawnDrmFormatCapabilities = extern struct {
    chain: ChainedStruct,
    properties_count: usize = 0,
    properties: ?[*]const DawnDrmFormatProperties = null,

    pub fn freeMembers(dawn_drm_format_capabilities: DawnDrmFormatCapabilities) void {
        return wgpuDawnDrmFormatCapabilitiesFreeMembers(dawn_drm_format_capabilities);
    }
};

pub const DepthStencilState = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    format: TextureFormat,
    depth_write_enabled: OptionalBool,
    depth_compare: CompareFunction,
    stencil_front: StencilFaceState,
    stencil_back: StencilFaceState,
    stencil_read_mask: u32,
    stencil_write_mask: u32,
    depth_bias: i32,
    depth_bias_slope_scale: f32,
    depth_bias_clamp: f32,
};

pub const ExternalTextureDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: StringView = .{},
    plane0: TextureView,
    plane1: ?TextureView,
    crop_origin: Origin2D,
    crop_size: Extent2D,
    apparent_size: Extent2D,
    do_yuv_to_rgb_conversion_only: Bool,
    yuv_to_rgb_conversion_matrix: ?[*]const f32,
    src_transfer_function_parameters: ?[*]const f32,
    dst_transfer_function_parameters: ?[*]const f32,
    gamut_conversion_matrix: ?[*]const f32,
    mirrored: Bool,
    rotation: ExternalTextureRotation,
};

pub const FutureWaitInfo = extern struct {
    future: Future,
    completed: Bool = .false,
};

pub const ImageCopyExternalTexture = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    external_texture: ExternalTexture,
    origin: Origin3D,
    natural_size: Extent2D,
};

pub const InstanceDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    required_feature_count: usize = 0,
    required_features: ?[*]const InstanceFeatureName = null,
    required_limits: ?*const InstanceLimits = null,
};

pub const Limits = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    max_texture_dimension1d: u32 = wgpu.WGPU_LIMIT_U32_UNDEFINED,
    max_texture_dimension2d: u32 = wgpu.WGPU_LIMIT_U32_UNDEFINED,
    max_texture_dimension3d: u32 = wgpu.WGPU_LIMIT_U32_UNDEFINED,
    max_texture_array_layers: u32 = wgpu.WGPU_LIMIT_U32_UNDEFINED,
    max_bind_groups: u32 = wgpu.WGPU_LIMIT_U32_UNDEFINED,
    max_bind_groups_plus_vertex_buffers: u32 = wgpu.WGPU_LIMIT_U32_UNDEFINED,
    max_bindings_per_bind_group: u32 = wgpu.WGPU_LIMIT_U32_UNDEFINED,
    max_dynamic_uniform_buffers_per_pipeline_layout: u32 = wgpu.WGPU_LIMIT_U32_UNDEFINED,
    max_dynamic_storage_buffers_per_pipeline_layout: u32 = wgpu.WGPU_LIMIT_U32_UNDEFINED,
    max_sampled_textures_per_shader_stage: u32 = wgpu.WGPU_LIMIT_U32_UNDEFINED,
    max_samplers_per_shader_stage: u32 = wgpu.WGPU_LIMIT_U32_UNDEFINED,
    max_storage_buffers_per_shader_stage: u32 = wgpu.WGPU_LIMIT_U32_UNDEFINED,
    max_storage_textures_per_shader_stage: u32 = wgpu.WGPU_LIMIT_U32_UNDEFINED,
    max_uniform_buffers_per_shader_stage: u32 = wgpu.WGPU_LIMIT_U32_UNDEFINED,
    max_uniform_buffer_binding_size: u64 = wgpu.WGPU_LIMIT_U64_UNDEFINED,
    max_storage_buffer_binding_size: u64 = wgpu.WGPU_LIMIT_U64_UNDEFINED,
    min_uniform_buffer_offset_alignment: u32 = wgpu.WGPU_LIMIT_U32_UNDEFINED,
    min_storage_buffer_offset_alignment: u32 = wgpu.WGPU_LIMIT_U32_UNDEFINED,
    max_vertex_buffers: u32 = wgpu.WGPU_LIMIT_U32_UNDEFINED,
    max_buffer_size: u64 = wgpu.WGPU_LIMIT_U64_UNDEFINED,
    max_vertex_attributes: u32 = wgpu.WGPU_LIMIT_U32_UNDEFINED,
    max_vertex_buffer_array_stride: u32 = wgpu.WGPU_LIMIT_U32_UNDEFINED,
    max_inter_stage_shader_variables: u32 = wgpu.WGPU_LIMIT_U32_UNDEFINED,
    max_color_attachments: u32 = wgpu.WGPU_LIMIT_U32_UNDEFINED,
    max_color_attachment_bytes_per_sample: u32 = wgpu.WGPU_LIMIT_U32_UNDEFINED,
    max_compute_workgroup_storage_size: u32 = wgpu.WGPU_LIMIT_U32_UNDEFINED,
    max_compute_invocations_per_workgroup: u32 = wgpu.WGPU_LIMIT_U32_UNDEFINED,
    max_compute_workgroup_size_x: u32 = wgpu.WGPU_LIMIT_U32_UNDEFINED,
    max_compute_workgroup_size_y: u32 = wgpu.WGPU_LIMIT_U32_UNDEFINED,
    max_compute_workgroup_size_z: u32 = wgpu.WGPU_LIMIT_U32_UNDEFINED,
    max_compute_workgroups_per_dimension: u32 = wgpu.WGPU_LIMIT_U32_UNDEFINED,
    max_immediate_size: u32 = wgpu.WGPU_LIMIT_U32_UNDEFINED,
};

/// Can be chained in PipelineLayoutDescriptor
pub const PipelineLayoutPixelLocalStorage = extern struct {
    chain: ChainedStruct,
    total_pixel_local_storage_size: u64,
    storage_attachment_count: usize = 0,
    storage_attachments: ?[*]const PipelineLayoutStorageAttachment = null,
};

pub const RenderPassColorAttachment = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    view: ?TextureView = null,
    depth_slice: u32 = wgpu.WGPU_DEPTH_SLICE_UNDEFINED,
    resolve_target: ?TextureView = null,
    load_op: LoadOp = .undefined,
    store_op: StoreOp = .undefined,
    clear_value: Color = .{},
};

/// Can be chained in RenderPassDescriptor
pub const RenderPassRenderAreaRect = extern struct {
    chain: ChainedStruct,
    origin: Origin2D,
    size: Extent2D,
};

pub const RenderPassStorageAttachment = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    offset: u64,
    storage: TextureView,
    load_op: LoadOp,
    store_op: StoreOp,
    clear_value: Color,
};

pub const RequestAdapterOptions = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    feature_level: FeatureLevel = .undefined,
    power_preference: PowerPreference = .undefined,
    force_fallback_adapter: Bool = .false,
    backend_type: BackendType = .undefined,
    compatible_surface: ?Surface = null,
};

pub const SamplerDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: StringView = .{},
    address_mode_u: AddressMode,
    address_mode_v: AddressMode,
    address_mode_w: AddressMode,
    mag_filter: FilterMode,
    min_filter: FilterMode,
    mipmap_filter: MipmapFilterMode,
    lod_min_clamp: f32,
    lod_max_clamp: f32,
    compare: CompareFunction,
    max_anisotropy: u16,
};

pub const ShaderModuleDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: StringView = .{},
};

pub const SharedBufferMemoryDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: StringView = .{},
};

pub const SharedFenceDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: StringView = .{},
};

pub const SharedFenceExportInfo = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    type: SharedFenceType,
};

/// Can be chained in SharedTextureMemoryProperties
pub const SharedTextureMemoryAHardwareBufferProperties = extern struct {
    chain: ChainedStruct,
    y_cb_cr_info: YCbCrVkDescriptor,
};

pub const SharedTextureMemoryBeginAccessDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    concurrent_read: Bool,
    initialized: Bool,
    fence_count: usize = 0,
    fences: ?[*]const SharedFence = null,
    signaled_values: ?[*]const u64 = null,
};

/// Can be chained in SharedTextureMemoryDescriptor
pub const SharedTextureMemoryDmaBufDescriptor = extern struct {
    chain: ChainedStruct,
    size: Extent3D,
    drm_format: u32,
    drm_modifier: u64,
    plane_count: usize = 0,
    planes: ?[*]const SharedTextureMemoryDmaBufPlane = null,
};

/// Can be chained in SharedTextureMemoryEndAccessState
pub const SharedTextureMemoryMetalEndAccessState = extern struct {
    chain: ChainedStruct,
    commands_scheduled_future: Future,
};

pub const SurfaceDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: StringView = .{},
};

pub const TexelCopyBufferInfo = extern struct {
    layout: TexelCopyBufferLayout,
    buffer: Buffer,
};

pub const TexelCopyTextureInfo = extern struct {
    texture: Texture,
    mip_level: u32,
    origin: Origin3D,
    aspect: TextureAspect,
};

/// Can be chained in TextureViewDescriptor
pub const TextureComponentSwizzleDescriptor = extern struct {
    chain: ChainedStruct,
    swizzle: TextureComponentSwizzle,
};

pub const TextureDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: StringView = .{},
    usage: TextureUsage,
    dimension: TextureDimension,
    size: Extent3D,
    format: TextureFormat,
    mip_level_count: u32,
    sample_count: u32,
    view_format_count: usize = 0,
    view_formats: ?[*]const TextureFormat = null,
};

pub const VertexBufferLayout = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    step_mode: VertexStepMode = .undefined,
    array_stride: u64,
    attribute_count: usize = 0,
    attributes: ?[*]const VertexAttribute = null,
};

pub const AdapterInfo = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    vendor: StringView = .{},
    architecture: StringView = .{},
    device: StringView = .{},
    description: StringView = .{},
    backend_type: BackendType = .undefined,
    adapter_type: AdapterType = .unknown,
    vendor_id: u32 = 0,
    device_id: u32 = 0,
    subgroup_min_size: u32 = 0,
    subgroup_max_size: u32 = 0,

    pub fn freeMembers(adapter_info: AdapterInfo) void {
        return wgpuAdapterInfoFreeMembers(adapter_info);
    }
};

pub const BindGroupDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: StringView = .{},
    layout: BindGroupLayout,
    entry_count: usize = 0,
    entries: ?[*]const BindGroupEntry = null,
};

pub const BindGroupLayoutDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: StringView = .{},
    entry_count: usize = 0,
    entries: ?[*]const BindGroupLayoutEntry = null,
};

pub const ColorTargetState = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    format: TextureFormat = .undefined,
    blend: ?*const BlendState = null,
    write_mask: ColorWriteMask = .all,
};

pub const CompilationInfo = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    message_count: usize,
    messages: ?[*]const CompilationMessage,
};

pub const ComputePipelineDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: StringView = .{},
    layout: ?PipelineLayout,
    compute: ComputeState,
};

pub const DawnFormatCapabilities = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
};

pub const DeviceDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: StringView = .{},
    required_feature_count: usize = 0,
    required_features: ?[*]const FeatureName = null,
    required_limits: ?*const Limits = null,
    default_queue: QueueDescriptor = .{},
    device_lost_callback_info: DeviceLostCallbackInfo = .{},
    uncaptured_error_callback_info: UncapturedErrorCallbackInfo = .{},
};

pub const PipelineLayoutDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: StringView = .{},
    bind_group_layout_count: usize,
    bind_group_layouts: ?[*]const BindGroupLayout,
    immediate_size: u32 = 0,
};

/// Can be chained in RenderPassDescriptor
pub const RenderPassPixelLocalStorage = extern struct {
    chain: ChainedStruct,
    total_pixel_local_storage_size: u64,
    storage_attachment_count: usize = 0,
    storage_attachments: ?[*]const RenderPassStorageAttachment = null,
};

pub const SharedTextureMemoryDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: StringView = .{},
};

pub const SharedTextureMemoryEndAccessState = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    initialized: Bool,
    fence_count: usize = 0,
    fences: ?[*]const SharedFence = null,
    signaled_values: ?[*]const u64 = null,

    pub fn freeMembers(shared_texture_memory_end_access_state: SharedTextureMemoryEndAccessState) void {
        return wgpuSharedTextureMemoryEndAccessStateFreeMembers(shared_texture_memory_end_access_state);
    }
};

pub const SharedTextureMemoryProperties = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    usage: TextureUsage,
    size: Extent3D,
    format: TextureFormat,
};

pub const TextureViewDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: StringView = .{},
    format: TextureFormat = .undefined,
    dimension: TextureViewDimension = .undefined,
    base_mip_level: u32 = 0,
    mip_level_count: u32 = wgpu.WGPU_MIP_LEVEL_COUNT_UNDEFINED,
    base_array_layer: u32 = 0,
    array_layer_count: u32 = wgpu.WGPU_ARRAY_LAYER_COUNT_UNDEFINED,
    aspect: TextureAspect = .undefined,
    usage: TextureUsage = .none,
};

pub const VertexState = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    module: ShaderModule,
    entry_point: StringView = .{},
    constant_count: usize = 0,
    constants: ?[*]const ConstantEntry = null,
    buffer_count: usize = 0,
    buffers: ?[*]const VertexBufferLayout = null,
};

pub const FragmentState = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    module: ShaderModule,
    entry_point: StringView = .{},
    constant_count: usize = 0,
    constants: ?[*]const ConstantEntry = null,
    target_count: usize = 0,
    targets: ?[*]const ColorTargetState = null,
};

pub const RenderPassDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: StringView = .{},
    color_attachment_count: usize,
    color_attachments: ?[*]const RenderPassColorAttachment,
    depth_stencil_attachment: ?*const RenderPassDepthStencilAttachment = null,
    occlusion_query_set: ?QuerySet = null,
    timestamp_writes: ?*const PassTimestampWrites = null,
};

pub const RenderPipelineDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: StringView = .{},
    layout: ?PipelineLayout = null,
    vertex: VertexState,
    primitive: PrimitiveState,
    depth_stencil: ?*const DepthStencilState = null,
    multisample: MultisampleState = .{},
    fragment: ?*const FragmentState = null,
};

//
// Functions
//

pub extern fn wgpuCreateInstance(descriptor: ?*const InstanceDescriptor) Instance;
pub extern fn wgpuGetInstanceFeatures(features: *SupportedInstanceFeatures) void;
pub extern fn wgpuGetInstanceLimits(limits: *InstanceLimits) Status;
pub extern fn wgpuHasInstanceFeature(feature: InstanceFeatureName) Bool;
pub extern fn wgpuGetProcAddress(procName: StringView) Proc;

// Methods of Adapter
pub extern fn wgpuAdapterCreateDevice(adapter: Adapter, descriptor: ?*const DeviceDescriptor) Device;
pub extern fn wgpuAdapterGetFeatures(adapter: Adapter, features: *SupportedFeatures) void;
pub extern fn wgpuAdapterGetFormatCapabilities(adapter: Adapter, format: TextureFormat, capabilities: *DawnFormatCapabilities) Status;
pub extern fn wgpuAdapterGetInfo(adapter: Adapter, info: *AdapterInfo) Status;
pub extern fn wgpuAdapterGetInstance(adapter: Adapter) Instance;
pub extern fn wgpuAdapterGetLimits(adapter: Adapter, limits: *Limits) Status;
pub extern fn wgpuAdapterHasFeature(adapter: Adapter, feature: FeatureName) Bool;
pub extern fn wgpuAdapterRequestDevice(adapter: Adapter, descriptor: ?*const DeviceDescriptor, callback_info: RequestDeviceCallbackInfo) Future;
pub extern fn wgpuAdapterAddRef(adapter: Adapter) void;
pub extern fn wgpuAdapterRelease(adapter: Adapter) void;

// Methods of AdapterInfo
pub extern fn wgpuAdapterInfoFreeMembers(adapter_info: AdapterInfo) void;

// Methods of AdapterPropertiesMemoryHeaps
pub extern fn wgpuAdapterPropertiesMemoryHeapsFreeMembers(adapter_properties_memory_heaps: AdapterPropertiesMemoryHeaps) void;

// Methods of AdapterPropertiesSubgroupMatrixConfigs
pub extern fn wgpuAdapterPropertiesSubgroupMatrixConfigsFreeMembers(adapter_properties_subgroup_matrix_configs: AdapterPropertiesSubgroupMatrixConfigs) void;

// Methods of BindGroup
pub extern fn wgpuBindGroupSetLabel(bind_group: BindGroup, label: StringView) void;
pub extern fn wgpuBindGroupAddRef(bind_group: BindGroup) void;
pub extern fn wgpuBindGroupRelease(bind_group: BindGroup) void;

// Methods of BindGroupLayout
pub extern fn wgpuBindGroupLayoutSetLabel(bind_group_layout: BindGroupLayout, label: StringView) void;
pub extern fn wgpuBindGroupLayoutAddRef(bind_group_layout: BindGroupLayout) void;
pub extern fn wgpuBindGroupLayoutRelease(bind_group_layout: BindGroupLayout) void;

// Methods of Buffer
pub extern fn wgpuBufferCreateTexelView(buffer: Buffer, descriptor: *const TexelBufferViewDescriptor) TexelBufferView;
pub extern fn wgpuBufferDestroy(buffer: Buffer) void;
pub extern fn wgpuBufferGetConstMappedRange(buffer: Buffer, offset: usize, size: usize) ?*const anyopaque;
pub extern fn wgpuBufferGetMappedRange(buffer: Buffer, offset: usize, size: usize) ?*anyopaque;
pub extern fn wgpuBufferGetMapState(buffer: Buffer) BufferMapState;
pub extern fn wgpuBufferGetSize(buffer: Buffer) u64;
pub extern fn wgpuBufferGetUsage(buffer: Buffer) BufferUsage;
pub extern fn wgpuBufferMapAsync(buffer: Buffer, mode: MapMode, offset: usize, size: usize, callback_info: BufferMapCallbackInfo) Future;
pub extern fn wgpuBufferReadMappedRange(buffer: Buffer, offset: usize, data: ?*anyopaque, size: usize) Status;
pub extern fn wgpuBufferSetLabel(buffer: Buffer, label: StringView) void;
pub extern fn wgpuBufferUnmap(buffer: Buffer) void;
pub extern fn wgpuBufferWriteMappedRange(buffer: Buffer, offset: usize, data: ?*const anyopaque, size: usize) Status;
pub extern fn wgpuBufferAddRef(buffer: Buffer) void;
pub extern fn wgpuBufferRelease(buffer: Buffer) void;

// Methods of CommandBuffer
pub extern fn wgpuCommandBufferSetLabel(command_buffer: CommandBuffer, label: StringView) void;
pub extern fn wgpuCommandBufferAddRef(command_buffer: CommandBuffer) void;
pub extern fn wgpuCommandBufferRelease(command_buffer: CommandBuffer) void;

// Methods of CommandEncoder
pub extern fn wgpuCommandEncoderBeginComputePass(command_encoder: CommandEncoder, descriptor: ?*const ComputePassDescriptor) ComputePassEncoder;
pub extern fn wgpuCommandEncoderBeginRenderPass(command_encoder: CommandEncoder, descriptor: *const RenderPassDescriptor) RenderPassEncoder;
pub extern fn wgpuCommandEncoderClearBuffer(command_encoder: CommandEncoder, buffer: Buffer, offset: u64, size: u64) void;
pub extern fn wgpuCommandEncoderCopyBufferToBuffer(command_encoder: CommandEncoder, source: Buffer, sourceOffset: u64, destination: Buffer, destination_offset: u64, size: u64) void;
pub extern fn wgpuCommandEncoderCopyBufferToTexture(command_encoder: CommandEncoder, source: *const TexelCopyBufferInfo, destination: *const TexelCopyTextureInfo, copy_size: *const Extent3D) void;
pub extern fn wgpuCommandEncoderCopyTextureToBuffer(command_encoder: CommandEncoder, source: *const TexelCopyTextureInfo, destination: *const TexelCopyBufferInfo, copy_size: *const Extent3D) void;
pub extern fn wgpuCommandEncoderCopyTextureToTexture(command_encoder: CommandEncoder, source: *const TexelCopyTextureInfo, destination: *const TexelCopyTextureInfo, copy_size: *const Extent3D) void;
pub extern fn wgpuCommandEncoderFinish(command_encoder: CommandEncoder, descriptor: ?*const CommandBufferDescriptor) CommandBuffer;
pub extern fn wgpuCommandEncoderInjectValidationError(command_encoder: CommandEncoder, message: StringView) void;
pub extern fn wgpuCommandEncoderInsertDebugMarker(command_encoder: CommandEncoder, marker_label: StringView) void;
pub extern fn wgpuCommandEncoderPopDebugGroup(command_encoder: CommandEncoder) void;
pub extern fn wgpuCommandEncoderPushDebugGroup(command_encoder: CommandEncoder, group_label: StringView) void;
pub extern fn wgpuCommandEncoderResolveQuerySet(command_encoder: CommandEncoder, query_set: QuerySet, first_query: u32, query_count: u32, destination: Buffer, destination_offset: u64) void;
pub extern fn wgpuCommandEncoderSetLabel(command_encoder: CommandEncoder, label: StringView) void;
pub extern fn wgpuCommandEncoderWriteBuffer(command_encoder: CommandEncoder, buffer: Buffer, buffer_offset: u64, data: *const u8, size: u64) void;
pub extern fn wgpuCommandEncoderWriteTimestamp(command_encoder: CommandEncoder, query_set: QuerySet, query_index: u32) void;
pub extern fn wgpuCommandEncoderAddRef(command_encoder: CommandEncoder) void;
pub extern fn wgpuCommandEncoderRelease(command_encoder: CommandEncoder) void;

// Methods of ComputePassEncoder
pub extern fn wgpuComputePassEncoderDispatchWorkgroups(compute_pass_encoder: ComputePassEncoder, workgroup_count_x: u32, workgroup_count_y: u32, workgroup_count_z: u32) void;
pub extern fn wgpuComputePassEncoderDispatchWorkgroupsIndirect(compute_pass_encoder: ComputePassEncoder, indirect_buffer: Buffer, indirect_offset: u64) void;
pub extern fn wgpuComputePassEncoderEnd(compute_pass_encoder: ComputePassEncoder) void;
pub extern fn wgpuComputePassEncoderInsertDebugMarker(compute_pass_encoder: ComputePassEncoder, marker_label: StringView) void;
pub extern fn wgpuComputePassEncoderPopDebugGroup(compute_pass_encoder: ComputePassEncoder) void;
pub extern fn wgpuComputePassEncoderPushDebugGroup(compute_pass_encoder: ComputePassEncoder, group_label: StringView) void;
pub extern fn wgpuComputePassEncoderSetBindGroup(compute_pass_encoder: ComputePassEncoder, group_index: u32, group: ?BindGroup, dynamic_offset_count: usize, dynamic_offsets: ?[*]const u32) void;
pub extern fn wgpuComputePassEncoderSetImmediates(compute_pass_encoder: ComputePassEncoder, offset: u32, data: ?*const anyopaque, size: usize) void;
pub extern fn wgpuComputePassEncoderSetLabel(compute_pass_encoder: ComputePassEncoder, label: StringView) void;
pub extern fn wgpuComputePassEncoderSetPipeline(compute_pass_encoder: ComputePassEncoder, pipeline: ComputePipeline) void;
pub extern fn wgpuComputePassEncoderSetResourceTable(compute_pass_encoder: ComputePassEncoder, table: ?ResourceTable) void;
pub extern fn wgpuComputePassEncoderWriteTimestamp(compute_pass_encoder: ComputePassEncoder, query_set: QuerySet, query_index: u32) void;
pub extern fn wgpuComputePassEncoderAddRef(compute_pass_encoder: ComputePassEncoder) void;
pub extern fn wgpuComputePassEncoderRelease(compute_pass_encoder: ComputePassEncoder) void;

// Methods of ComputePipeline
pub extern fn wgpuComputePipelineGetBindGroupLayout(compute_pipeline: ComputePipeline, group_index: u32) BindGroupLayout;
pub extern fn wgpuComputePipelineSetLabel(compute_pipeline: ComputePipeline, label: StringView) void;
pub extern fn wgpuComputePipelineAddRef(compute_pipeline: ComputePipeline) void;
pub extern fn wgpuComputePipelineRelease(compute_pipeline: ComputePipeline) void;

// Methods of DawnDrmFormatCapabilities
pub extern fn wgpuDawnDrmFormatCapabilitiesFreeMembers(dawn_drm_format_capabilities: DawnDrmFormatCapabilities) void;

// Methods of Device
pub extern fn wgpuDeviceCreateBindGroup(device: Device, descriptor: *const BindGroupDescriptor) BindGroup;
pub extern fn wgpuDeviceCreateBindGroupLayout(device: Device, descriptor: *const BindGroupLayoutDescriptor) BindGroupLayout;
pub extern fn wgpuDeviceCreateBuffer(device: Device, descriptor: *const BufferDescriptor) ?Buffer;
pub extern fn wgpuDeviceCreateCommandEncoder(device: Device, descriptor: ?*const CommandEncoderDescriptor) CommandEncoder;
pub extern fn wgpuDeviceCreateComputePipeline(device: Device, descriptor: *const ComputePipelineDescriptor) ComputePipeline;
pub extern fn wgpuDeviceCreateComputePipelineAsync(device: Device, descriptor: *const ComputePipelineDescriptor, callback_info: CreateComputePipelineAsyncCallbackInfo) Future;
pub extern fn wgpuDeviceCreateErrorBuffer(device: Device, descriptor: *const BufferDescriptor) Buffer;
pub extern fn wgpuDeviceCreateErrorExternalTexture(device: Device) ExternalTexture;
pub extern fn wgpuDeviceCreateErrorShaderModule(device: Device, descriptor: *const ShaderModuleDescriptor, error_message: StringView) ShaderModule;
pub extern fn wgpuDeviceCreateErrorTexture(device: Device, descriptor: *const TextureDescriptor) Texture;
pub extern fn wgpuDeviceCreateExternalTexture(device: Device, external_texture_descriptor: *const ExternalTextureDescriptor) ExternalTexture;
pub extern fn wgpuDeviceCreatePipelineLayout(device: Device, descriptor: *const PipelineLayoutDescriptor) PipelineLayout;
pub extern fn wgpuDeviceCreateQuerySet(device: Device, descriptor: *const QuerySetDescriptor) QuerySet;
pub extern fn wgpuDeviceCreateRenderBundleEncoder(device: Device, descriptor: *const RenderBundleEncoderDescriptor) RenderBundleEncoder;
pub extern fn wgpuDeviceCreateRenderPipeline(device: Device, descriptor: *const RenderPipelineDescriptor) RenderPipeline;
pub extern fn wgpuDeviceCreateRenderPipelineAsync(device: Device, descriptor: *const RenderPipelineDescriptor, callback_info: CreateRenderPipelineAsyncCallbackInfo) Future;
pub extern fn wgpuDeviceCreateResourceTable(device: Device, descriptor: *const ResourceTableDescriptor) ResourceTable;
pub extern fn wgpuDeviceCreateSampler(device: Device, descriptor: ?*const SamplerDescriptor) Sampler;
pub extern fn wgpuDeviceCreateShaderModule(device: Device, descriptor: *const ShaderModuleDescriptor) ShaderModule;
pub extern fn wgpuDeviceCreateTexture(device: Device, descriptor: *const TextureDescriptor) Texture;
pub extern fn wgpuDeviceDestroy(device: Device) void;
pub extern fn wgpuDeviceForceLoss(device: Device, type: DeviceLostReason, message: StringView) void;
pub extern fn wgpuDeviceGetAdapter(device: Device) Adapter;
pub extern fn wgpuDeviceGetAdapterInfo(device: Device, adapter_info: *AdapterInfo) Status;
pub extern fn wgpuDeviceGetAHardwareBufferProperties(device: Device, handle: ?*anyopaque, properties: *AHardwareBufferProperties) Status;
pub extern fn wgpuDeviceGetFeatures(device: Device, features: *SupportedFeatures) void;
pub extern fn wgpuDeviceGetLimits(device: Device, limits: *Limits) Status;
pub extern fn wgpuDeviceGetLostFuture(device: Device) Future;
pub extern fn wgpuDeviceGetQueue(device: Device) Queue;
pub extern fn wgpuDeviceHasFeature(device: Device, feature: FeatureName) Bool;
pub extern fn wgpuDeviceImportSharedBufferMemory(device: Device, descriptor: *const SharedBufferMemoryDescriptor) SharedBufferMemory;
pub extern fn wgpuDeviceImportSharedFence(device: Device, descriptor: *const SharedFenceDescriptor) SharedFence;
pub extern fn wgpuDeviceImportSharedTextureMemory(device: Device, descriptor: *const SharedTextureMemoryDescriptor) SharedTextureMemory;
pub extern fn wgpuDeviceInjectError(device: Device, type: ErrorType, message: StringView) void;
pub extern fn wgpuDevicePopErrorScope(device: Device, callback_info: PopErrorScopeCallbackInfo) Future;
pub extern fn wgpuDevicePushErrorScope(device: Device, filter: ErrorFilter) void;
pub extern fn wgpuDeviceSetLabel(device: Device, label: StringView) void;
pub extern fn wgpuDeviceSetLoggingCallback(device: Device, callback_info: LoggingCallbackInfo) void;
pub extern fn wgpuDeviceTick(device: Device) void;
pub extern fn wgpuDeviceValidateTextureDescriptor(device: Device, descriptor: *const TextureDescriptor) void;
pub extern fn wgpuDeviceAddRef(device: Device) void;
pub extern fn wgpuDeviceRelease(device: Device) void;

// Methods of ExternalTexture
pub extern fn wgpuExternalTextureDestroy(external_texture: ExternalTexture) void;
pub extern fn wgpuExternalTextureExpire(external_texture: ExternalTexture) void;
pub extern fn wgpuExternalTextureRefresh(external_texture: ExternalTexture) void;
pub extern fn wgpuExternalTextureSetLabel(external_texture: ExternalTexture, label: StringView) void;
pub extern fn wgpuExternalTextureAddRef(external_texture: ExternalTexture) void;
pub extern fn wgpuExternalTextureRelease(external_texture: ExternalTexture) void;

// Methods of Instance
pub extern fn wgpuInstanceCreateSurface(instance: Instance, descriptor: *const SurfaceDescriptor) Surface;
pub extern fn wgpuInstanceGetWGSLLanguageFeatures(instance: Instance, features: *SupportedWGSLLanguageFeatures) void;
pub extern fn wgpuInstanceHasWGSLLanguageFeature(instance: Instance, feature: WGSLLanguageFeatureName) Bool;
pub extern fn wgpuInstanceProcessEvents(instance: Instance) void;
pub extern fn wgpuInstanceRequestAdapter(instance: Instance, options: ?*const RequestAdapterOptions, callback_info: RequestAdapterCallbackInfo) Future;
pub extern fn wgpuInstanceWaitAny(instance: Instance, future_count: usize, futures: ?[*]FutureWaitInfo, timeout_ns: u64) WaitStatus;
pub extern fn wgpuInstanceAddRef(instance: Instance) void;
pub extern fn wgpuInstanceRelease(instance: Instance) void;

// Methods of PipelineLayout
pub extern fn wgpuPipelineLayoutSetLabel(pipeline_layout: PipelineLayout, label: StringView) void;
pub extern fn wgpuPipelineLayoutAddRef(pipeline_layout: PipelineLayout) void;
pub extern fn wgpuPipelineLayoutRelease(pipeline_layout: PipelineLayout) void;

// Methods of QuerySet
pub extern fn wgpuQuerySetDestroy(query_set: QuerySet) void;
pub extern fn wgpuQuerySetGetCount(query_set: QuerySet) u32;
pub extern fn wgpuQuerySetGetType(query_set: QuerySet) QueryType;
pub extern fn wgpuQuerySetSetLabel(query_set: QuerySet, label: StringView) void;
pub extern fn wgpuQuerySetAddRef(query_set: QuerySet) void;
pub extern fn wgpuQuerySetRelease(query_set: QuerySet) void;

// Methods of Queue
pub extern fn wgpuQueueCopyExternalTextureForBrowser(queue: Queue, source: *const ImageCopyExternalTexture, destination: *const TexelCopyTextureInfo, copy_size: *const Extent3D, options: *const CopyTextureForBrowserOptions) void;
pub extern fn wgpuQueueCopyTextureForBrowser(queue: Queue, source: *const TexelCopyTextureInfo, destination: *const TexelCopyTextureInfo, copy_size: *const Extent3D, options: *const CopyTextureForBrowserOptions) void;
pub extern fn wgpuQueueOnSubmittedWorkDone(queue: Queue, callback_info: QueueWorkDoneCallbackInfo) Future;
pub extern fn wgpuQueueSetLabel(queue: Queue, label: StringView) void;
pub extern fn wgpuQueueSubmit(queue: Queue, command_count: usize, commands: ?[*]const CommandBuffer) void;
pub extern fn wgpuQueueWriteBuffer(queue: Queue, buffer: Buffer, buffer_offset: u64, data: ?*const anyopaque, size: usize) void;
pub extern fn wgpuQueueWriteTexture(queue: Queue, destination: *const TexelCopyTextureInfo, data: ?*const anyopaque, data_size: usize, data_layout: *const TexelCopyBufferLayout, write_size: *const Extent3D) void;
pub extern fn wgpuQueueAddRef(queue: Queue) void;
pub extern fn wgpuQueueRelease(queue: Queue) void;

// Methods of RenderBundle
pub extern fn wgpuRenderBundleSetLabel(render_bundle: RenderBundle, label: StringView) void;
pub extern fn wgpuRenderBundleAddRef(render_bundle: RenderBundle) void;
pub extern fn wgpuRenderBundleRelease(render_bundle: RenderBundle) void;

// Methods of RenderBundleEncoder
pub extern fn wgpuRenderBundleEncoderDraw(render_bundle_encoder: RenderBundleEncoder, vertex_count: u32, instance_count: u32, first_vertex: u32, first_instance: u32) void;
pub extern fn wgpuRenderBundleEncoderDrawIndexed(render_bundle_encoder: RenderBundleEncoder, index_count: u32, instance_count: u32, first_index: u32, base_vertex: i32, first_instance: u32) void;
pub extern fn wgpuRenderBundleEncoderDrawIndexedIndirect(render_bundle_encoder: RenderBundleEncoder, indirect_buffer: Buffer, indirect_offset: u64) void;
pub extern fn wgpuRenderBundleEncoderDrawIndirect(render_bundle_encoder: RenderBundleEncoder, indirect_buffer: Buffer, indirect_offset: u64) void;
pub extern fn wgpuRenderBundleEncoderFinish(render_bundle_encoder: RenderBundleEncoder, descriptor: ?*const RenderBundleDescriptor) RenderBundle;
pub extern fn wgpuRenderBundleEncoderInsertDebugMarker(render_bundle_encoder: RenderBundleEncoder, marker_label: StringView) void;
pub extern fn wgpuRenderBundleEncoderPopDebugGroup(render_bundle_encoder: RenderBundleEncoder) void;
pub extern fn wgpuRenderBundleEncoderPushDebugGroup(render_bundle_encoder: RenderBundleEncoder, group_label: StringView) void;
pub extern fn wgpuRenderBundleEncoderSetBindGroup(render_bundle_encoder: RenderBundleEncoder, group_index: u32, group: ?BindGroup, dynamic_offset_count: usize, dynamic_offsets: ?[*]const u32) void;
pub extern fn wgpuRenderBundleEncoderSetImmediates(render_bundle_encoder: RenderBundleEncoder, offset: u32, data: ?*const anyopaque, size: usize) void;
pub extern fn wgpuRenderBundleEncoderSetIndexBuffer(render_bundle_encoder: RenderBundleEncoder, buffer: Buffer, format: IndexFormat, offset: u64, size: u64) void;
pub extern fn wgpuRenderBundleEncoderSetLabel(render_bundle_encoder: RenderBundleEncoder, label: StringView) void;
pub extern fn wgpuRenderBundleEncoderSetPipeline(render_bundle_encoder: RenderBundleEncoder, pipeline: RenderPipeline) void;
pub extern fn wgpuRenderBundleEncoderSetResourceTable(render_bundle_encoder: RenderBundleEncoder, table: ?ResourceTable) void;
pub extern fn wgpuRenderBundleEncoderSetVertexBuffer(render_bundle_encoder: RenderBundleEncoder, slot: u32, buffer: ?Buffer, offset: u64, size: u64) void;
pub extern fn wgpuRenderBundleEncoderAddRef(render_bundle_encoder: RenderBundleEncoder) void;
pub extern fn wgpuRenderBundleEncoderRelease(render_bundle_encoder: RenderBundleEncoder) void;

// Methods of RenderPassEncoder
pub extern fn wgpuRenderPassEncoderBeginOcclusionQuery(render_pass_encoder: RenderPassEncoder, query_index: u32) void;
pub extern fn wgpuRenderPassEncoderDraw(render_pass_encoder: RenderPassEncoder, vertex_count: u32, instance_count: u32, first_vertex: u32, first_instance: u32) void;
pub extern fn wgpuRenderPassEncoderDrawIndexed(render_pass_encoder: RenderPassEncoder, index_count: u32, instance_count: u32, first_index: u32, base_vertex: i32, first_instance: u32) void;
pub extern fn wgpuRenderPassEncoderDrawIndexedIndirect(render_pass_encoder: RenderPassEncoder, indirect_buffer: Buffer, indirect_offset: u64) void;
pub extern fn wgpuRenderPassEncoderDrawIndirect(render_pass_encoder: RenderPassEncoder, indirect_buffer: Buffer, indirect_offset: u64) void;
pub extern fn wgpuRenderPassEncoderEnd(render_pass_encoder: RenderPassEncoder) void;
pub extern fn wgpuRenderPassEncoderEndOcclusionQuery(render_pass_encoder: RenderPassEncoder) void;
pub extern fn wgpuRenderPassEncoderExecuteBundles(render_pass_encoder: RenderPassEncoder, bundle_count: usize, bundles: ?[*]const RenderBundle) void;
pub extern fn wgpuRenderPassEncoderInsertDebugMarker(render_pass_encoder: RenderPassEncoder, marker_label: StringView) void;
pub extern fn wgpuRenderPassEncoderMultiDrawIndexedIndirect(render_pass_encoder: RenderPassEncoder, indirect_buffer: Buffer, indirect_offset: u64, max_draw_count: u32, draw_count_buffer: ?Buffer, draw_count_buffer_offset: u64) void;
pub extern fn wgpuRenderPassEncoderMultiDrawIndirect(render_pass_encoder: RenderPassEncoder, indirect_buffer: Buffer, indirect_offset: u64, max_draw_count: u32, draw_count_buffer: ?Buffer, draw_count_buffer_offset: u64) void;
pub extern fn wgpuRenderPassEncoderPixelLocalStorageBarrier(render_pass_encoder: RenderPassEncoder) void;
pub extern fn wgpuRenderPassEncoderPopDebugGroup(render_pass_encoder: RenderPassEncoder) void;
pub extern fn wgpuRenderPassEncoderPushDebugGroup(render_pass_encoder: RenderPassEncoder, group_label: StringView) void;
pub extern fn wgpuRenderPassEncoderSetBindGroup(render_pass_encoder: RenderPassEncoder, group_index: u32, group: ?BindGroup, dynamic_offset_count: usize, dynamic_offsets: ?[*]const u32) void;
pub extern fn wgpuRenderPassEncoderSetBlendConstant(render_pass_encoder: RenderPassEncoder, color: *const Color) void;
pub extern fn wgpuRenderPassEncoderSetImmediates(render_pass_encoder: RenderPassEncoder, offset: u32, data: ?*const anyopaque, size: usize) void;
pub extern fn wgpuRenderPassEncoderSetIndexBuffer(render_pass_encoder: RenderPassEncoder, buffer: Buffer, format: IndexFormat, offset: u64, size: u64) void;
pub extern fn wgpuRenderPassEncoderSetLabel(render_pass_encoder: RenderPassEncoder, label: StringView) void;
pub extern fn wgpuRenderPassEncoderSetPipeline(render_pass_encoder: RenderPassEncoder, pipeline: RenderPipeline) void;
pub extern fn wgpuRenderPassEncoderSetResourceTable(render_pass_encoder: RenderPassEncoder, table: ?ResourceTable) void;
pub extern fn wgpuRenderPassEncoderSetScissorRect(render_pass_encoder: RenderPassEncoder, x: u32, y: u32, width: u32, height: u32) void;
pub extern fn wgpuRenderPassEncoderSetStencilReference(render_pass_encoder: RenderPassEncoder, reference: u32) void;
pub extern fn wgpuRenderPassEncoderSetVertexBuffer(render_pass_encoder: RenderPassEncoder, slot: u32, buffer: ?Buffer, offset: u64, size: u64) void;
pub extern fn wgpuRenderPassEncoderSetViewport(render_pass_encoder: RenderPassEncoder, x: f32, y: f32, width: f32, height: f32, min_depth: f32, max_depth: f32) void;
pub extern fn wgpuRenderPassEncoderWriteTimestamp(render_pass_encoder: RenderPassEncoder, query_set: QuerySet, query_index: u32) void;
pub extern fn wgpuRenderPassEncoderAddRef(render_pass_encoder: RenderPassEncoder) void;
pub extern fn wgpuRenderPassEncoderRelease(render_pass_encoder: RenderPassEncoder) void;

// Methods of RenderPipeline
pub extern fn wgpuRenderPipelineGetBindGroupLayout(render_pipeline: RenderPipeline, group_index: u32) BindGroupLayout;
pub extern fn wgpuRenderPipelineSetLabel(render_pipeline: RenderPipeline, label: StringView) void;
pub extern fn wgpuRenderPipelineAddRef(render_pipeline: RenderPipeline) void;
pub extern fn wgpuRenderPipelineRelease(render_pipeline: RenderPipeline) void;

// Methods of ResourceTable
pub extern fn wgpuResourceTableDestroy(resource_table: ResourceTable) void;
pub extern fn wgpuResourceTableGetSize(resource_table: ResourceTable) u32;
pub extern fn wgpuResourceTableInsertBinding(resource_table: ResourceTable, resource: *const BindingResource) u32;
pub extern fn wgpuResourceTableRemoveBinding(resource_table: ResourceTable, slot: u32) Status;
pub extern fn wgpuResourceTableUpdate(resource_table: ResourceTable, slot: u32, resource: *const BindingResource) Status;
pub extern fn wgpuResourceTableAddRef(resource_table: ResourceTable) void;
pub extern fn wgpuResourceTableRelease(resource_table: ResourceTable) void;

// Methods of Sampler
pub extern fn wgpuSamplerSetLabel(sampler: Sampler, label: StringView) void;
pub extern fn wgpuSamplerAddRef(sampler: Sampler) void;
pub extern fn wgpuSamplerRelease(sampler: Sampler) void;

// Methods of ShaderModule
pub extern fn wgpuShaderModuleGetCompilationInfo(shader_module: ShaderModule, callback_info: CompilationInfoCallbackInfo) Future;
pub extern fn wgpuShaderModuleSetLabel(shaderModule: ShaderModule, label: StringView) void;
pub extern fn wgpuShaderModuleAddRef(shader_module: ShaderModule) void;
pub extern fn wgpuShaderModuleRelease(shader_module: ShaderModule) void;

// Methods of SharedBufferMemory
pub extern fn wgpuSharedBufferMemoryBeginAccess(shared_buffer_memory: SharedBufferMemory, buffer: Buffer, descriptor: *const SharedBufferMemoryBeginAccessDescriptor) Status;
pub extern fn wgpuSharedBufferMemoryCreateBuffer(shared_buffer_memory: SharedBufferMemory, descriptor: ?*const BufferDescriptor) Buffer;
pub extern fn wgpuSharedBufferMemoryEndAccess(shared_buffer_memory: SharedBufferMemory, buffer: Buffer, descriptor: *SharedBufferMemoryEndAccessState) Status;
pub extern fn wgpuSharedBufferMemoryGetProperties(shared_buffer_memory: SharedBufferMemory, properties: *SharedBufferMemoryProperties) Status;
pub extern fn wgpuSharedBufferMemoryIsDeviceLost(shared_buffer_memory: SharedBufferMemory) Bool;
pub extern fn wgpuSharedBufferMemorySetLabel(shared_buffer_memory: SharedBufferMemory, label: StringView) void;
pub extern fn wgpuSharedBufferMemoryAddRef(shared_buffer_memory: SharedBufferMemory) void;
pub extern fn wgpuSharedBufferMemoryRelease(shared_buffer_memory: SharedBufferMemory) void;

// Methods of SharedBufferMemoryEndAccessState
pub extern fn wgpuSharedBufferMemoryEndAccessStateFreeMembers(shared_buffer_memory_end_access_state: SharedBufferMemoryEndAccessState) void;

// Methods of SharedFence
pub extern fn wgpuSharedFenceExportInfo(shared_fence: SharedFence, info: *SharedFenceExportInfo) void;
pub extern fn wgpuSharedFenceSetLabel(shared_fence: SharedFence, label: StringView) void;
pub extern fn wgpuSharedFenceAddRef(shared_fence: SharedFence) void;
pub extern fn wgpuSharedFenceRelease(shared_fence: SharedFence) void;

// Methods of SharedTextureMemory
pub extern fn wgpuSharedTextureMemoryBeginAccess(shared_texture_memory: SharedTextureMemory, texture: Texture, descriptor: *const SharedTextureMemoryBeginAccessDescriptor) Status;
pub extern fn wgpuSharedTextureMemoryCreateTexture(shared_texture_memory: SharedTextureMemory, descriptor: ?*const TextureDescriptor) Texture;
pub extern fn wgpuSharedTextureMemoryEndAccess(shared_texture_memory: SharedTextureMemory, texture: Texture, descriptor: *SharedTextureMemoryEndAccessState) Status;
pub extern fn wgpuSharedTextureMemoryGetProperties(shared_texture_memory: SharedTextureMemory, properties: *SharedTextureMemoryProperties) Status;
pub extern fn wgpuSharedTextureMemoryIsDeviceLost(shared_texture_memory: SharedTextureMemory) Bool;
pub extern fn wgpuSharedTextureMemorySetLabel(shared_texture_memory: SharedTextureMemory, label: StringView) void;
pub extern fn wgpuSharedTextureMemoryAddRef(shared_texture_memory: SharedTextureMemory) void;
pub extern fn wgpuSharedTextureMemoryRelease(shared_texture_memory: SharedTextureMemory) void;

// Methods of SharedTextureMemoryEndAccessState
pub extern fn wgpuSharedTextureMemoryEndAccessStateFreeMembers(shared_texture_memory_end_access_state: SharedTextureMemoryEndAccessState) void;

// Methods of SupportedFeatures
pub extern fn wgpuSupportedFeaturesFreeMembers(supported_features: SupportedFeatures) void;

// Methods of SupportedInstanceFeatures
pub extern fn wgpuSupportedInstanceFeaturesFreeMembers(supported_instance_features: SupportedInstanceFeatures) void;

// Methods of SupportedWGSLLanguageFeatures
pub extern fn wgpuSupportedWGSLLanguageFeaturesFreeMembers(supported_wgsl_language_features: SupportedWGSLLanguageFeatures) void;

// Methods of Surface
pub extern fn wgpuSurfaceConfigure(surface: Surface, config: *const SurfaceConfiguration) void;
pub extern fn wgpuSurfaceGetCapabilities(surface: Surface, adapter: Adapter, capabilities: *SurfaceCapabilities) Status;
pub extern fn wgpuSurfaceGetCurrentTexture(surface: Surface, surface_texture: *SurfaceTexture) void;
pub extern fn wgpuSurfacePresent(surface: Surface) Status;
pub extern fn wgpuSurfaceSetLabel(surface: Surface, label: StringView) void;
pub extern fn wgpuSurfaceUnconfigure(surface: Surface) void;
pub extern fn wgpuSurfaceAddRef(surface: Surface) void;
pub extern fn wgpuSurfaceRelease(surface: Surface) void;

// Methods of SurfaceCapabilities
pub extern fn wgpuSurfaceCapabilitiesFreeMembers(surface_capabilities: SurfaceCapabilities) void;

// Methods of TexelBufferView
pub extern fn wgpuTexelBufferViewSetLabel(texel_buffer_view: TexelBufferView, label: StringView) void;
pub extern fn wgpuTexelBufferViewAddRef(texel_buffer_view: TexelBufferView) void;
pub extern fn wgpuTexelBufferViewRelease(texel_buffer_view: TexelBufferView) void;

// Methods of Texture
pub extern fn wgpuTextureCreateErrorView(texture: Texture, descriptor: ?*const TextureViewDescriptor) TextureView;
pub extern fn wgpuTextureCreateView(texture: Texture, descriptor: ?*const TextureViewDescriptor) TextureView;
pub extern fn wgpuTextureDestroy(texture: Texture) void;
pub extern fn wgpuTextureGetDepthOrArrayLayers(texture: Texture) u32;
pub extern fn wgpuTextureGetDimension(texture: Texture) TextureDimension;
pub extern fn wgpuTextureGetFormat(texture: Texture) TextureFormat;
pub extern fn wgpuTextureGetHeight(texture: Texture) u32;
pub extern fn wgpuTextureGetMipLevelCount(texture: Texture) u32;
pub extern fn wgpuTextureGetSampleCount(texture: Texture) u32;
pub extern fn wgpuTextureGetTextureBindingViewDimension(texture: Texture) TextureViewDimension;
pub extern fn wgpuTextureGetUsage(texture: Texture) TextureUsage;
pub extern fn wgpuTextureGetWidth(texture: Texture) u32;
pub extern fn wgpuTexturePin(texture: Texture, usage: TextureUsage) void;
pub extern fn wgpuTextureSetLabel(texture: Texture, label: StringView) void;
pub extern fn wgpuTextureSetOwnershipForMemoryDump(texture: Texture, owner_guid: u64) void;
pub extern fn wgpuTextureUnpin(texture: Texture) void;
pub extern fn wgpuTextureAddRef(texture: Texture) void;
pub extern fn wgpuTextureRelease(texture: Texture) void;

// Methods of TextureView
pub extern fn wgpuTextureViewSetLabel(texture_view: TextureView, label: StringView) void;
pub extern fn wgpuTextureViewAddRef(texture_view: TextureView) void;
pub extern fn wgpuTextureViewRelease(texture_view: TextureView) void;
