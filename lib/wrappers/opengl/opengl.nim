#
#
#            Nimrod's Runtime Library
#        (c) Copyright 2012 Andreas Rumpf
#
#    See the file "copying.txt", included in this
#    distribution, for details about the copyright.
#

## This module is a wrapper around `opengl`:idx:. If you define the symbol
## ``useGlew`` this wrapper does not use Nimrod's ``dynlib`` mechanism, 
## but `glew`:idx: instead. However, this shouldn't be necessary anymore; even
## extension loading for the different operating systems is handled here.
##
## You need to call ``loadExtensions`` after a rendering context has been
## created to load any extension proc that your code uses.

when defined(linux):
  import X, XLib, XUtil
elif defined(windows):
  import winlean, os

when defined(windows): 
  const 
    ogldll* = "OpenGL32.dll"
    gludll* = "GLU32.dll"
elif defined(macosx): 
  const 
    ogldll* = "libGL.dylib"
    gludll* = "libGLU.dylib"
else: 
  const 
    ogldll* = "libGL.so.1"
    gludll* = "libGLU.so.1"

when defined(useGlew):
  {.pragma: ogl, header: "<GL/glew.h>".}
  {.pragma: oglx, header: "<GL/glxew.h>".}
  {.pragma: wgl, header: "<GL/wglew.h>".}
  {.pragma: glu, dynlib: gludll.}
else:
  # quite complex ... thanks to extension support for various platforms:
  import dynlib
  
  let oglHandle = loadLib(ogldll)
  if isNil(oglHandle): quit("could not load: " & ogldll)
  
  when defined(windows):
    var wglGetProcAddress = cast[proc (s: cstring): pointer {.stdcall.}](
      symAddr(oglHandle, "wglGetProcAddress"))
  elif defined(linux):
    var glXGetProcAddress = cast[proc (s: cstring): pointer {.cdecl.}](
      symAddr(oglHandle, "glXGetProcAddress"))
    var glXGetProcAddressARB = cast[proc (s: cstring): pointer {.cdecl.}](
      symAddr(oglHandle, "glXGetProcAddressARB"))

  proc glGetProc(h: TLibHandle; procName: Cstring): Pointer =
    when defined(windows):
      result = symAddr(h, procname)
      if result != nil: return
      if not isNil(wglGetProcAddress): result = wglGetProcAddress(ProcName)
    elif defined(linux):
      if not isNil(glXGetProcAddress): result = glXGetProcAddress(ProcName)
      if result != nil: return 
      if not isNil(glXGetProcAddressARB): 
        result = glXGetProcAddressARB(ProcName)
        if result != nil: return
      result = symAddr(h, procname)
    else:
      result = symAddr(h, procName)
    if result == nil: raiseInvalidLibrary(procName)

  var gluHandle: TLibHandle
  
  proc gluGetProc(procname: Cstring): Pointer =
    if gluHandle == nil:
      gluHandle = loadLib(gludll)
      if gluHandle == nil: quit("could not load: " & gludll)
    result = glGetProc(gluHandle, procname)
  
  # undocumented 'dynlib' feature: the string literal is replaced by
  # the imported proc name:
  {.pragma: ogl, dynlib: glGetProc(oglHandle, "0").}
  {.pragma: oglx, dynlib: glGetProc(oglHandle, "0").}
  {.pragma: wgl, dynlib: glGetProc(oglHandle, "0").}
  {.pragma: glu, dynlib: gluGetProc("").}
  
  proc nimLoadProcs0() {.importc.}
  
  template loadExtensions*() =
    ## call this after your rendering context has been setup if you use
    ## extensions.
    bind nimLoadProcs0
    nimLoadProcs0()

#==============================================================================
#                                                                              
#       OpenGL 4.2 - Headertranslation                                         
#       Version 4.2a                                                           
#       Date : 26.11.2011                                                      
#                                                                              
#       Works with :                                                           
#        - Delphi 3 and up                                                     
#        - FreePascal (1.9.3 and up)                                           
#                                                                              
#==============================================================================
#                                                                              
#       Containts the translations of glext.h, gl_1_1.h, glu.h and weglext.h.  
#       It also contains some helperfunctions that were inspired by those      
#       found in Mike Lischke's OpenGL12.pas.                                  
#                                                                              
#       Copyright (C) DGL-OpenGL2-Portteam                                     
#       All Rights Reserved                                                    
#                                                                              
#       Obtained through:                                                      
#       Delphi OpenGL Community(DGL) - www.delphigl.com                        
#                                                                              
#       Converted and maintained by DGL's GL2.0-Team :                         
#         - Sascha Willems             - http://www.saschawillems.de           
#         - Steffen Xonna (Lossy eX)   - http://www.dev-center.de              
#       Additional input :                                                     
#         - Andrey Gruzdev (Mac OS X patch for XE2 / FPC)                      
#         - Lars Middendorf                                                    
#         - Martin Waldegger (Mars)                                            
#         - Benjamin Rosseaux (BeRo)   - http://www.0ok.de                     
#       Additional thanks:                                                     
#           sigsegv (libdl.so)                                                 
#                                                                              
#                                                                              
#==============================================================================
# You may retrieve the latest version of this file at the Delphi OpenGL        
# Community home page, located at http://www.delphigl.com/                     
#                                                                              
# The contents of this file are used with permission, subject to               
# the Mozilla Public License Version 1.1 (the "License"); you may      
# not use this file except in compliance with the License. You may             
# obtain a copy of the License at                                              
# http://www.mozilla.org/MPL/MPL-1.1.html                                      
#                                                                              
# Software distributed under the License is distributed on an                  
# "AS IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or               
# implied. See the License for the specific language governing                 
# rights and limitations under the License.                                    
#                                                                              
#==============================================================================
# History :                                                                    
# Version 1.0    Initial Release                                               
# Version 1.1    Added PPointer in Tpyessection for compatiblity with Delphi   
#                versions lower than 7                                    (SW) 
#                Added a function named RaiseLastOSError including a comment   
#                on how to make it run under Delphi versions lower than 7 (SW) 
#                Added some data types according to the GL-Syntax         (SW) 
# Version 1.2    Fixed some problems with getting the addresses of some        
#                Extensions (e.g. glTexImage3D) where the EXT/ARB did work     
#                but not the core-functions                               (SW) 
# Version 1.3    A second call to ReadimplementationProperties won't           
#                revert to the default libs anymore                       (MW) 
#                Libraries now will be released if necessary              (MW) 
# Version 1.3a   Small fixes for glSlang-functions                        (SW) 
# Version 1.3b   Fixed a small bug with GL_ARB_shader_objects, that lead       
#                lead to that extension not loaded correctly              (SW) 
# Version 1.3c   more GL 1.5 compliance by FOG_COORD_xx and                    
#                ARB less VBO and occlusion query routines                (MW) 
# Version 1.3d   Fixed linebreaks (should now be corrected under D5)      (SW) 
# Version 1.4    Changed header to correspond to the OpenGL-Shading            
#                Language specification 1.10 :                                 
#                - Added new GL_SAMPLER*-Constants                            
#                - Added Constant GL_SHADING_LANGUAGE_VERSION_ARB              
#                - Added Constant GL_FRAGMENT_SHADER_DERIVATIVE_HINT_ARB       
#                - Added Constant GL_MAX_FRAGMENT_UNIFORM_COMPONENTS_ARB  (SW) 
# Version 1.4a   Fixed a missing stdcall for glBindAttribLocationARB      (SW) 
# Version 1.4b   Fixed declaration for glUniform*(f/i)vARB (added count)  (MW) 
#                glCompileShaderARB changed from function to procedure    (MW) 
# Version 1.5    Added support for FreePascal                             (BR) 
#                Added type TGLVectorf3/TGLVector3f                       (SW) 
# Version 1.6    Added Extension GL_EXT_framebuffer_object                (SX) 
# Version 1.7    Added Extension GL_ARB_fragment_program_shadow           (SX) 
#                Added Extension GL_ARB_draw_buffers                      (SX) 
#                Added Extension GL_ARB_texture_rectangle                 (SX) 
#                Added Extension GL_ARB_color_buffer_float                (SX) 
#                Added Extension GL_ARB_half_float_pixel                  (SX) 
#                Added Extension GL_ARB_texture_float                     (SX) 
#                Added Extension GL_ARB_pixel_buffer_object               (SX) 
#                Added Extension GL_EXT_depth_bounds_test                 (SX) 
#                Added Extension GL_EXT_texture_mirror_clamp              (SX) 
#                Added Extension GL_EXT_blend_equation_separate           (SX) 
#                Added Extension GL_EXT_pixel_buffer_object               (SX) 
#                Added Extension GL_EXT_texture_compression_dxt1          (SX) 
#                Added Extension GL_NV_fragment_program_option            (SX) 
#                Added Extension GL_NV_fragment_program2                  (SX) 
#                Added Extension GL_NV_vertex_program2_option             (SX) 
#                Added Extension GL_NV_vertex_program3                    (SX) 
# Version 1.8    Added explicit delegate type definitions                 (LM) 
#                Added .Net 1.1 Support                                   (LM) 
#                Added .Net overloaded functions                          (LM) 
#                Added delayed extension loading and stubs                (LM) 
#                Added automatic InitOpenGL call in CreateRenderingContext(LM) 
#                Added extra Read* function                              (LM) 
# Version 2.0    fixed some Problem with version string and damn drivers.      
#                String 1.15 identified as OpenGL 1.5 not as OpenGL 1.1   (SX) 
#                Removed unexisting extension GL_ARB_texture_mirror_repeat(SX) 
#                Added Extension WGL_ARB_pixel_format_float               (SX) 
#                Added Extension GL_EXT_stencil_clear_tag                 (SX) 
#                Added Extension GL_EXT_texture_rectangle                 (SX) 
#                Added Extension GL_EXT_texture_edge_clamp                (SX) 
#                Some 1.5 Core Consts added (now completed)               (SX) 
#                gluProject need pointer for not .net                     (SX) 
#                gluUnProject need pointer for not .net                   (SX) 
#                wglUseFontOutlines* need pointer for not .net            (SX) 
#                wglSwapMultipleBuffers need pointer for not .net         (SX) 
#                Bug with wglGetExtensionsStringEXT removed                    
#                different type for .net                                  (SX) 
#                Added OpenGL 2.0 Core                                    (SX) 
# Version 2.0.1  fixed some problems with glGetActiveAttrib in 2.0 Core   (SX) 
#                fixes some problems with gluProject                      (SX) 
#                fixes some problems with gluUnProject                    (SX) 
#                fixes some problems with gluTessVertex                   (SX) 
#                fixes some problems with gluLoadSamplingMatrices         (SX) 
# Version 2.1    Removed .NET Support                                     (SX) 
#                Better support for Linux                                 (SX) 
#                Better Codeformation                                     (SX) 
#                Added some more Vector/Matrix types                      (SX) 
#                Added OpenGL 2.1 Core                                    (SX) 
#                Added Extension GL_EXT_packed_depth_stencil              (SX) 
#                Added Extension GL_EXT_texture_sRGB                      (SX) 
#                Added Extension GL_EXT_framebuffer_blit                  (SX) 
#                Added Extension GL_EXT_framebuffer_multisample           (SX) 
#                Added Extension GL_EXT_timer_query                       (SX) 
#                Added Extension GL_EXT_gpu_program_parameters            (SX) 
#                Added Extension GL_EXT_bindable_uniform                  (SX) 
#                Added Extension GL_EXT_draw_buffers2                     (SX) 
#                Added Extension GL_EXT_draw_instanced                    (SX) 
#                Added Extension GL_EXT_framebuffer_sRGB                  (SX) 
#                Added Extension GL_EXT_geometry_shader4                  (SX) 
#                Added Extension GL_EXT_gpu_shader4                       (SX) 
#                Added Extension GL_EXT_packed_float                      (SX) 
#                Added Extension GL_EXT_texture_array                     (SX) 
#                Added Extension GL_EXT_texture_buffer_object             (SX) 
#                Added Extension GL_EXT_texture_compression_latc          (SX) 
#                Added Extension GL_EXT_texture_compression_rgtc          (SX) 
#                Added Extension GL_EXT_texture_integer                   (SX) 
#                Added Extension GL_EXT_texture_shared_exponent           (SX) 
#                Added Extension GL_NV_depth_buffer_float                 (SX) 
#                Added Extension GL_NV_fragment_program4                  (SX) 
#                Added Extension GL_NV_framebuffer_multisample_coverage   (SX) 
#                Added Extension GL_NV_geometry_program4                  (SX) 
#                Added Extension GL_NV_gpu_program4                       (SX) 
#                Added Extension GL_NV_parameter_buffer_object            (SX) 
#                Added Extension GL_NV_transform_feedback                 (SX) 
#                Added Extension GL_NV_vertex_program4                    (SX) 
# Version 3.0    fixed some const of GL_EXT_texture_shared_exponent       (SX) 
#                possible better support for mac                          (SX) 
#                Added OpenGL 3.0 Core                                    (SX) 
#                Added Extension GL_ARB_depth_buffer_float                (SX) 
#                Added Extension GL_ARB_draw_instanced                    (SX) 
#                Added Extension GL_ARB_framebuffer_object                (SX) 
#                Added Extension GL_ARB_framebuffer_sRGB                  (SX) 
#                Added Extension GL_ARB_geometry_shader4                  (SX) 
#                Added Extension GL_ARB_half_float_vertex                 (SX) 
#                Added Extension GL_ARB_instanced_arrays                  (SX) 
#                Added Extension GL_ARB_map_buffer_range                  (SX) 
#                Added Extension GL_ARB_texture_buffer_object             (SX) 
#                Added Extension GL_ARB_texture_compression_rgtc          (SX) 
#                Added Extension GL_ARB_texture_rg                        (SX) 
#                Added Extension GL_ARB_vertex_array_object               (SX) 
#                Added Extension GL_NV_conditional_render                 (SX) 
#                Added Extension GL_NV_present_video                      (SX) 
#                Added Extension GL_EXT_transform_feedback                (SX) 
#                Added Extension GL_EXT_direct_state_access               (SX) 
#                Added Extension GL_EXT_vertex_array_bgra                 (SX) 
#                Added Extension GL_EXT_texture_swizzle                   (SX) 
#                Added Extension GL_NV_explicit_multisample               (SX) 
#                Added Extension GL_NV_transform_feedback2                (SX) 
#                Added Extension WGL_ARB_create_context                   (SX) 
#                Added Extension WGL_NV_present_video                     (SX) 
#                Added Extension WGL_NV_video_out                         (SX) 
#                Added Extension WGL_NV_swap_group                        (SX) 
#                Added Extension WGL_NV_gpu_affinity                      (SX) 
#                Added define DGL_TINY_HEADER to suppress automatic            
#                function loading                                         (SX) 
#                glProcedure renamed to dglGetProcAddress and now it's         
#                visible from outside the unit to custom load functions   (SX) 
#                dglCheckExtension added to check if an extension exists  (SX) 
#                Read_GL_ARB_buffer_object renamed to                          
#                Read_GL_ARB_vertex_buffer_object                         (SX) 
# Version 3.0.1  fixed an problem with fpc                                (SX) 
# Version 3.0.2  fixed an problem with WGL_ARB_create_context             (SX) 
# Version 3.2    Functions from GL_VERSION_3_0 where updated              (SX) 
#                Functions from GL_ARB_map_buffer_range where updated     (SX) 
#                Functions from GL_NV_present_video where added           (SX) 
#                Added consts of GL_ARB_instanced_arrays                  (SX) 
#                Defines to identify Delphi was changed (prevent for           
#                feature maintenance)                                     (SX) 
#                Added Extension GL_ATI_meminfo                           (SX) 
#                Added Extension GL_AMD_performance_monitor               (SX) 
#                Added Extension GL_AMD_texture_texture4                  (SX) 
#                Added Extension GL_AMD_vertex_shader_tesselator          (SX) 
#                Added Extension GL_EXT_provoking_vertex                  (SX) 
#                Added Extension WGL_AMD_gpu_association                  (SX) 
#                Added OpenGL 3.1 Core                                    (SX) 
#                All deprecated stuff can be disabled if you undef the         
#                define DGL_DEPRECATED                                    (SX) 
#                Added Extension GL_ARB_uniform_buffer_object             (SX) 
#                Added Extension GL_ARB_compatibility                     (SX) 
#                Added Extension GL_ARB_copy_buffer                       (SX) 
#                Added Extension GL_ARB_shader_texture_lod                (SX) 
#                Remove function from GL_NV_present_video                 (SX) 
#                Added Extension WGL_3DL_stereo_control                   (SX) 
#                Added Extension GL_EXT_texture_snorm                     (SX) 
#                Added Extension GL_AMD_draw_buffers_blend                (SX) 
#                Added Extension GL_APPLE_texture_range                   (SX) 
#                Added Extension GL_APPLE_float_pixels                    (SX) 
#                Added Extension GL_APPLE_vertex_program_evaluators       (SX) 
#                Added Extension GL_APPLE_aux_depth_stencil               (SX) 
#                Added Extension GL_APPLE_object_purgeable                (SX) 
#                Added Extension GL_APPLE_row_bytes                       (SX) 
#                Added OpenGL 3.2 Core                                    (SX) 
#                Added Extension GL_ARB_depth_clamp                       (SX) 
#                Added Extension GL_ARB_draw_elements_base_vertex         (SX) 
#                Added Extension GL_ARB_fragment_coord_conventions        (SX) 
#                Added Extension GL_ARB_provoking_vertex                  (SX) 
#                Added Extension GL_ARB_seamless_cube_map                 (SX) 
#                Added Extension GL_ARB_sync                              (SX) 
#                Added Extension GL_ARB_texture_multisample               (SX) 
#                Added Extension GL_ARB_vertex_array_bgra                 (SX) 
#                Added Extension GL_ARB_draw_buffers_blend                (SX) 
#                Added Extension GL_ARB_sample_shading                    (SX) 
#                Added Extension GL_ARB_texture_cube_map_array            (SX) 
#                Added Extension GL_ARB_texture_gather                    (SX) 
#                Added Extension GL_ARB_texture_query_lod                 (SX) 
#                Added Extension WGL_ARB_create_context_profile           (SX) 
#                Added GLX Core up to Version 1.4                         (SX) 
#                Added Extension GLX_ARB_multisample                      (SX) 
#                Added Extension GLX_ARB_fbconfig_float                   (SX) 
#                Added Extension GLX_ARB_get_proc_address                 (SX) 
#                Added Extension GLX_ARB_create_context                   (SX) 
#                Added Extension GLX_ARB_create_context_profile           (SX) 
#                Added Extension GLX_EXT_visual_info                      (SX) 
#                Added Extension GLX_EXT_visual_rating                    (SX) 
#                Added Extension GLX_EXT_import_context                   (SX) 
#                Added Extension GLX_EXT_fbconfig_packed_float            (SX) 
#                Added Extension GLX_EXT_framebuffer_sRGB                 (SX) 
#                Added Extension GLX_EXT_texture_from_pixmap              (SX) 
# Version 3.2.1  Fixed some problems with Delphi < 6                      (SX) 
# Version 3.2.2  Added Extension GL_APPLE_rgb_422                         (SX) 
#                Added Extension GL_EXT_separate_shader_objects           (SX) 
#                Added Extension GL_NV_video_capture                      (SX) 
#                Added Extension GL_NV_copy_image                         (SX) 
#                Added Extension GL_NV_parameter_buffer_object2           (SX) 
#                Added Extension GL_NV_shader_buffer_load                 (SX) 
#                Added Extension GL_NV_vertex_buffer_unified_memory       (SX) 
#                Added Extension GL_NV_texture_barrier                    (SX) 
#                Variable GL_EXT_texture_snorm will be filled             (SX) 
#                Variable GL_APPLE_row_bytes will be filled               (SX) 
#                Added Extension WGL_NV_video_capture                     (SX) 
#                Added Extension WGL_NV_copy_image                        (SX) 
#                WGL_NV_video_out now named WGL_NV_video_output           (SX) 
#                Added Extension GLX_EXT_swap_control                     (SX) 
# Version 3.2.3  Fixed an Problem with glGetAttribLocation                (SX) 
#                Added const GL_UNIFORM_BUFFER_EXT                        (SX) 
#                Functions of GL_NV_texture_barrier now will be loaded    (SX) 
# Version 4.0    Changes on Extension GL_ARB_texture_gather               (SX) 
#                Changes on Extension GL_NV_shader_buffer_load            (SX) 
#                Added OpenGL 3.3 Core                                    (SX) 
#                Added OpenGL 4.0 Core                                    (SX) 
#                Added Extension GL_AMD_shader_stencil_export             (SX) 
#                Added Extension GL_AMD_seamless_cubemap_per_texture      (SX) 
#                Added Extension GL_ARB_shading_language_include          (SX) 
#                Added Extension GL_ARB_texture_compression_bptc          (SX) 
#                Added Extension GL_ARB_blend_func_extended               (SX) 
#                Added Extension GL_ARB_explicit_attrib_location          (SX) 
#                Added Extension GL_ARB_occlusion_query2                  (SX) 
#                Added Extension GL_ARB_sampler_objects                   (SX) 
#                Added Extension GL_ARB_shader_bit_encoding               (SX) 
#                Added Extension GL_ARB_texture_rgb10_a2ui                (SX) 
#                Added Extension GL_ARB_texture_swizzle                   (SX) 
#                Added Extension GL_ARB_timer_query                       (SX) 
#                Added Extension GL_ARB_vertextyp_2_10_10_10_rev        (SX) 
#                Added Extension GL_ARB_draw_indirect                     (SX) 
#                Added Extension GL_ARB_gpu_shader5                       (SX) 
#                Added Extension GL_ARB_gpu_shader_fp64                   (SX) 
#                Added Extension GL_ARB_shader_subroutine                 (SX) 
#                Added Extension GL_ARB_tessellation_shader               (SX) 
#                Added Extension GL_ARB_texture_buffer_object_rgb32       (SX) 
#                Added Extension GL_ARB_transform_feedback2               (SX) 
#                Added Extension GL_ARB_transform_feedback3               (SX) 
# Version 4.1    Possible fix some strange linux behavior                 (SX) 
#                All function uses GL instead of TGL types                (SX) 
#                GL_AMD_vertex_shader_tesselator will be read now         (SX) 
#                GL_AMD_draw_buffers_blend will be read now               (SX) 
#                Changes on glStencilFuncSeparate (GL_2_0)                (SX) 
#                Changes on GL_VERSION_3_2                                (SX) 
#                Changes on GL_VERSION_3_3                                (SX) 
#                Changes on GL_VERSION_4_0                                (SX) 
#                Changes on GL_ARB_sample_shading                         (SX) 
#                Changes on GL_ARB_texture_cube_map_array                 (SX) 
#                Changes on GL_ARB_gpu_shader5                            (SX) 
#                Changes on GL_ARB_transform_feedback3                    (SX) 
#                Changes on GL_ARB_sampler_objects                        (SX) 
#                Changes on GL_ARB_gpu_shader_fp64                        (SX) 
#                Changes on GL_APPLE_element_array                        (SX) 
#                Changes on GL_APPLE_vertex_array_range                   (SX) 
#                Changes on GL_NV_transform_feedback                      (SX) 
#                Changes on GL_NV_vertex_buffer_unified_memory            (SX) 
#                Changes on GL_EXT_multi_draw_arrays                      (SX) 
#                Changes on GL_EXT_direct_state_access                    (SX) 
#                Changes on GL_AMD_performance_monitor                    (SX) 
#                Changes on GL_AMD_seamless_cubemap_per_texture           (SX) 
#                Changes on GL_EXT_geometry_shader4                       (SX) 
#                Added OpenGL 4.1 Core                                    (SX) 
#                Added Extension GL_ARB_ES2_compatibility                 (SX) 
#                Added Extension GL_ARB_get_program_binary                (SX) 
#                Added Extension GL_ARB_separate_shader_objects           (SX) 
#                Added Extension GL_ARB_shader_precision                  (SX) 
#                Added Extension GL_ARB_vertex_attrib_64bit               (SX) 
#                Added Extension GL_ARB_viewport_array                    (SX) 
#                Added Extension GL_ARB_cl_event                          (SX) 
#                Added Extension GL_ARB_debug_output                      (SX) 
#                Added Extension GL_ARB_robustness                        (SX) 
#                Added Extension GL_ARB_shader_stencil_export             (SX) 
#                Added Extension GL_AMD_conservative_depth                (SX) 
#                Added Extension GL_EXT_shader_image_load_store           (SX) 
#                Added Extension GL_EXT_vertex_attrib_64bit               (SX) 
#                Added Extension GL_NV_gpu_program5                       (SX) 
#                Added Extension GL_NV_gpu_shader5                        (SX) 
#                Added Extension GL_NV_shader_buffer_store                (SX) 
#                Added Extension GL_NV_tessellation_program5              (SX) 
#                Added Extension GL_NV_vertex_attrib_integer_64bit        (SX) 
#                Added Extension GL_NV_multisample_coverage               (SX) 
#                Added Extension GL_AMD_name_gen_delete                   (SX) 
#                Added Extension GL_AMD_debug_output                      (SX) 
#                Added Extension GL_NV_vdpau_interop                      (SX) 
#                Added Extension GL_AMD_transform_feedback3_lines_triangles (SX) 
#                Added Extension GL_AMD_depth_clamp_separate              (SX) 
#                Added Extension GL_EXT_texture_sRGB_decode               (SX) 
#                Added Extension WGL_ARB_framebuffer_sRGB                 (SX) 
#                Added Extension WGL_ARB_create_context_robustness        (SX) 
#                Added Extension WGL_EXT_create_context_es2_profile       (SX) 
#                Added Extension WGL_NV_multisample_coverage              (SX) 
#                Added Extension GLX_ARB_vertex_buffer_object             (SX) 
#                Added Extension GLX_ARB_framebuffer_sRGB                 (SX) 
#                Added Extension GLX_ARB_create_context_robustness        (SX) 
#                Added Extension GLX_EXT_create_context_es2_profile       (SX) 
# Version 4.1a   Fix for dglGetProcAddress with FPC and linux (def param) (SW) 
# Version 4.2    Added OpenGL 4.2 Core                                    (SW) 
#                Added Extension GL_ARB_base_instance                     (SW) 
#                Added Extension GL_ARB_shading_language_420pack          (SW) 
#                Added Extension GL_ARB_transform_feedback_instanced      (SW) 
#                Added Extension GL_ARB_compressed_texture_pixel_storage  (SW) 
#                Added Extension GL_ARB_conservative_depth                (SW) 
#                Added Extension GL_ARB_internalformat_query              (SW) 
#                Added Extension GL_ARB_map_buffer_alignment              (SW) 
#                Added Extension GL_ARB_shader_atomic_counters            (SW) 
#                Added Extension GL_ARB_shader_image_load_store           (SW) 
#                Added Extension GL_ARB_shading_language_packing          (SW) 
#                Added Extension GL_ARB_texture_storage                   (SW) 
#                Added Extension WGL_NV_DX_interop                        (SW) 
#                Added Define for WGL_EXT_create_context_es2_profile      (SW) 
# Version 4.2a   Added Mac OS X patch by Andrey Gruzdev                   (SW) 
#==============================================================================
# Header based on glext.h  rev 72 (2011/08/08)                                 
# Header based on wglext.h rev 23 (2011/04/13)                                 
# Header based on glxext.h rev 32 (2010/08/06)  (only Core/ARB/EXT)            
#                                                                              
# This is an important notice for maintaining. Dont remove it. And make sure   
# to keep it up to date                                                        
#==============================================================================

{.deadCodeElim: on.}

type 
  PPointer* = ptr Pointer
  GLenum* = Uint32
  GLboolean* = Bool
  GLbitfield* = Uint32
  GLbyte* = Int8
  GLshort* = Int16
  GLint* = Int32
  GLsizei* = Int32
  GLubyte* = Uint8
  GLushort* = Uint16
  GLuint* = Uint32
  GLfloat* = Float32
  GLclampf* = Float32
  GLdouble* = Float64
  GLclampd* = Float64
  GLvoid* = Pointer
  GLint64* = Int64
  GLuint64* = Uint64
  TGLenum* = GLenum
  TGLboolean* = GLboolean
  TGLbitfield* = GLbitfield
  TGLbyte* = GLbyte
  TGLshort* = GLshort
  TGLint* = GLint
  TGLsizei* = GLsizei
  TGLubyte* = GLubyte
  TGLushort* = GLushort
  TGLuint* = GLuint
  TGLfloat* = GLfloat
  TGLclampf* = GLclampf
  TGLdouble* = GLdouble
  TGLclampd* = GLclampd
  TGLvoid* = GLvoid
  TGLint64* = GLint64
  TGLuint64* = GLuint64
  PGLboolean* = ptr GLboolean
  PGLbyte* = ptr GLbyte
  PGLshort* = ptr GLshort
  PGLint* = ptr GLint
  PGLsizei* = ptr GLsizei
  PGLubyte* = ptr GLubyte
  PGLushort* = ptr GLushort
  PGLuint* = ptr GLuint
  PGLclampf* = ptr GLclampf
  PGLfloat* = ptr GLfloat
  PGLdouble* = ptr GLdouble
  PGLclampd* = ptr GLclampd
  PGLenum* = ptr GLenum
  PGLvoid* = Pointer
  PPGLvoid* = ptr PGLvoid
  PGLint64* = ptr GLint64
  PGLuint64* = ptr GLuint64   # GL_NV_half_float
  GLhalfNV* = Int16
  TGLhalfNV* = GLhalfNV
  PGLhalfNV* = ptr GLhalfNV   # GL_ARB_shader_objects
  PGLHandleARB* = ptr GLHandleARB
  GLHandleARB* = Int
  GLcharARB* = Char
  PGLcharARB* = Cstring
  PPGLcharARB* = ptr PGLcharARB # GL_VERSION_1_5
  GLintptr* = GLint
  GLsizeiptr* = GLsizei       # GL_ARB_vertex_buffer_object
  GLintptrARB* = GLint
  GLsizeiptrARB* = GLsizei    # GL_VERSION_2_0
  GLHandle* = Int
  PGLchar* = Cstring
  PPGLchar* = ptr PGLchar     # GL_EXT_timer_query
  GLint64EXT* = Int64
  TGLint64EXT* = GLint64EXT
  PGLint64EXT* = ptr GLint64EXT
  GLuint64EXT* = GLuint64
  TGLuint64EXT* = GLuint64EXT
  PGLuint64EXT* = ptr GLuint64EXT # WGL_ARB_pbuffer
  
  GLsync* = Pointer           # GL_ARB_cl_event
                              # These incomplete types let us declare types compatible with OpenCL's cl_context and cl_event 
  TclContext*{.final.} = object 
  TclEvent*{.final.} = object 
  PClContext* = ptr TclContext
  PClEvent* = ptr TclEvent  # GL_ARB_debug_output
  TglDebugProcARB* = proc (source: GLenum, typ: GLenum, id: GLuint, 
                           severity: GLenum, len: GLsizei, message: PGLchar, 
                           userParam: PGLvoid){.stdcall.} # GL_AMD_debug_output
  TglDebugProcAMD* = proc (id: GLuint, category: GLenum, severity: GLenum, 
                           len: GLsizei, message: PGLchar, userParam: PGLvoid){.
      stdcall.}               # GL_NV_vdpau_interop
  GLvdpauSurfaceNV* = GLintptr
  PGLvdpauSurfaceNV* = ptr GLvdpauSurfaceNV # GLX
  
when defined(windows):
  type
    HPBUFFERARB* = THandle      # WGL_EXT_pbuffer
    HPBUFFEREXT* = THandle      # WGL_NV_present_video
    PHVIDEOOUTPUTDEVICENV* = ptr HVIDEOOUTPUTDEVICENV
    HVIDEOOUTPUTDEVICENV* = THandle # WGL_NV_video_output
    PHPVIDEODEV* = ptr HPVIDEODEV
    HPVIDEODEV* = THandle       # WGL_NV_gpu_affinity
    PHPGPUNV* = ptr HPGPUNV
    PHGPUNV* = ptr HGPUNV       # WGL_NV_video_capture
    HVIDEOINPUTDEVICENV* = THandle
    PHVIDEOINPUTDEVICENV* = ptr HVIDEOINPUTDEVICENV
    HPGPUNV* = THandle
    HGPUNV* = THandle           # GL_ARB_sync

when defined(LINUX): 
  type 
    GLXContext* = Pointer
    GLXContextID* = TXID
    GLXDrawable* = TXID
    GLXFBConfig* = Pointer
    GLXPbuffer* = TXID
    GLXPixmap* = TXID
    GLXWindow* = TXID
    Window* = TXID
    Colormap* = TXID
    Pixmap* = TXID
    Font* = TXID
type                          # Datatypes corresponding to GL's types TGL(name)(type)(count)
  TGLVectorub2* = Array[0..1, GLubyte]
  TGLVectori2* = Array[0..1, GLint]
  TGLVectorf2* = Array[0..1, GLfloat]
  TGLVectord2* = Array[0..1, GLdouble]
  TGLVectorp2* = Array[0..1, Pointer]
  TGLVectorub3* = Array[0..2, GLubyte]
  TGLVectori3* = Array[0..2, GLint]
  TGLVectorf3* = Array[0..2, GLfloat]
  TGLVectord3* = Array[0..2, GLdouble]
  TGLVectorp3* = Array[0..2, Pointer]
  TGLVectorub4* = Array[0..3, GLubyte]
  TGLVectori4* = Array[0..3, GLint]
  TGLVectorf4* = Array[0..3, GLfloat]
  TGLVectord4* = Array[0..3, GLdouble]
  TGLVectorp4* = Array[0..3, Pointer]
  TGLArrayf4* = TGLVectorf4
  TGLArrayf3* = TGLVectorf3
  TGLArrayd3* = TGLVectord3
  TGLArrayi4* = TGLVectori4
  TGLArrayp4* = TGLVectorp4
  TGlMatrixub3* = Array[0..2, Array[0..2, GLubyte]]
  TGlMatrixi3* = Array[0..2, Array[0..2, GLint]]
  TGLMatrixf3* = Array[0..2, Array[0..2, GLfloat]]
  TGLMatrixd3* = Array[0..2, Array[0..2, GLdouble]]
  TGlMatrixub4* = Array[0..3, Array[0..3, GLubyte]]
  TGlMatrixi4* = Array[0..3, Array[0..3, GLint]]
  TGLMatrixf4* = Array[0..3, Array[0..3, GLfloat]]
  TGLMatrixd4* = Array[0..3, Array[0..3, GLdouble]]
  TGLVector3f* = TGLVectorf3  # Datatypes corresponding to OpenGL12.pas for easy porting
  TVector3d* = TGLVectord3
  TVector4i* = TGLVectori4
  TVector4f* = TGLVectorf4
  TVector4p* = TGLVectorp4
  TMatrix4f* = TGLMatrixf4
  TMatrix4d* = TGLMatrixd4
  PGLMatrixd4* = ptr TGLMatrixd4
  PVector4i* = ptr TVector4i
  TRect*{.final.} = object 
    Left*, Top*, Right*, Bottom*: Int32

  PgpuDevice* = ptr GpuDevice
  GpuDevice*{.final.} = object 
    cb*: Int32
    DeviceName*: Array[0..31, Char]
    DeviceString*: Array[0..127, Char]
    Flags*: Int32
    rcVirtualScreen*: TRect


when defined(windows): 
  type 
    PWGLSwap* = ptr TWGLSwap
    TWGLSWAP*{.final.} = object 
      hdc*: HDC
      uiFlags*: int32

type 
  TGLUNurbs*{.final.} = object 
  TGLUQuadric*{.final.} = object 
  TGLUTesselator*{.final.} = object 
  PGLUNurbs* = ptr TGLUNurbs
  PGLUQuadric* = ptr TGLUQuadric
  PGLUTesselator* = ptr TGLUTesselator # backwards compatibility
  TGLUNurbsObj* = TGLUNurbs
  TGLUQuadricObj* = TGLUQuadric
  TGLUTesselatorObj* = TGLUTesselator
  TGLUTriangulatorObj* = TGLUTesselator
  PGLUNurbsObj* = PGLUNurbs
  PGLUQuadricObj* = PGLUQuadric
  PGLUTesselatorObj* = PGLUTesselator
  PGLUTriangulatorObj* = PGLUTesselator # GLUQuadricCallback

  TGLUQuadricErrorProc* = proc(errorCode: GLenum){.stdcall.}
  TGLUTessBeginProc* = proc(AType: GLenum){.stdcall.}
  TGLUTessEdgeFlagProc* = proc(Flag: GLboolean){.stdcall.}
  TGLUTessVertexProc* = proc(VertexData: Pointer){.stdcall.}
  TGLUTessEndProc* = proc(){.stdcall.}
  TGLUTessErrorProc* = proc(ErrNo: GLenum){.stdcall.}
  TGLUTessCombineProc* = proc(Coords: TGLArrayd3, VertexData: TGLArrayp4, 
                         Weight: TGLArrayf4, OutData: PPointer){.stdcall.}
  TGLUTessBeginDataProc* = proc(AType: GLenum, UserData: Pointer){.stdcall.}
  TGLUTessEdgeFlagDataProc* = proc(Flag: GLboolean, UserData: Pointer){.stdcall.}
  TGLUTessVertexDataProc* = proc(VertexData: Pointer, UserData: Pointer){.stdcall.}
  TGLUTessEndDataProc* = proc(UserData: Pointer){.stdcall.}
  TGLUTessErrorDataProc* = proc(ErrNo: GLenum, UserData: Pointer){.stdcall.}
  TGLUTessCombineDataProc* = proc(Coords: TGLArrayd3, VertexData: TGLArrayp4, 
                             Weight: TGLArrayf4, OutData: PPointer, 
                             UserData: Pointer){.stdcall.}
  # GLUNurbsCallback
  TGLUNurbsErrorProc* = proc(ErrorCode: GLenum){.stdcall.}

const                         # GL_VERSION_1_1
                              # AttribMask 
  GlDepthBufferBit* = 0x00000100
  GlStencilBufferBit* = 0x00000400
  GlColorBufferBit* = 0x00004000 # Boolean 
  GlTrue* = 1
  GlFalse* = 0               # BeginMode 
  GlPoints* = 0x00000000
  GlLines* = 0x00000001
  GlLineLoop* = 0x00000002
  GlLineStrip* = 0x00000003
  GlTriangles* = 0x00000004
  GlTriangleStrip* = 0x00000005
  GlTriangleFan* = 0x00000006 # AlphaFunction 
  GlNever* = 0x00000200
  GlLess* = 0x00000201
  GlEqual* = 0x00000202
  GlLequal* = 0x00000203
  GlGreater* = 0x00000204
  GlNotequal* = 0x00000205
  GlGequal* = 0x00000206
  GlAlways* = 0x00000207     # BlendingFactorDest 
  GlZero* = 0
  GlOne* = 1
  GlSrcColor* = 0x00000300
  GlOneMinusSrcColor* = 0x00000301
  GlSrcAlpha* = 0x00000302
  GlOneMinusSrcAlpha* = 0x00000303
  GlDstAlpha* = 0x00000304
  GlOneMinusDstAlpha* = 0x00000305 # BlendingFactorSrc 
  GlDstColor* = 0x00000306
  GlOneMinusDstColor* = 0x00000307
  GlSrcAlphaSaturate* = 0x00000308 # DrawBufferMode 
  GlNone* = 0
  GlFrontLeft* = 0x00000400
  GlFrontRight* = 0x00000401
  GlBackLeft* = 0x00000402
  GlBackRight* = 0x00000403
  GlFront* = 0x00000404
  GlBack* = 0x00000405
  GlLeft* = 0x00000406
  GlRight* = 0x00000407
  GlFrontAndBack* = 0x00000408 # ErrorCode 
  GlNoError* = 0
  GlInvalidEnum* = 0x00000500
  GlInvalidValue* = 0x00000501
  GlInvalidOperation* = 0x00000502
  GlOutOfMemory* = 0x00000505 # FrontFaceDirection 
  GlCw* = 0x00000900
  GlCcw* = 0x00000901        # GetPName 
  cGLPOINTSIZE* = 0x00000B11
  GlPointSizeRange* = 0x00000B12
  GlPointSizeGranularity* = 0x00000B13
  GlLineSmooth* = 0x00000B20
  cGLLINEWIDTH* = 0x00000B21
  GlLineWidthRange* = 0x00000B22
  GlLineWidthGranularity* = 0x00000B23
  GlPolygonSmooth* = 0x00000B41
  cGLCULLFACE* = 0x00000B44
  GlCullFaceMode* = 0x00000B45
  cGLFRONTFACE* = 0x00000B46
  cGLDEPTHRANGE* = 0x00000B70
  GlDepthTest* = 0x00000B71
  GlDepthWritemask* = 0x00000B72
  GlDepthClearValue* = 0x00000B73
  cGLDEPTHFUNC* = 0x00000B74
  GlStencilTest* = 0x00000B90
  GlStencilClearValue* = 0x00000B91
  cGLSTENCILFUNC* = 0x00000B92
  GlStencilValueMask* = 0x00000B93
  GlStencilFail* = 0x00000B94
  GlStencilPassDepthFail* = 0x00000B95
  GlStencilPassDepthPass* = 0x00000B96
  GlStencilRef* = 0x00000B97
  GlStencilWritemask* = 0x00000B98
  cGLVIEWPORT* = 0x00000BA2
  GlDither* = 0x00000BD0
  GlBlendDst* = 0x00000BE0
  GlBlendSrc* = 0x00000BE1
  GlBlend* = 0x00000BE2
  GlLogicOpMode* = 0x00000BF0
  GlColorLogicOp* = 0x00000BF2
  cGLDRAWBUFFER* = 0x00000C01
  cGLREADBUFFER* = 0x00000C02
  GlScissorBox* = 0x00000C10
  GlScissorTest* = 0x00000C11
  GlColorClearValue* = 0x00000C22
  GlColorWritemask* = 0x00000C23
  GlDoublebuffer* = 0x00000C32
  GlStereo* = 0x00000C33
  GlLineSmoothHint* = 0x00000C52
  GlPolygonSmoothHint* = 0x00000C53
  GlUnpackSwapBytes* = 0x00000CF0
  GlUnpackLsbFirst* = 0x00000CF1
  GlUnpackRowLength* = 0x00000CF2
  GlUnpackSkipRows* = 0x00000CF3
  GlUnpackSkipPixels* = 0x00000CF4
  GlUnpackAlignment* = 0x00000CF5
  GlPackSwapBytes* = 0x00000D00
  GlPackLsbFirst* = 0x00000D01
  GlPackRowLength* = 0x00000D02
  GlPackSkipRows* = 0x00000D03
  GlPackSkipPixels* = 0x00000D04
  GlPackAlignment* = 0x00000D05
  GlMaxTextureSize* = 0x00000D33
  GlMaxViewportDims* = 0x00000D3A
  GlSubpixelBits* = 0x00000D50
  GlTexture1d* = 0x00000DE0
  GlTexture2d* = 0x00000DE1
  GlPolygonOffsetUnits* = 0x00002A00
  GlPolygonOffsetPoint* = 0x00002A01
  GlPolygonOffsetLine* = 0x00002A02
  GlPolygonOffsetFill* = 0x00008037
  GlPolygonOffsetFactor* = 0x00008038
  GlTextureBinding1d* = 0x00008068
  GlTextureBinding2d* = 0x00008069 # GetTextureParameter 
  GlTextureWidth* = 0x00001000
  GlTextureHeight* = 0x00001001
  GlTextureInternalFormat* = 0x00001003
  GlTextureBorderColor* = 0x00001004
  GlTextureBorder* = 0x00001005
  GlTextureRedSize* = 0x0000805C
  GlTextureGreenSize* = 0x0000805D
  GlTextureBlueSize* = 0x0000805E
  GlTextureAlphaSize* = 0x0000805F # HintMode 
  GlDontCare* = 0x00001100
  GlFastest* = 0x00001101
  GlNicest* = 0x00001102     # DataType 
  cGLBYTE* = 0x00001400
  cGLUNSIGNEDBYTE* = 0x00001401
  cGLSHORT* = 0x00001402
  cGLUNSIGNEDSHORT* = 0x00001403
  cGLINT* = 0x00001404
  cGLUNSIGNEDINT* = 0x00001405
  cGLFLOAT* = 0x00001406
  cGLDOUBLE* = 0x0000140A     # LogicOp 
  cGLCLEAR* = 0x00001500
  GlAnd* = 0x00001501
  GlAndReverse* = 0x00001502
  GlCopy* = 0x00001503
  GlAndInverted* = 0x00001504
  GlNoop* = 0x00001505
  GlXor* = 0x00001506
  GlOr* = 0x00001507
  GlNor* = 0x00001508
  GlEquiv* = 0x00001509
  GlInvert* = 0x0000150A
  GlOrReverse* = 0x0000150B
  GlCopyInverted* = 0x0000150C
  GlOrInverted* = 0x0000150D
  GlNand* = 0x0000150E
  GlSet* = 0x0000150F        # MatrixMode (for gl3.h, FBO attachment type) 
  GlTexture* = 0x00001702    # PixelCopyType 
  GlColor* = 0x00001800
  GlDepth* = 0x00001801
  GlStencil* = 0x00001802    # PixelFormat 
  GlStencilIndex* = 0x00001901
  GlDepthComponent* = 0x00001902
  GlRed* = 0x00001903
  GlGreen* = 0x00001904
  GlBlue* = 0x00001905
  GlAlpha* = 0x00001906
  GlRgb* = 0x00001907
  GlRgba* = 0x00001908       # PolygonMode 
  GlPoint* = 0x00001B00
  GlLine* = 0x00001B01
  GlFill* = 0x00001B02       # StencilOp 
  GlKeep* = 0x00001E00
  GlReplace* = 0x00001E01
  GlIncr* = 0x00001E02
  GlDecr* = 0x00001E03       # StringName 
  GlVendor* = 0x00001F00
  GlRenderer* = 0x00001F01
  GlVersion* = 0x00001F02
  GlExtensions* = 0x00001F03 # TextureMagFilter 
  GlNearest* = 0x00002600
  GlLinear* = 0x00002601     # TextureMinFilter 
  GlNearestMipmapNearest* = 0x00002700
  GlLinearMipmapNearest* = 0x00002701
  GlNearestMipmapLinear* = 0x00002702
  GlLinearMipmapLinear* = 0x00002703 # TextureParameterName 
  GlTextureMagFilter* = 0x00002800
  GlTextureMinFilter* = 0x00002801
  GlTextureWrapS* = 0x00002802
  GlTextureWrapT* = 0x00002803 # TextureTarget 
  GlProxyTexture1d* = 0x00008063
  GlProxyTexture2d* = 0x00008064 # TextureWrapMode 
  GlRepeat* = 0x00002901     # PixelInternalFormat 
  GlR3G3B2* = 0x00002A10
  GlRgb4* = 0x0000804F
  GlRgb5* = 0x00008050
  GlRgb8* = 0x00008051
  GlRgb10* = 0x00008052
  GlRgb12* = 0x00008053
  GlRgb16* = 0x00008054
  GlRgba2* = 0x00008055
  GlRgba4* = 0x00008056
  GlRgb5A1* = 0x00008057
  GlRgba8* = 0x00008058
  GlRgb10A2* = 0x00008059
  GlRgba12* = 0x0000805A
  GlRgba16* = 0x0000805B
  cGLACCUM* = 0x00000100
  GlLoad* = 0x00000101
  GlReturn* = 0x00000102
  GlMult* = 0x00000103
  GlAdd* = 0x00000104
  GlCurrentBit* = 0x00000001
  GlPointBit* = 0x00000002
  GlLineBit* = 0x00000004
  GlPolygonBit* = 0x00000008
  GlPolygonStippleBit* = 0x00000010
  GlPixelModeBit* = 0x00000020
  GlLightingBit* = 0x00000040
  GlFogBit* = 0x00000080
  GlAccumBufferBit* = 0x00000200
  GlViewportBit* = 0x00000800
  GlTransformBit* = 0x00001000
  GlEnableBit* = 0x00002000
  GlHintBit* = 0x00008000
  GlEvalBit* = 0x00010000
  GlListBit* = 0x00020000
  GlTextureBit* = 0x00040000
  GlScissorBit* = 0x00080000
  GlAllAttribBits* = 0x000FFFFF
  GlQuads* = 0x00000007
  GlQuadStrip* = 0x00000008
  GlPolygon* = 0x00000009
  GlClipPlane0* = 0x00003000
  GlClipPlane1* = 0x00003001
  GlClipPlane2* = 0x00003002
  GlClipPlane3* = 0x00003003
  GlClipPlane4* = 0x00003004
  GlClipPlane5* = 0x00003005
  Gl2Bytes* = 0x00001407
  Gl3Bytes* = 0x00001408
  Gl4Bytes* = 0x00001409
  GlAux0* = 0x00000409
  GlAux1* = 0x0000040A
  GlAux2* = 0x0000040B
  GlAux3* = 0x0000040C
  GlStackOverflow* = 0x00000503
  GlStackUnderflow* = 0x00000504
  Gl2d* = 0x00000600
  Gl3d* = 0x00000601
  Gl3dColor* = 0x00000602
  Gl3dColorTexture* = 0x00000603
  Gl4dColorTexture* = 0x00000604
  GlPassThroughToken* = 0x00000700
  GlPointToken* = 0x00000701
  GlLineToken* = 0x00000702
  GlPolygonToken* = 0x00000703
  GlBitmapToken* = 0x00000704
  GlDrawPixelToken* = 0x00000705
  GlCopyPixelToken* = 0x00000706
  GlLineResetToken* = 0x00000707
  GlExp* = 0x00000800
  GlExp2* = 0x00000801
  GlCoeff* = 0x00000A00
  GlOrder* = 0x00000A01
  GlDomain* = 0x00000A02
  GlCurrentColor* = 0x00000B00
  GlCurrentIndex* = 0x00000B01
  GlCurrentNormal* = 0x00000B02
  GlCurrentTextureCoords* = 0x00000B03
  GlCurrentRasterColor* = 0x00000B04
  GlCurrentRasterIndex* = 0x00000B05
  GlCurrentRasterTextureCoords* = 0x00000B06
  GlCurrentRasterPosition* = 0x00000B07
  GlCurrentRasterPositionValid* = 0x00000B08
  GlCurrentRasterDistance* = 0x00000B09
  GlPointSmooth* = 0x00000B10
  cGLLINESTIPPLE* = 0x00000B24
  GlLineStipplePattern* = 0x00000B25
  GlLineStippleRepeat* = 0x00000B26
  GlListMode* = 0x00000B30
  GlMaxListNesting* = 0x00000B31
  cGLLISTBASE* = 0x00000B32
  GlListIndex* = 0x00000B33
  cGLPOLYGONMODE* = 0x00000B40
  cGLPOLYGONSTIPPLE* = 0x00000B42
  cGLEDGEFLAG* = 0x00000B43
  GlLighting* = 0x00000B50
  GlLightModelLocalViewer* = 0x00000B51
  GlLightModelTwoSide* = 0x00000B52
  GlLightModelAmbient* = 0x00000B53
  cGLSHADEMODEL* = 0x00000B54
  GlColorMaterialFace* = 0x00000B55
  GlColorMaterialParameter* = 0x00000B56
  cGLCOLORMATERIAL* = 0x00000B57
  GlFog* = 0x00000B60
  GlFogIndex* = 0x00000B61
  GlFogDensity* = 0x00000B62
  GlFogStart* = 0x00000B63
  GlFogEnd* = 0x00000B64
  GlFogMode* = 0x00000B65
  GlFogColor* = 0x00000B66
  GlAccumClearValue* = 0x00000B80
  cGLMATRIXMODE* = 0x00000BA0
  GlNormalize* = 0x00000BA1
  GlModelviewStackDepth* = 0x00000BA3
  GlProjectionStackDepth* = 0x00000BA4
  GlTextureStackDepth* = 0x00000BA5
  GlModelviewMatrix* = 0x00000BA6
  GlProjectionMatrix* = 0x00000BA7
  GlTextureMatrix* = 0x00000BA8
  GlAttribStackDepth* = 0x00000BB0
  GlClientAttribStackDepth* = 0x00000BB1
  GlAlphaTest* = 0x00000BC0
  GlAlphaTestFunc* = 0x00000BC1
  GlAlphaTestRef* = 0x00000BC2
  GlIndexLogicOp* = 0x00000BF1
  GlAuxBuffers* = 0x00000C00
  GlIndexClearValue* = 0x00000C20
  GlIndexWritemask* = 0x00000C21
  GlIndexMode* = 0x00000C30
  GlRgbaMode* = 0x00000C31
  cGLRENDERMODE* = 0x00000C40
  GlPerspectiveCorrectionHint* = 0x00000C50
  GlPointSmoothHint* = 0x00000C51
  GlFogHint* = 0x00000C54
  GlTextureGenS* = 0x00000C60
  GlTextureGenT* = 0x00000C61
  GlTextureGenR* = 0x00000C62
  GlTextureGenQ* = 0x00000C63
  GlPixelMapIToI* = 0x00000C70
  GlPixelMapSToS* = 0x00000C71
  GlPixelMapIToR* = 0x00000C72
  GlPixelMapIToG* = 0x00000C73
  GlPixelMapIToB* = 0x00000C74
  GlPixelMapIToA* = 0x00000C75
  GlPixelMapRToR* = 0x00000C76
  GlPixelMapGToG* = 0x00000C77
  GlPixelMapBToB* = 0x00000C78
  GlPixelMapAToA* = 0x00000C79
  GlPixelMapIToISize* = 0x00000CB0
  GlPixelMapSToSSize* = 0x00000CB1
  GlPixelMapIToRSize* = 0x00000CB2
  GlPixelMapIToGSize* = 0x00000CB3
  GlPixelMapIToBSize* = 0x00000CB4
  GlPixelMapIToASize* = 0x00000CB5
  GlPixelMapRToRSize* = 0x00000CB6
  GlPixelMapGToGSize* = 0x00000CB7
  GlPixelMapBToBSize* = 0x00000CB8
  GlPixelMapAToASize* = 0x00000CB9
  GlMapColor* = 0x00000D10
  GlMapStencil* = 0x00000D11
  GlIndexShift* = 0x00000D12
  GlIndexOffset* = 0x00000D13
  GlRedScale* = 0x00000D14
  GlRedBias* = 0x00000D15
  GlZoomX* = 0x00000D16
  GlZoomY* = 0x00000D17
  GlGreenScale* = 0x00000D18
  GlGreenBias* = 0x00000D19
  GlBlueScale* = 0x00000D1A
  GlBlueBias* = 0x00000D1B
  GlAlphaScale* = 0x00000D1C
  GlAlphaBias* = 0x00000D1D
  GlDepthScale* = 0x00000D1E
  GlDepthBias* = 0x00000D1F
  GlMaxEvalOrder* = 0x00000D30
  GlMaxLights* = 0x00000D31
  GlMaxClipPlanes* = 0x00000D32
  GlMaxPixelMapTable* = 0x00000D34
  GlMaxAttribStackDepth* = 0x00000D35
  GlMaxModelviewStackDepth* = 0x00000D36
  GlMaxNameStackDepth* = 0x00000D37
  GlMaxProjectionStackDepth* = 0x00000D38
  GlMaxTextureStackDepth* = 0x00000D39
  GlMaxClientAttribStackDepth* = 0x00000D3B
  GlIndexBits* = 0x00000D51
  GlRedBits* = 0x00000D52
  GlGreenBits* = 0x00000D53
  GlBlueBits* = 0x00000D54
  GlAlphaBits* = 0x00000D55
  GlDepthBits* = 0x00000D56
  GlStencilBits* = 0x00000D57
  GlAccumRedBits* = 0x00000D58
  GlAccumGreenBits* = 0x00000D59
  GlAccumBlueBits* = 0x00000D5A
  GlAccumAlphaBits* = 0x00000D5B
  GlNameStackDepth* = 0x00000D70
  GlAutoNormal* = 0x00000D80
  GlMap1Color4* = 0x00000D90
  GlMap1Index* = 0x00000D91
  GlMap1Normal* = 0x00000D92
  GlMap1TextureCoord1* = 0x00000D93
  GlMap1TextureCoord2* = 0x00000D94
  GlMap1TextureCoord3* = 0x00000D95
  GlMap1TextureCoord4* = 0x00000D96
  GlMap1Vertex3* = 0x00000D97
  GlMap1Vertex4* = 0x00000D98
  GlMap2Color4* = 0x00000DB0
  GlMap2Index* = 0x00000DB1
  GlMap2Normal* = 0x00000DB2
  GlMap2TextureCoord1* = 0x00000DB3
  GlMap2TextureCoord2* = 0x00000DB4
  GlMap2TextureCoord3* = 0x00000DB5
  GlMap2TextureCoord4* = 0x00000DB6
  GlMap2Vertex3* = 0x00000DB7
  GlMap2Vertex4* = 0x00000DB8
  GlMap1GridDomain* = 0x00000DD0
  GlMap1GridSegments* = 0x00000DD1
  GlMap2GridDomain* = 0x00000DD2
  GlMap2GridSegments* = 0x00000DD3
  GlFeedbackBufferPointer* = 0x00000DF0
  GlFeedbackBufferSize* = 0x00000DF1
  GLFEEDBACKBUFFERtyp* = 0x00000DF2
  GlSelectionBufferPointer* = 0x00000DF3
  GlSelectionBufferSize* = 0x00000DF4
  GlLight0* = 0x00004000
  GlLight1* = 0x00004001
  GlLight2* = 0x00004002
  GlLight3* = 0x00004003
  GlLight4* = 0x00004004
  GlLight5* = 0x00004005
  GlLight6* = 0x00004006
  GlLight7* = 0x00004007
  GlAmbient* = 0x00001200
  GlDiffuse* = 0x00001201
  GlSpecular* = 0x00001202
  GlPosition* = 0x00001203
  GlSpotDirection* = 0x00001204
  GlSpotExponent* = 0x00001205
  GlSpotCutoff* = 0x00001206
  GlConstantAttenuation* = 0x00001207
  GlLinearAttenuation* = 0x00001208
  GlQuadraticAttenuation* = 0x00001209
  GlCompile* = 0x00001300
  GlCompileAndExecute* = 0x00001301
  GlEmission* = 0x00001600
  GlShininess* = 0x00001601
  GlAmbientAndDiffuse* = 0x00001602
  GlColorIndexes* = 0x00001603
  GlModelview* = 0x00001700
  GlProjection* = 0x00001701
  GlColorIndex* = 0x00001900
  GlLuminance* = 0x00001909
  GlLuminanceAlpha* = 0x0000190A
  cGLBITMAP* = 0x00001A00
  GlRender* = 0x00001C00
  GlFeedback* = 0x00001C01
  GlSelect* = 0x00001C02
  GlFlat* = 0x00001D00
  GlSmooth* = 0x00001D01
  GlS* = 0x00002000
  GlT* = 0x00002001
  GlR* = 0x00002002
  GlQ* = 0x00002003
  GlModulate* = 0x00002100
  GlDecal* = 0x00002101
  GlTextureEnvMode* = 0x00002200
  GlTextureEnvColor* = 0x00002201
  GlTextureEnv* = 0x00002300
  GlEyeLinear* = 0x00002400
  GlObjectLinear* = 0x00002401
  GlSphereMap* = 0x00002402
  GlTextureGenMode* = 0x00002500
  GlObjectPlane* = 0x00002501
  GlEyePlane* = 0x00002502
  GlClamp* = 0x00002900
  GlClientPixelStoreBit* = 0x00000001
  GlClientVertexArrayBit* = 0x00000002
  GlClientAllAttribBits* = 0xFFFFFFFF
  GlAlpha4* = 0x0000803B
  GlAlpha8* = 0x0000803C
  GlAlpha12* = 0x0000803D
  GlAlpha16* = 0x0000803E
  GlLuminance4* = 0x0000803F
  GlLuminance8* = 0x00008040
  GlLuminance12* = 0x00008041
  GlLuminance16* = 0x00008042
  GlLuminance4Alpha4* = 0x00008043
  GlLuminance6Alpha2* = 0x00008044
  GlLuminance8Alpha8* = 0x00008045
  GlLuminance12Alpha4* = 0x00008046
  GlLuminance12Alpha12* = 0x00008047
  GlLuminance16Alpha16* = 0x00008048
  GlIntensity* = 0x00008049
  GlIntensity4* = 0x0000804A
  GlIntensity8* = 0x0000804B
  GlIntensity12* = 0x0000804C
  GlIntensity16* = 0x0000804D
  GlTextureLuminanceSize* = 0x00008060
  GlTextureIntensitySize* = 0x00008061
  GlTexturePriority* = 0x00008066
  GlTextureResident* = 0x00008067
  GlVertexArray* = 0x00008074
  GlNormalArray* = 0x00008075
  GlColorArray* = 0x00008076
  GlIndexArray* = 0x00008077
  GlTextureCoordArray* = 0x00008078
  GlEdgeFlagArray* = 0x00008079
  GlVertexArraySize* = 0x0000807A
  GLVERTEXARRAYtyp* = 0x0000807B
  GlVertexArrayStride* = 0x0000807C
  GLNORMALARRAYtyp* = 0x0000807E
  GlNormalArrayStride* = 0x0000807F
  GlColorArraySize* = 0x00008081
  GLCOLORARRAYtyp* = 0x00008082
  GlColorArrayStride* = 0x00008083
  GLINDEXARRAYtyp* = 0x00008085
  GlIndexArrayStride* = 0x00008086
  GlTextureCoordArraySize* = 0x00008088
  GLTEXTURECOORDARRAYtyp* = 0x00008089
  GlTextureCoordArrayStride* = 0x0000808A
  GlEdgeFlagArrayStride* = 0x0000808C
  GlVertexArrayPointer* = 0x0000808E
  GlNormalArrayPointer* = 0x0000808F
  GlColorArrayPointer* = 0x00008090
  GlIndexArrayPointer* = 0x00008091
  GlTextureCoordArrayPointer* = 0x00008092
  GlEdgeFlagArrayPointer* = 0x00008093
  GlV2f* = 0x00002A20
  GlV3f* = 0x00002A21
  GlC4ubV2f* = 0x00002A22
  GlC4ubV3f* = 0x00002A23
  GlC3fV3f* = 0x00002A24
  GlN3fV3f* = 0x00002A25
  GlC4fN3fV3f* = 0x00002A26
  GlT2fV3f* = 0x00002A27
  GlT4fV4f* = 0x00002A28
  GlT2fC4ubV3f* = 0x00002A29
  GlT2fC3fV3f* = 0x00002A2A
  GlT2fN3fV3f* = 0x00002A2B
  GlT2fC4fN3fV3f* = 0x00002A2C
  GlT4fC4fN3fV4f* = 0x00002A2D
  GlColorTableFormatExt* = 0x000080D8
  GlColorTableWidthExt* = 0x000080D9
  GlColorTableRedSizeExt* = 0x000080DA
  GlColorTableGreenSizeExt* = 0x000080DB
  GlColorTableBlueSizeExt* = 0x000080DC
  GlColorTableAlphaSizeExt* = 0x000080DD
  GlColorTableLuminanceSizeExt* = 0x000080DE
  GlColorTableIntensitySizeExt* = 0x000080DF
  cGLLOGICOP* = GL_INDEX_LOGIC_OP
  GlTextureComponents* = GL_TEXTURE_INTERNAL_FORMAT # GL_VERSION_1_2
  GlUnsignedByte332* = 0x00008032
  GlUnsignedShort4444* = 0x00008033
  GlUnsignedShort5551* = 0x00008034
  GlUnsignedInt8888* = 0x00008035
  GlUnsignedInt1010102* = 0x00008036
  GlTextureBinding3d* = 0x0000806A
  GlPackSkipImages* = 0x0000806B
  GlPackImageHeight* = 0x0000806C
  GlUnpackSkipImages* = 0x0000806D
  GlUnpackImageHeight* = 0x0000806E
  GlTexture3d* = 0x0000806F
  GlProxyTexture3d* = 0x00008070
  GlTextureDepth* = 0x00008071
  GlTextureWrapR* = 0x00008072
  GlMax3dTextureSize* = 0x00008073
  GlUnsignedByte233Rev* = 0x00008362
  GlUnsignedShort565* = 0x00008363
  GlUnsignedShort565Rev* = 0x00008364
  GlUnsignedShort4444Rev* = 0x00008365
  GlUnsignedShort1555Rev* = 0x00008366
  GlUnsignedInt8888Rev* = 0x00008367
  GlUnsignedInt2101010Rev* = 0x00008368
  GlBgr* = 0x000080E0
  GlBgra* = 0x000080E1
  GlMaxElementsVertices* = 0x000080E8
  GlMaxElementsIndices* = 0x000080E9
  GlClampToEdge* = 0x0000812F
  GlTextureMinLod* = 0x0000813A
  GlTextureMaxLod* = 0x0000813B
  GlTextureBaseLevel* = 0x0000813C
  GlTextureMaxLevel* = 0x0000813D
  GlSmoothPointSizeRange* = 0x00000B12
  GlSmoothPointSizeGranularity* = 0x00000B13
  GlSmoothLineWidthRange* = 0x00000B22
  GlSmoothLineWidthGranularity* = 0x00000B23
  GlAliasedLineWidthRange* = 0x0000846E
  GlRescaleNormal* = 0x0000803A
  GlLightModelColorControl* = 0x000081F8
  GlSingleColor* = 0x000081F9
  GlSeparateSpecularColor* = 0x000081FA
  GlAliasedPointSizeRange* = 0x0000846D # GL_VERSION_1_3
  GlTexture0* = 0x000084C0
  GlTexture1* = 0x000084C1
  GlTexture2* = 0x000084C2
  GlTexture3* = 0x000084C3
  GlTexture4* = 0x000084C4
  GlTexture5* = 0x000084C5
  GlTexture6* = 0x000084C6
  GlTexture7* = 0x000084C7
  GlTexture8* = 0x000084C8
  GlTexture9* = 0x000084C9
  GlTexture10* = 0x000084CA
  GlTexture11* = 0x000084CB
  GlTexture12* = 0x000084CC
  GlTexture13* = 0x000084CD
  GlTexture14* = 0x000084CE
  GlTexture15* = 0x000084CF
  GlTexture16* = 0x000084D0
  GlTexture17* = 0x000084D1
  GlTexture18* = 0x000084D2
  GlTexture19* = 0x000084D3
  GlTexture20* = 0x000084D4
  GlTexture21* = 0x000084D5
  GlTexture22* = 0x000084D6
  GlTexture23* = 0x000084D7
  GlTexture24* = 0x000084D8
  GlTexture25* = 0x000084D9
  GlTexture26* = 0x000084DA
  GlTexture27* = 0x000084DB
  GlTexture28* = 0x000084DC
  GlTexture29* = 0x000084DD
  GlTexture30* = 0x000084DE
  GlTexture31* = 0x000084DF
  cGLACTIVETEXTURE* = 0x000084E0
  GlMultisample* = 0x0000809D
  GlSampleAlphaToCoverage* = 0x0000809E
  GlSampleAlphaToOne* = 0x0000809F
  cGLSAMPLECOVERAGE* = 0x000080A0
  GlSampleBuffers* = 0x000080A8
  GlSamples* = 0x000080A9
  GlSampleCoverageValue* = 0x000080AA
  GlSampleCoverageInvert* = 0x000080AB
  GlTextureCubeMap* = 0x00008513
  GlTextureBindingCubeMap* = 0x00008514
  GlTextureCubeMapPositiveX* = 0x00008515
  GlTextureCubeMapNegativeX* = 0x00008516
  GlTextureCubeMapPositiveY* = 0x00008517
  GlTextureCubeMapNegativeY* = 0x00008518
  GlTextureCubeMapPositiveZ* = 0x00008519
  GlTextureCubeMapNegativeZ* = 0x0000851A
  GlProxyTextureCubeMap* = 0x0000851B
  GlMaxCubeMapTextureSize* = 0x0000851C
  GlCompressedRgb* = 0x000084ED
  GlCompressedRgba* = 0x000084EE
  GlTextureCompressionHint* = 0x000084EF
  GlTextureCompressedImageSize* = 0x000086A0
  GlTextureCompressed* = 0x000086A1
  GlNumCompressedTextureFormats* = 0x000086A2
  GlCompressedTextureFormats* = 0x000086A3
  GlClampToBorder* = 0x0000812D
  cGLCLIENTACTIVETEXTURE* = 0x000084E1
  GlMaxTextureUnits* = 0x000084E2
  GlTransposeModelviewMatrix* = 0x000084E3
  GlTransposeProjectionMatrix* = 0x000084E4
  GlTransposeTextureMatrix* = 0x000084E5
  GlTransposeColorMatrix* = 0x000084E6
  GlMultisampleBit* = 0x20000000
  GlNormalMap* = 0x00008511
  GlReflectionMap* = 0x00008512
  GlCompressedAlpha* = 0x000084E9
  GlCompressedLuminance* = 0x000084EA
  GlCompressedLuminanceAlpha* = 0x000084EB
  GlCompressedIntensity* = 0x000084EC
  GlCombine* = 0x00008570
  GlCombineRgb* = 0x00008571
  GlCombineAlpha* = 0x00008572
  GlSource0Rgb* = 0x00008580
  GlSource1Rgb* = 0x00008581
  GlSource2Rgb* = 0x00008582
  GlSource0Alpha* = 0x00008588
  GlSource1Alpha* = 0x00008589
  GlSource2Alpha* = 0x0000858A
  GlOperand0Rgb* = 0x00008590
  GlOperand1Rgb* = 0x00008591
  GlOperand2Rgb* = 0x00008592
  GlOperand0Alpha* = 0x00008598
  GlOperand1Alpha* = 0x00008599
  GlOperand2Alpha* = 0x0000859A
  GlRgbScale* = 0x00008573
  GlAddSigned* = 0x00008574
  GlInterpolate* = 0x00008575
  GlSubtract* = 0x000084E7
  GlConstant* = 0x00008576
  GlPrimaryColor* = 0x00008577
  GlPrevious* = 0x00008578
  GlDot3Rgb* = 0x000086AE
  GlDot3Rgba* = 0x000086AF  # GL_VERSION_1_4
  GlBlendDstRgb* = 0x000080C8
  GlBlendSrcRgb* = 0x000080C9
  GlBlendDstAlpha* = 0x000080CA
  GlBlendSrcAlpha* = 0x000080CB
  GlPointFadeThresholdSize* = 0x00008128
  GlDepthComponent16* = 0x000081A5
  GlDepthComponent24* = 0x000081A6
  GlDepthComponent32* = 0x000081A7
  GlMirroredRepeat* = 0x00008370
  GlMaxTextureLodBias* = 0x000084FD
  GlTextureLodBias* = 0x00008501
  GlIncrWrap* = 0x00008507
  GlDecrWrap* = 0x00008508
  GlTextureDepthSize* = 0x0000884A
  GlTextureCompareMode* = 0x0000884C
  GlTextureCompareFunc* = 0x0000884D
  GlPointSizeMin* = 0x00008126
  GlPointSizeMax* = 0x00008127
  GlPointDistanceAttenuation* = 0x00008129
  cGLGENERATEMIPMAP* = 0x00008191
  GlGenerateMipmapHint* = 0x00008192
  GlFogCoordinateSource* = 0x00008450
  GlFogCoordinate* = 0x00008451
  GlFragmentDepth* = 0x00008452
  GlCurrentFogCoordinate* = 0x00008453
  GLFOGCOORDINATEARRAYtyp* = 0x00008454
  GlFogCoordinateArrayStride* = 0x00008455
  GlFogCoordinateArrayPointer* = 0x00008456
  GlFogCoordinateArray* = 0x00008457
  GlColorSum* = 0x00008458
  GlCurrentSecondaryColor* = 0x00008459
  GlSecondaryColorArraySize* = 0x0000845A
  GLSECONDARYCOLORARRAYtyp* = 0x0000845B
  GlSecondaryColorArrayStride* = 0x0000845C
  GlSecondaryColorArrayPointer* = 0x0000845D
  GlSecondaryColorArray* = 0x0000845E
  GlTextureFilterControl* = 0x00008500
  GlDepthTextureMode* = 0x0000884B
  GlCompareRToTexture* = 0x0000884E # GL_VERSION_1_5
  GlBufferSize* = 0x00008764
  GlBufferUsage* = 0x00008765
  GlQueryCounterBits* = 0x00008864
  GlCurrentQuery* = 0x00008865
  GlQueryResult* = 0x00008866
  GlQueryResultAvailable* = 0x00008867
  GlArrayBuffer* = 0x00008892
  GlElementArrayBuffer* = 0x00008893
  GlArrayBufferBinding* = 0x00008894
  GlElementArrayBufferBinding* = 0x00008895
  GlVertexAttribArrayBufferBinding* = 0x0000889F
  GlReadOnly* = 0x000088B8
  GlWriteOnly* = 0x000088B9
  GlReadWrite* = 0x000088BA
  GlBufferAccess* = 0x000088BB
  GlBufferMapped* = 0x000088BC
  GlBufferMapPointer* = 0x000088BD
  GlStreamDraw* = 0x000088E0
  GlStreamRead* = 0x000088E1
  GlStreamCopy* = 0x000088E2
  GlStaticDraw* = 0x000088E4
  GlStaticRead* = 0x000088E5
  GlStaticCopy* = 0x000088E6
  GlDynamicDraw* = 0x000088E8
  GlDynamicRead* = 0x000088E9
  GlDynamicCopy* = 0x000088EA
  GlSamplesPassed* = 0x00008914
  GlVertexArrayBufferBinding* = 0x00008896
  GlNormalArrayBufferBinding* = 0x00008897
  GlColorArrayBufferBinding* = 0x00008898
  GlIndexArrayBufferBinding* = 0x00008899
  GlTextureCoordArrayBufferBinding* = 0x0000889A
  GlEdgeFlagArrayBufferBinding* = 0x0000889B
  GlSecondaryColorArrayBufferBinding* = 0x0000889C
  GlFogCoordinateArrayBufferBinding* = 0x0000889D
  GlWeightArrayBufferBinding* = 0x0000889E
  GlFogCoordSrc* = 0x00008450
  GlFogCoord* = 0x00008451
  GlCurrentFogCoord* = 0x00008453
  GLFOGCOORDARRAYtyp* = 0x00008454
  GlFogCoordArrayStride* = 0x00008455
  GlFogCoordArrayPointer* = 0x00008456
  GlFogCoordArray* = 0x00008457
  GlFogCoordArrayBufferBinding* = 0x0000889D
  GlSrc0Rgb* = 0x00008580
  GlSrc1Rgb* = 0x00008581
  GlSrc2Rgb* = 0x00008582
  GlSrc0Alpha* = 0x00008588
  GlSrc1Alpha* = 0x00008589
  GlSrc2Alpha* = 0x0000858A # GL_VERSION_2_0
  GlBlendEquationRgb* = 0x00008009
  GlVertexAttribArrayEnabled* = 0x00008622
  GlVertexAttribArraySize* = 0x00008623
  GlVertexAttribArrayStride* = 0x00008624
  GLVERTEXATTRIBARRAYtyp* = 0x00008625
  GlCurrentVertexAttrib* = 0x00008626
  GlVertexProgramPointSize* = 0x00008642
  GlVertexAttribArrayPointer* = 0x00008645
  GlStencilBackFunc* = 0x00008800
  GlStencilBackFail* = 0x00008801
  GlStencilBackPassDepthFail* = 0x00008802
  GlStencilBackPassDepthPass* = 0x00008803
  GlMaxDrawBuffers* = 0x00008824
  GlDrawBuffer0* = 0x00008825
  GlDrawBuffer1* = 0x00008826
  GlDrawBuffer2* = 0x00008827
  GlDrawBuffer3* = 0x00008828
  GlDrawBuffer4* = 0x00008829
  GlDrawBuffer5* = 0x0000882A
  GlDrawBuffer6* = 0x0000882B
  GlDrawBuffer7* = 0x0000882C
  GlDrawBuffer8* = 0x0000882D
  GlDrawBuffer9* = 0x0000882E
  GlDrawBuffer10* = 0x0000882F
  GlDrawBuffer11* = 0x00008830
  GlDrawBuffer12* = 0x00008831
  GlDrawBuffer13* = 0x00008832
  GlDrawBuffer14* = 0x00008833
  GlDrawBuffer15* = 0x00008834
  GlBlendEquationAlpha* = 0x0000883D
  GlMaxVertexAttribs* = 0x00008869
  GlVertexAttribArrayNormalized* = 0x0000886A
  GlMaxTextureImageUnits* = 0x00008872
  GlFragmentShader* = 0x00008B30
  GlVertexShader* = 0x00008B31
  GlMaxFragmentUniformComponents* = 0x00008B49
  GlMaxVertexUniformComponents* = 0x00008B4A
  GlMaxVaryingFloats* = 0x00008B4B
  GlMaxVertexTextureImageUnits* = 0x00008B4C
  GlMaxCombinedTextureImageUnits* = 0x00008B4D
  GLSHADERtyp* = 0x00008B4F
  GlFloatVec2* = 0x00008B50
  GlFloatVec3* = 0x00008B51
  GlFloatVec4* = 0x00008B52
  GlIntVec2* = 0x00008B53
  GlIntVec3* = 0x00008B54
  GlIntVec4* = 0x00008B55
  GlBool* = 0x00008B56
  GlBoolVec2* = 0x00008B57
  GlBoolVec3* = 0x00008B58
  GlBoolVec4* = 0x00008B59
  GlFloatMat2* = 0x00008B5A
  GlFloatMat3* = 0x00008B5B
  GlFloatMat4* = 0x00008B5C
  GlSampler1d* = 0x00008B5D
  GlSampler2d* = 0x00008B5E
  GlSampler3d* = 0x00008B5F
  GlSamplerCube* = 0x00008B60
  GlSampler1dShadow* = 0x00008B61
  GlSampler2dShadow* = 0x00008B62
  GlDeleteStatus* = 0x00008B80
  GlCompileStatus* = 0x00008B81
  GlLinkStatus* = 0x00008B82
  GlValidateStatus* = 0x00008B83
  GlInfoLogLength* = 0x00008B84
  GlAttachedShaders* = 0x00008B85
  GlActiveUniforms* = 0x00008B86
  GlActiveUniformMaxLength* = 0x00008B87
  GlShaderSourceLength* = 0x00008B88
  GlActiveAttributes* = 0x00008B89
  GlActiveAttributeMaxLength* = 0x00008B8A
  GlFragmentShaderDerivativeHint* = 0x00008B8B
  GlShadingLanguageVersion* = 0x00008B8C
  GlCurrentProgram* = 0x00008B8D
  GlPointSpriteCoordOrigin* = 0x00008CA0
  GlLowerLeft* = 0x00008CA1
  GlUpperLeft* = 0x00008CA2
  GlStencilBackRef* = 0x00008CA3
  GlStencilBackValueMask* = 0x00008CA4
  GlStencilBackWritemask* = 0x00008CA5
  GlVertexProgramTwoSide* = 0x00008643
  GlPointSprite* = 0x00008861
  GlCoordReplace* = 0x00008862
  GlMaxTextureCoords* = 0x00008871 # GL_VERSION_2_1
  GlPixelPackBuffer* = 0x000088EB
  GlPixelUnpackBuffer* = 0x000088EC
  GlPixelPackBufferBinding* = 0x000088ED
  GlPixelUnpackBufferBinding* = 0x000088EF
  GLFLOATMAT2x3* = 0x00008B65
  GLFLOATMAT2x4* = 0x00008B66
  GLFLOATMAT3x2* = 0x00008B67
  GLFLOATMAT3x4* = 0x00008B68
  GLFLOATMAT4x2* = 0x00008B69
  GLFLOATMAT4x3* = 0x00008B6A
  GlSrgb* = 0x00008C40
  GlSrgb8* = 0x00008C41
  GlSrgbAlpha* = 0x00008C42
  GlSrgb8Alpha8* = 0x00008C43
  GlCompressedSrgb* = 0x00008C48
  GlCompressedSrgbAlpha* = 0x00008C49
  GlCurrentRasterSecondaryColor* = 0x0000845F
  GlSluminanceAlpha* = 0x00008C44
  GlSluminance8Alpha8* = 0x00008C45
  GlSluminance* = 0x00008C46
  GlSluminance8* = 0x00008C47
  GlCompressedSluminance* = 0x00008C4A
  GlCompressedSluminanceAlpha* = 0x00008C4B # GL_VERSION_3_0
  GlCompareRefToTexture* = 0x0000884E
  GlClipDistance0* = 0x00003000
  GlClipDistance1* = 0x00003001
  GlClipDistance2* = 0x00003002
  GlClipDistance3* = 0x00003003
  GlClipDistance4* = 0x00003004
  GlClipDistance5* = 0x00003005
  GlClipDistance6* = 0x00003006
  GlClipDistance7* = 0x00003007
  GlMaxClipDistances* = 0x00000D32
  GlMajorVersion* = 0x0000821B
  GlMinorVersion* = 0x0000821C
  GlNumExtensions* = 0x0000821D
  GlContextFlags* = 0x0000821E
  GlDepthBuffer* = 0x00008223
  GlStencilBuffer* = 0x00008224
  GlCompressedRed* = 0x00008225
  GlCompressedRg* = 0x00008226
  GlContextFlagForwardCompatibleBit* = 0x00000001
  GlRgba32f* = 0x00008814
  GlRgb32f* = 0x00008815
  GlRgba16f* = 0x0000881A
  GlRgb16f* = 0x0000881B
  GlVertexAttribArrayInteger* = 0x000088FD
  GlMaxArrayTextureLayers* = 0x000088FF
  GlMinProgramTexelOffset* = 0x00008904
  GlMaxProgramTexelOffset* = 0x00008905
  GlClampReadColor* = 0x0000891C
  GlFixedOnly* = 0x0000891D
  GlMaxVaryingComponents* = 0x00008B4B
  GlTexture1dArray* = 0x00008C18
  GlProxyTexture1dArray* = 0x00008C19
  GlTexture2dArray* = 0x00008C1A
  GlProxyTexture2dArray* = 0x00008C1B
  GlTextureBinding1dArray* = 0x00008C1C
  GlTextureBinding2dArray* = 0x00008C1D
  GlR11fG11fB10f* = 0x00008C3A
  GlUnsignedInt10f11f11fRev* = 0x00008C3B
  GlRgb9E5* = 0x00008C3D
  GlUnsignedInt5999Rev* = 0x00008C3E
  GlTextureSharedSize* = 0x00008C3F
  GlTransformFeedbackVaryingMaxLength* = 0x00008C76
  GlTransformFeedbackBufferMode* = 0x00008C7F
  GlMaxTransformFeedbackSeparateComponents* = 0x00008C80
  cGLTRANSFORMFEEDBACKVARYINGS* = 0x00008C83
  GlTransformFeedbackBufferStart* = 0x00008C84
  GlTransformFeedbackBufferSize* = 0x00008C85
  GlPrimitivesGenerated* = 0x00008C87
  GlTransformFeedbackPrimitivesWritten* = 0x00008C88
  GlRasterizerDiscard* = 0x00008C89
  GlMaxTransformFeedbackInterleavedComponents* = 0x00008C8A
  GlMaxTransformFeedbackSeparateAttribs* = 0x00008C8B
  GlInterleavedAttribs* = 0x00008C8C
  GlSeparateAttribs* = 0x00008C8D
  GlTransformFeedbackBuffer* = 0x00008C8E
  GlTransformFeedbackBufferBinding* = 0x00008C8F
  GlRgba32ui* = 0x00008D70
  GlRgb32ui* = 0x00008D71
  GlRgba16ui* = 0x00008D76
  GlRgb16ui* = 0x00008D77
  GlRgba8ui* = 0x00008D7C
  GlRgb8ui* = 0x00008D7D
  GlRgba32i* = 0x00008D82
  GlRgb32i* = 0x00008D83
  GlRgba16i* = 0x00008D88
  GlRgb16i* = 0x00008D89
  GlRgba8i* = 0x00008D8E
  GlRgb8i* = 0x00008D8F
  GlRedInteger* = 0x00008D94
  GlGreenInteger* = 0x00008D95
  GlBlueInteger* = 0x00008D96
  GlRgbInteger* = 0x00008D98
  GlRgbaInteger* = 0x00008D99
  GlBgrInteger* = 0x00008D9A
  GlBgraInteger* = 0x00008D9B
  GlSampler1dArray* = 0x00008DC0
  GlSampler2dArray* = 0x00008DC1
  GlSampler1dArrayShadow* = 0x00008DC3
  GlSampler2dArrayShadow* = 0x00008DC4
  GlSamplerCubeShadow* = 0x00008DC5
  GlUnsignedIntVec2* = 0x00008DC6
  GlUnsignedIntVec3* = 0x00008DC7
  GlUnsignedIntVec4* = 0x00008DC8
  GlIntSampler1d* = 0x00008DC9
  GlIntSampler2d* = 0x00008DCA
  GlIntSampler3d* = 0x00008DCB
  GlIntSamplerCube* = 0x00008DCC
  GlIntSampler1dArray* = 0x00008DCE
  GlIntSampler2dArray* = 0x00008DCF
  GlUnsignedIntSampler1d* = 0x00008DD1
  GlUnsignedIntSampler2d* = 0x00008DD2
  GlUnsignedIntSampler3d* = 0x00008DD3
  GlUnsignedIntSamplerCube* = 0x00008DD4
  GlUnsignedIntSampler1dArray* = 0x00008DD6
  GlUnsignedIntSampler2dArray* = 0x00008DD7
  GlQueryWait* = 0x00008E13
  GlQueryNoWait* = 0x00008E14
  GlQueryByRegionWait* = 0x00008E15
  GlQueryByRegionNoWait* = 0x00008E16
  GlBufferAccessFlags* = 0x0000911F
  GlBufferMapLength* = 0x00009120
  GlBufferMapOffset* = 0x00009121
  GlClampVertexColor* = 0x0000891A
  GlClampFragmentColor* = 0x0000891B
  GlAlphaInteger* = 0x00008D97 # GL_VERSION_3_1
  GlSampler2dRect* = 0x00008B63
  GlSampler2dRectShadow* = 0x00008B64
  GlSamplerBuffer* = 0x00008DC2
  GlIntSampler2dRect* = 0x00008DCD
  GlIntSamplerBuffer* = 0x00008DD0
  GlUnsignedIntSampler2dRect* = 0x00008DD5
  GlUnsignedIntSamplerBuffer* = 0x00008DD8
  GlTextureBuffer* = 0x00008C2A
  GlMaxTextureBufferSize* = 0x00008C2B
  GlTextureBindingBuffer* = 0x00008C2C
  GlTextureBufferDataStoreBinding* = 0x00008C2D
  GlTextureBufferFormat* = 0x00008C2E
  GlTextureRectangle* = 0x000084F5
  GlTextureBindingRectangle* = 0x000084F6
  GlProxyTextureRectangle* = 0x000084F7
  GlMaxRectangleTextureSize* = 0x000084F8
  GlRedSnorm* = 0x00008F90
  GlRgSnorm* = 0x00008F91
  GlRgbSnorm* = 0x00008F92
  GlRgbaSnorm* = 0x00008F93
  GlR8Snorm* = 0x00008F94
  GlRg8Snorm* = 0x00008F95
  GlRgb8Snorm* = 0x00008F96
  GlRgba8Snorm* = 0x00008F97
  GlR16Snorm* = 0x00008F98
  GlRg16Snorm* = 0x00008F99
  GlRgb16Snorm* = 0x00008F9A
  GlRgba16Snorm* = 0x00008F9B
  GlSignedNormalized* = 0x00008F9C
  GlPrimitiveRestart* = 0x00008F9D
  cGLPRIMITIVERESTARTINDEX* = 0x00008F9E
  GlContextCoreProfileBit* = 0x00000001
  GlContextCompatibilityProfileBit* = 0x00000002
  GlLinesAdjacency* = 0x0000000A
  GlLineStripAdjacency* = 0x0000000B
  GlTrianglesAdjacency* = 0x0000000C
  GlTriangleStripAdjacency* = 0x0000000D
  GlProgramPointSize* = 0x00008642
  GlMaxGeometryTextureImageUnits* = 0x00008C29
  GlFramebufferAttachmentLayered* = 0x00008DA7
  GlFramebufferIncompleteLayerTargets* = 0x00008DA8
  GlGeometryShader* = 0x00008DD9
  GlGeometryVerticesOut* = 0x00008916
  GLGEOMETRYINPUTtyp* = 0x00008917
  GLGEOMETRYOUTPUTtyp* = 0x00008918
  GlMaxGeometryUniformComponents* = 0x00008DDF
  GlMaxGeometryOutputVertices* = 0x00008DE0
  GlMaxGeometryTotalOutputComponents* = 0x00008DE1
  GlMaxVertexOutputComponents* = 0x00009122
  GlMaxGeometryInputComponents* = 0x00009123
  GlMaxGeometryOutputComponents* = 0x00009124
  GlMaxFragmentInputComponents* = 0x00009125
  GlContextProfileMask* = 0x00009126 # GL_VERSION_3_3
  GlVertexAttribArrayDivisor* = 0x000088FE # GL_VERSION_4_0
  GlSampleShading* = 0x00008C36
  GlMinSampleShadingValue* = 0x00008C37
  GlMinProgramTextureGatherOffset* = 0x00008E5E
  GlMaxProgramTextureGatherOffset* = 0x00008E5F
  GlTextureCubeMapArray* = 0x00009009
  GlTextureBindingCubeMapArray* = 0x0000900A
  GlProxyTextureCubeMapArray* = 0x0000900B
  GlSamplerCubeMapArray* = 0x0000900C
  GlSamplerCubeMapArrayShadow* = 0x0000900D
  GlIntSamplerCubeMapArray* = 0x0000900E
  GlUnsignedIntSamplerCubeMapArray* = 0x0000900F # GL_3DFX_multisample
  GlMultisample3dfx* = 0x000086B2
  GlSampleBuffers3dfx* = 0x000086B3
  GlSamples3dfx* = 0x000086B4
  GlMultisampleBit3dfx* = 0x20000000 # GL_3DFX_texture_compression_FXT1
  GlCompressedRgbFxt13dfx* = 0x000086B0
  GlCompressedRgbaFxt13dfx* = 0x000086B1 # GL_APPLE_client_storage
  GlUnpackClientStorageApple* = 0x000085B2 # GL_APPLE_element_array
  GlElementArrayApple* = 0x00008A0C
  GLELEMENTARRAYtypAPPLE* = 0x00008A0D
  GlElementArrayPointerApple* = 0x00008A0E # GL_APPLE_fence
  GlDrawPixelsApple* = 0x00008A0A
  GlFenceApple* = 0x00008A0B # GL_APPLE_specular_vector
  GlLightModelSpecularVectorApple* = 0x000085B0 # GL_APPLE_transform_hint
  GlTransformHintApple* = 0x000085B1 # GL_APPLE_vertex_array_object
  GlVertexArrayBindingApple* = 0x000085B5 # GL_APPLE_vertex_array_range
  cGLVERTEXARRAYRANGEAPPLE* = 0x0000851D
  GlVertexArrayRangeLengthApple* = 0x0000851E
  GlVertexArrayStorageHintApple* = 0x0000851F
  GlVertexArrayRangePointerApple* = 0x00008521
  GlStorageClientApple* = 0x000085B4
  GlStorageCachedApple* = 0x000085BE
  GlStorageSharedApple* = 0x000085BF # GL_APPLE_ycbcr_422
  GlYcbcr422Apple* = 0x000085B9
  GlUnsignedShort88Apple* = 0x000085BA
  GlUnsignedShort88RevApple* = 0x000085BB # GL_APPLE_texture_range
  GlTextureRangeLengthApple* = 0x000085B7
  GlTextureRangePointerApple* = 0x000085B8
  GlTextureStorageHintApple* = 0x000085BC
  GlStoragePrivateApple* = 0x000085BD # reuse GL_STORAGE_CACHED_APPLE 
                                         # reuse GL_STORAGE_SHARED_APPLE 
                                         # GL_APPLE_float_pixels
  GlHalfApple* = 0x0000140B
  GlRgbaFloat32Apple* = 0x00008814
  GlRgbFloat32Apple* = 0x00008815
  GlAlphaFloat32Apple* = 0x00008816
  GlIntensityFloat32Apple* = 0x00008817
  GlLuminanceFloat32Apple* = 0x00008818
  GlLuminanceAlphaFloat32Apple* = 0x00008819
  GlRgbaFloat16Apple* = 0x0000881A
  GlRgbFloat16Apple* = 0x0000881B
  GlAlphaFloat16Apple* = 0x0000881C
  GlIntensityFloat16Apple* = 0x0000881D
  GlLuminanceFloat16Apple* = 0x0000881E
  GlLuminanceAlphaFloat16Apple* = 0x0000881F
  GlColorFloatApple* = 0x00008A0F # GL_APPLE_vertex_program_evaluators
  GlVertexAttribMap1Apple* = 0x00008A00
  GlVertexAttribMap2Apple* = 0x00008A01
  GlVertexAttribMap1SizeApple* = 0x00008A02
  GlVertexAttribMap1CoeffApple* = 0x00008A03
  GlVertexAttribMap1OrderApple* = 0x00008A04
  GlVertexAttribMap1DomainApple* = 0x00008A05
  GlVertexAttribMap2SizeApple* = 0x00008A06
  GlVertexAttribMap2CoeffApple* = 0x00008A07
  GlVertexAttribMap2OrderApple* = 0x00008A08
  GlVertexAttribMap2DomainApple* = 0x00008A09 # GL_APPLE_aux_depth_stencil
  GlAuxDepthStencilApple* = 0x00008A14 # GL_APPLE_object_purgeable
  GlBufferObjectApple* = 0x000085B3
  GlReleasedApple* = 0x00008A19
  GlVolatileApple* = 0x00008A1A
  GlRetainedApple* = 0x00008A1B
  GlUndefinedApple* = 0x00008A1C
  GlPurgeableApple* = 0x00008A1D # GL_APPLE_row_bytes
  GlPackRowBytesApple* = 0x00008A15
  GlUnpackRowBytesApple* = 0x00008A16 # GL_APPLE_rgb_422
                                          # reuse GL_UNSIGNED_SHORT_8_8_APPLE 
                                          # reuse GL_UNSIGNED_SHORT_8_8_REV_APPLE 
                                          # GL_ARB_depth_texture
  GlDepthComponent16Arb* = 0x000081A5
  GlDepthComponent24Arb* = 0x000081A6
  GlDepthComponent32Arb* = 0x000081A7
  GlTextureDepthSizeArb* = 0x0000884A
  GlDepthTextureModeArb* = 0x0000884B # GL_ARB_fragment_program
  GlFragmentProgramArb* = 0x00008804
  GlProgramAluInstructionsArb* = 0x00008805
  GlProgramTexInstructionsArb* = 0x00008806
  GlProgramTexIndirectionsArb* = 0x00008807
  GlProgramNativeAluInstructionsArb* = 0x00008808
  GlProgramNativeTexInstructionsArb* = 0x00008809
  GlProgramNativeTexIndirectionsArb* = 0x0000880A
  GlMaxProgramAluInstructionsArb* = 0x0000880B
  GlMaxProgramTexInstructionsArb* = 0x0000880C
  GlMaxProgramTexIndirectionsArb* = 0x0000880D
  GlMaxProgramNativeAluInstructionsArb* = 0x0000880E
  GlMaxProgramNativeTexInstructionsArb* = 0x0000880F
  GlMaxProgramNativeTexIndirectionsArb* = 0x00008810
  GlMaxTextureCoordsArb* = 0x00008871
  GlMaxTextureImageUnitsArb* = 0x00008872 # GL_ARB_imaging
  GlConstantColorArb* = 0x00008001
  GlOneMinusConstantColor* = 0x00008002
  GlConstantAlpha* = 0x00008003
  GlOneMinusConstantAlpha* = 0x00008004
  cGLBLENDCOLOR* = 0x00008005
  GlFuncAdd* = 0x00008006
  GlMin* = 0x00008007
  GlMax* = 0x00008008
  cGLBLENDEQUATION* = 0x00008009
  GlFuncSubtract* = 0x0000800A
  GlFuncReverseSubtract* = 0x0000800B
  GlConvolution1d* = 0x00008010
  GlConvolution2d* = 0x00008011
  GlSeparable2d* = 0x00008012
  GlConvolutionBorderMode* = 0x00008013
  GlConvolutionFilterScale* = 0x00008014
  GlConvolutionFilterBias* = 0x00008015
  GlReduce* = 0x00008016
  GlConvolutionFormat* = 0x00008017
  GlConvolutionWidth* = 0x00008018
  GlConvolutionHeight* = 0x00008019
  GlMaxConvolutionWidth* = 0x0000801A
  GlMaxConvolutionHeight* = 0x0000801B
  GlPostConvolutionRedScale* = 0x0000801C
  GlPostConvolutionGreenScale* = 0x0000801D
  GlPostConvolutionBlueScale* = 0x0000801E
  GlPostConvolutionAlphaScale* = 0x0000801F
  GlPostConvolutionRedBias* = 0x00008020
  GlPostConvolutionGreenBias* = 0x00008021
  GlPostConvolutionBlueBias* = 0x00008022
  GlPostConvolutionAlphaBias* = 0x00008023
  cGLHISTOGRAM* = 0x00008024
  GlProxyHistogram* = 0x00008025
  GlHistogramWidth* = 0x00008026
  GlHistogramFormat* = 0x00008027
  GlHistogramRedSize* = 0x00008028
  GlHistogramGreenSize* = 0x00008029
  GlHistogramBlueSize* = 0x0000802A
  GlHistogramAlphaSize* = 0x0000802B
  GlHistogramLuminanceSize* = 0x0000802C
  GlHistogramSink* = 0x0000802D
  cGLMINMAX* = 0x0000802E
  GlMinmaxFormat* = 0x0000802F
  GlMinmaxSink* = 0x00008030
  GlTableTooLarge* = 0x00008031
  GlColorMatrix* = 0x000080B1
  GlColorMatrixStackDepth* = 0x000080B2
  GlMaxColorMatrixStackDepth* = 0x000080B3
  GlPostColorMatrixRedScale* = 0x000080B4
  GlPostColorMatrixGreenScale* = 0x000080B5
  GlPostColorMatrixBlueScale* = 0x000080B6
  GlPostColorMatrixAlphaScale* = 0x000080B7
  GlPostColorMatrixRedBias* = 0x000080B8
  GlPostColorMatrixGreenBias* = 0x000080B9
  GlPostColorMatrixBlueBias* = 0x000080BA
  GlPostColorMatrixAlphaBias* = 0x000080BB
  cGLCOLORTABLE* = 0x000080D0
  GlPostConvolutionColorTable* = 0x000080D1
  GlPostColorMatrixColorTable* = 0x000080D2
  GlProxyColorTable* = 0x000080D3
  GlProxyPostConvolutionColorTable* = 0x000080D4
  GlProxyPostColorMatrixColorTable* = 0x000080D5
  GlColorTableScale* = 0x000080D6
  GlColorTableBias* = 0x000080D7
  GlColorTableFormat* = 0x000080D8
  GlColorTableWidth* = 0x000080D9
  GlColorTableRedSize* = 0x000080DA
  GlColorTableGreenSize* = 0x000080DB
  GlColorTableBlueSize* = 0x000080DC
  GlColorTableAlphaSize* = 0x000080DD
  GlColorTableLuminanceSize* = 0x000080DE
  GlColorTableIntensitySize* = 0x000080DF
  GlConstantBorder* = 0x00008151
  GlReplicateBorder* = 0x00008153
  GlConvolutionBorderColor* = 0x00008154 # GL_ARB_matrix_palette
  GlMatrixPaletteArb* = 0x00008840
  GlMaxMatrixPaletteStackDepthArb* = 0x00008841
  GlMaxPaletteMatricesArb* = 0x00008842
  cGLCURRENTPALETTEMATRIXARB* = 0x00008843
  GlMatrixIndexArrayArb* = 0x00008844
  GlCurrentMatrixIndexArb* = 0x00008845
  GlMatrixIndexArraySizeArb* = 0x00008846
  GLMATRIXINDEXARRAYtypARB* = 0x00008847
  GlMatrixIndexArrayStrideArb* = 0x00008848
  GlMatrixIndexArrayPointerArb* = 0x00008849 # GL_ARB_multisample
  GlMultisampleArb* = 0x0000809D
  GlSampleAlphaToCoverageArb* = 0x0000809E
  GlSampleAlphaToOneArb* = 0x0000809F
  cGLSAMPLECOVERAGEARB* = 0x000080A0
  GlSampleBuffersArb* = 0x000080A8
  GlSamplesArb* = 0x000080A9
  GlSampleCoverageValueArb* = 0x000080AA
  GlSampleCoverageInvertArb* = 0x000080AB
  GlMultisampleBitArb* = 0x20000000 # GL_ARB_multitexture
  GlTexture0Arb* = 0x000084C0
  GlTexture1Arb* = 0x000084C1
  GlTexture2Arb* = 0x000084C2
  GlTexture3Arb* = 0x000084C3
  GlTexture4Arb* = 0x000084C4
  GlTexture5Arb* = 0x000084C5
  GlTexture6Arb* = 0x000084C6
  GlTexture7Arb* = 0x000084C7
  GlTexture8Arb* = 0x000084C8
  GlTexture9Arb* = 0x000084C9
  GlTexture10Arb* = 0x000084CA
  GlTexture11Arb* = 0x000084CB
  GlTexture12Arb* = 0x000084CC
  GlTexture13Arb* = 0x000084CD
  GlTexture14Arb* = 0x000084CE
  GlTexture15Arb* = 0x000084CF
  GlTexture16Arb* = 0x000084D0
  GlTexture17Arb* = 0x000084D1
  GlTexture18Arb* = 0x000084D2
  GlTexture19Arb* = 0x000084D3
  GlTexture20Arb* = 0x000084D4
  GlTexture21Arb* = 0x000084D5
  GlTexture22Arb* = 0x000084D6
  GlTexture23Arb* = 0x000084D7
  GlTexture24Arb* = 0x000084D8
  GlTexture25Arb* = 0x000084D9
  GlTexture26Arb* = 0x000084DA
  GlTexture27Arb* = 0x000084DB
  GlTexture28Arb* = 0x000084DC
  GlTexture29Arb* = 0x000084DD
  GlTexture30Arb* = 0x000084DE
  GlTexture31Arb* = 0x000084DF
  cGLACTIVETEXTUREARB* = 0x000084E0
  cGLCLIENTACTIVETEXTUREARB* = 0x000084E1
  GlMaxTextureUnitsArb* = 0x000084E2 # GL_ARB_point_parameters
  GlPointSizeMinArb* = 0x00008126
  GlPointSizeMaxArb* = 0x00008127
  GlPointFadeThresholdSizeArb* = 0x00008128
  GlPointDistanceAttenuationArb* = 0x00008129 # GL_ARB_shadow
  GlTextureCompareModeArb* = 0x0000884C
  GlTextureCompareFuncArb* = 0x0000884D
  GlCompareRToTextureArb* = 0x0000884E # GL_ARB_shadow_ambient
  GlTextureCompareFailValueArb* = 0x000080BF # GL_ARB_texture_border_clamp
  GlClampToBorderArb* = 0x0000812D # GL_ARB_texture_compression
  GlCompressedAlphaArb* = 0x000084E9
  GlCompressedLuminanceArb* = 0x000084EA
  GlCompressedLuminanceAlphaArb* = 0x000084EB
  GlCompressedIntensityArb* = 0x000084EC
  GlCompressedRgbArb* = 0x000084ED
  GlCompressedRgbaArb* = 0x000084EE
  GlTextureCompressionHintArb* = 0x000084EF
  GlTextureCompressedImageSizeArb* = 0x000086A0
  GlTextureCompressedArb* = 0x000086A1
  GlNumCompressedTextureFormatsArb* = 0x000086A2
  GlCompressedTextureFormatsArb* = 0x000086A3 # GL_ARB_texture_cube_map
  GlNormalMapArb* = 0x00008511
  GlReflectionMapArb* = 0x00008512
  GlTextureCubeMapArb* = 0x00008513
  GlTextureBindingCubeMapArb* = 0x00008514
  GlTextureCubeMapPositiveXArb* = 0x00008515
  GlTextureCubeMapNegativeXArb* = 0x00008516
  GlTextureCubeMapPositiveYArb* = 0x00008517
  GlTextureCubeMapNegativeYArb* = 0x00008518
  GlTextureCubeMapPositiveZArb* = 0x00008519
  GlTextureCubeMapNegativeZArb* = 0x0000851A
  GlProxyTextureCubeMapArb* = 0x0000851B
  GlMaxCubeMapTextureSizeArb* = 0x0000851C # GL_ARB_texture_env_combine
  GlCombineArb* = 0x00008570
  GlCombineRgbArb* = 0x00008571
  GlCombineAlphaArb* = 0x00008572
  GlSource0RgbArb* = 0x00008580
  GlSource1RgbArb* = 0x00008581
  GlSource2RgbArb* = 0x00008582
  GlSource0AlphaArb* = 0x00008588
  GlSource1AlphaArb* = 0x00008589
  GlSource2AlphaArb* = 0x0000858A
  GlOperand0RgbArb* = 0x00008590
  GlOperand1RgbArb* = 0x00008591
  GlOperand2RgbArb* = 0x00008592
  GlOperand0AlphaArb* = 0x00008598
  GlOperand1AlphaArb* = 0x00008599
  GlOperand2AlphaArb* = 0x0000859A
  GlRgbScaleArb* = 0x00008573
  GlAddSignedArb* = 0x00008574
  GlInterpolateArb* = 0x00008575
  GlSubtractArb* = 0x000084E7
  GlConstantArb* = 0x00008576
  GlPrimaryColorArb* = 0x00008577
  GlPreviousArb* = 0x00008578 # GL_ARB_texture_env_dot3
  GlDot3RgbArb* = 0x000086AE
  GlDot3RgbaArb* = 0x000086AF # GL_ARB_texture_mirrored_repeat
  GlMirroredRepeatArb* = 0x00008370 # GL_ARB_transpose_matrix
  GlTransposeModelviewMatrixArb* = 0x000084E3
  GlTransposeProjectionMatrixArb* = 0x000084E4
  GlTransposeTextureMatrixArb* = 0x000084E5
  GlTransposeColorMatrixArb* = 0x000084E6 # GL_ARB_vertex_blend
  GlMaxVertexUnitsArb* = 0x000086A4
  GlActiveVertexUnitsArb* = 0x000086A5
  GlWeightSumUnityArb* = 0x000086A6
  cGLVERTEXBLENDARB* = 0x000086A7
  GlCurrentWeightArb* = 0x000086A8
  GLWEIGHTARRAYtypARB* = 0x000086A9
  GlWeightArrayStrideArb* = 0x000086AA
  GlWeightArraySizeArb* = 0x000086AB
  GlWeightArrayPointerArb* = 0x000086AC
  GlWeightArrayArb* = 0x000086AD
  GlModelview0Arb* = 0x00001700
  GlModelview1Arb* = 0x0000850A
  GlModelview2Arb* = 0x00008722
  GlModelview3Arb* = 0x00008723
  GlModelview4Arb* = 0x00008724
  GlModelview5Arb* = 0x00008725
  GlModelview6Arb* = 0x00008726
  GlModelview7Arb* = 0x00008727
  GlModelview8Arb* = 0x00008728
  GlModelview9Arb* = 0x00008729
  GlModelview10Arb* = 0x0000872A
  GlModelview11Arb* = 0x0000872B
  GlModelview12Arb* = 0x0000872C
  GlModelview13Arb* = 0x0000872D
  GlModelview14Arb* = 0x0000872E
  GlModelview15Arb* = 0x0000872F
  GlModelview16Arb* = 0x00008730
  GlModelview17Arb* = 0x00008731
  GlModelview18Arb* = 0x00008732
  GlModelview19Arb* = 0x00008733
  GlModelview20Arb* = 0x00008734
  GlModelview21Arb* = 0x00008735
  GlModelview22Arb* = 0x00008736
  GlModelview23Arb* = 0x00008737
  GlModelview24Arb* = 0x00008738
  GlModelview25Arb* = 0x00008739
  GlModelview26Arb* = 0x0000873A
  GlModelview27Arb* = 0x0000873B
  GlModelview28Arb* = 0x0000873C
  GlModelview29Arb* = 0x0000873D
  GlModelview30Arb* = 0x0000873E
  GlModelview31Arb* = 0x0000873F # GL_ARB_vertex_buffer_object
  GlBufferSizeArb* = 0x00008764
  GlBufferUsageArb* = 0x00008765
  GlArrayBufferArb* = 0x00008892
  GlElementArrayBufferArb* = 0x00008893
  GlArrayBufferBindingArb* = 0x00008894
  GlElementArrayBufferBindingArb* = 0x00008895
  GlVertexArrayBufferBindingArb* = 0x00008896
  GlNormalArrayBufferBindingArb* = 0x00008897
  GlColorArrayBufferBindingArb* = 0x00008898
  GlIndexArrayBufferBindingArb* = 0x00008899
  GlTextureCoordArrayBufferBindingArb* = 0x0000889A
  GlEdgeFlagArrayBufferBindingArb* = 0x0000889B
  GlSecondaryColorArrayBufferBindingArb* = 0x0000889C
  GlFogCoordinateArrayBufferBindingArb* = 0x0000889D
  GlWeightArrayBufferBindingArb* = 0x0000889E
  GlVertexAttribArrayBufferBindingArb* = 0x0000889F
  GlReadOnlyArb* = 0x000088B8
  GlWriteOnlyArb* = 0x000088B9
  GlReadWriteArb* = 0x000088BA
  GlBufferAccessArb* = 0x000088BB
  GlBufferMappedArb* = 0x000088BC
  GlBufferMapPointerArb* = 0x000088BD
  GlStreamDrawArb* = 0x000088E0
  GlStreamReadArb* = 0x000088E1
  GlStreamCopyArb* = 0x000088E2
  GlStaticDrawArb* = 0x000088E4
  GlStaticReadArb* = 0x000088E5
  GlStaticCopyArb* = 0x000088E6
  GlDynamicDrawArb* = 0x000088E8
  GlDynamicReadArb* = 0x000088E9
  GlDynamicCopyArb* = 0x000088EA # GL_ARB_vertex_program
  GlColorSumArb* = 0x00008458
  GlVertexProgramArb* = 0x00008620
  GlVertexAttribArrayEnabledArb* = 0x00008622
  GlVertexAttribArraySizeArb* = 0x00008623
  GlVertexAttribArrayStrideArb* = 0x00008624
  GLVERTEXATTRIBARRAYtypARB* = 0x00008625
  GlCurrentVertexAttribArb* = 0x00008626
  GlProgramLengthArb* = 0x00008627
  cGLPROGRAMSTRINGARB* = 0x00008628
  GlMaxProgramMatrixStackDepthArb* = 0x0000862E
  GlMaxProgramMatricesArb* = 0x0000862F
  GlCurrentMatrixStackDepthArb* = 0x00008640
  GlCurrentMatrixArb* = 0x00008641
  GlVertexProgramPointSizeArb* = 0x00008642
  GlVertexProgramTwoSideArb* = 0x00008643
  GlVertexAttribArrayPointerArb* = 0x00008645
  GlProgramErrorPositionArb* = 0x0000864B
  GlProgramBindingArb* = 0x00008677
  GlMaxVertexAttribsArb* = 0x00008869
  GlVertexAttribArrayNormalizedArb* = 0x0000886A
  GlProgramErrorStringArb* = 0x00008874
  GlProgramFormatAsciiArb* = 0x00008875
  GlProgramFormatArb* = 0x00008876
  GlProgramInstructionsArb* = 0x000088A0
  GlMaxProgramInstructionsArb* = 0x000088A1
  GlProgramNativeInstructionsArb* = 0x000088A2
  GlMaxProgramNativeInstructionsArb* = 0x000088A3
  GlProgramTemporariesArb* = 0x000088A4
  GlMaxProgramTemporariesArb* = 0x000088A5
  GlProgramNativeTemporariesArb* = 0x000088A6
  GlMaxProgramNativeTemporariesArb* = 0x000088A7
  GlProgramParametersArb* = 0x000088A8
  GlMaxProgramParametersArb* = 0x000088A9
  GlProgramNativeParametersArb* = 0x000088AA
  GlMaxProgramNativeParametersArb* = 0x000088AB
  GlProgramAttribsArb* = 0x000088AC
  GlMaxProgramAttribsArb* = 0x000088AD
  GlProgramNativeAttribsArb* = 0x000088AE
  GlMaxProgramNativeAttribsArb* = 0x000088AF
  GlProgramAddressRegistersArb* = 0x000088B0
  GlMaxProgramAddressRegistersArb* = 0x000088B1
  GlProgramNativeAddressRegistersArb* = 0x000088B2
  GlMaxProgramNativeAddressRegistersArb* = 0x000088B3
  GlMaxProgramLocalParametersArb* = 0x000088B4
  GlMaxProgramEnvParametersArb* = 0x000088B5
  GlProgramUnderNativeLimitsArb* = 0x000088B6
  GlTransposeCurrentMatrixArb* = 0x000088B7
  GlMatrix0Arb* = 0x000088C0
  GlMatrix1Arb* = 0x000088C1
  GlMatrix2Arb* = 0x000088C2
  GlMatrix3Arb* = 0x000088C3
  GlMatrix4Arb* = 0x000088C4
  GlMatrix5Arb* = 0x000088C5
  GlMatrix6Arb* = 0x000088C6
  GlMatrix7Arb* = 0x000088C7
  GlMatrix8Arb* = 0x000088C8
  GlMatrix9Arb* = 0x000088C9
  GlMatrix10Arb* = 0x000088CA
  GlMatrix11Arb* = 0x000088CB
  GlMatrix12Arb* = 0x000088CC
  GlMatrix13Arb* = 0x000088CD
  GlMatrix14Arb* = 0x000088CE
  GlMatrix15Arb* = 0x000088CF
  GlMatrix16Arb* = 0x000088D0
  GlMatrix17Arb* = 0x000088D1
  GlMatrix18Arb* = 0x000088D2
  GlMatrix19Arb* = 0x000088D3
  GlMatrix20Arb* = 0x000088D4
  GlMatrix21Arb* = 0x000088D5
  GlMatrix22Arb* = 0x000088D6
  GlMatrix23Arb* = 0x000088D7
  GlMatrix24Arb* = 0x000088D8
  GlMatrix25Arb* = 0x000088D9
  GlMatrix26Arb* = 0x000088DA
  GlMatrix27Arb* = 0x000088DB
  GlMatrix28Arb* = 0x000088DC
  GlMatrix29Arb* = 0x000088DD
  GlMatrix30Arb* = 0x000088DE
  GlMatrix31Arb* = 0x000088DF # GL_ARB_draw_buffers
  GlMaxDrawBuffersArb* = 0x00008824
  GlDrawBuffer0Arb* = 0x00008825
  GlDrawBuffer1Arb* = 0x00008826
  GlDrawBuffer2Arb* = 0x00008827
  GlDrawBuffer3Arb* = 0x00008828
  GlDrawBuffer4Arb* = 0x00008829
  GlDrawBuffer5Arb* = 0x0000882A
  GlDrawBuffer6Arb* = 0x0000882B
  GlDrawBuffer7Arb* = 0x0000882C
  GlDrawBuffer8Arb* = 0x0000882D
  GlDrawBuffer9Arb* = 0x0000882E
  GlDrawBuffer10Arb* = 0x0000882F
  GlDrawBuffer11Arb* = 0x00008830
  GlDrawBuffer12Arb* = 0x00008831
  GlDrawBuffer13Arb* = 0x00008832
  GlDrawBuffer14Arb* = 0x00008833
  GlDrawBuffer15Arb* = 0x00008834 # GL_ARB_texture_rectangle
  GlTextureRectangleArb* = 0x000084F5
  GlTextureBindingRectangleArb* = 0x000084F6
  GlProxyTextureRectangleArb* = 0x000084F7
  GlMaxRectangleTextureSizeArb* = 0x000084F8 # GL_ARB_color_buffer_float
  GlRgbaFloatModeArb* = 0x00008820
  GlClampVertexColorArb* = 0x0000891A
  GlClampFragmentColorArb* = 0x0000891B
  GlClampReadColorArb* = 0x0000891C
  GlFixedOnlyArb* = 0x0000891D
  WGLtypRGBAFLOATARB* = 0x000021A0
  GLXRGBAFLOATtyp* = 0x000020B9
  GlxRgbaFloatBit* = 0x00000004 # GL_ARB_half_float_pixel
  GlHalfFloatArb* = 0x0000140B # GL_ARB_texture_float
  GLTEXTUREREDtypARB* = 0x00008C10
  GLTEXTUREGREENtypARB* = 0x00008C11
  GLTEXTUREBLUEtypARB* = 0x00008C12
  GLTEXTUREALPHAtypARB* = 0x00008C13
  GLTEXTURELUMINANCEtypARB* = 0x00008C14
  GLTEXTUREINTENSITYtypARB* = 0x00008C15
  GLTEXTUREDEPTHtypARB* = 0x00008C16
  GlUnsignedNormalizedArb* = 0x00008C17
  GlRgba32fArb* = 0x00008814
  GlRgb32fArb* = 0x00008815
  GlAlpha32fArb* = 0x00008816
  GlIntensity32fArb* = 0x00008817
  GlLuminance32fArb* = 0x00008818
  GlLuminanceAlpha32fArb* = 0x00008819
  GlRgba16fArb* = 0x0000881A
  GlRgb16fArb* = 0x0000881B
  GlAlpha16fArb* = 0x0000881C
  GlIntensity16fArb* = 0x0000881D
  GlLuminance16fArb* = 0x0000881E
  GlLuminanceAlpha16fArb* = 0x0000881F # GL_ARB_pixel_buffer_object
  GlPixelPackBufferArb* = 0x000088EB
  GlPixelUnpackBufferArb* = 0x000088EC
  GlPixelPackBufferBindingArb* = 0x000088ED
  GlPixelUnpackBufferBindingArb* = 0x000088EF # GL_ARB_depth_buffer_float
  GlDepthComponent32f* = 0x00008CAC
  GlDepth32fStencil8* = 0x00008CAD
  GlFloat32UnsignedInt248Rev* = 0x00008DAD # GL_ARB_framebuffer_object
  GlInvalidFramebufferOperation* = 0x00000506
  GlFramebufferAttachmentColorEncoding* = 0x00008210
  GLFRAMEBUFFERATTACHMENTCOMPONENTtyp* = 0x00008211
  GlFramebufferAttachmentRedSize* = 0x00008212
  GlFramebufferAttachmentGreenSize* = 0x00008213
  GlFramebufferAttachmentBlueSize* = 0x00008214
  GlFramebufferAttachmentAlphaSize* = 0x00008215
  GlFramebufferAttachmentDepthSize* = 0x00008216
  GlFramebufferAttachmentStencilSize* = 0x00008217
  GlFramebufferDefault* = 0x00008218
  GlFramebufferUndefined* = 0x00008219
  GlDepthStencilAttachment* = 0x0000821A
  GlMaxRenderbufferSize* = 0x000084E8
  GlDepthStencil* = 0x000084F9
  GlUnsignedInt248* = 0x000084FA
  GlDepth24Stencil8* = 0x000088F0
  GlTextureStencilSize* = 0x000088F1
  GLTEXTUREREDtyp* = 0x00008C10
  GLTEXTUREGREENtyp* = 0x00008C11
  GLTEXTUREBLUEtyp* = 0x00008C12
  GLTEXTUREALPHAtyp* = 0x00008C13
  GLTEXTUREDEPTHtyp* = 0x00008C16
  GlUnsignedNormalized* = 0x00008C17
  GlFramebufferBinding* = 0x00008CA6
  GlDrawFramebufferBinding* = GL_FRAMEBUFFER_BINDING
  GlRenderbufferBinding* = 0x00008CA7
  GlReadFramebuffer* = 0x00008CA8
  GlDrawFramebuffer* = 0x00008CA9
  GlReadFramebufferBinding* = 0x00008CAA
  GlRenderbufferSamples* = 0x00008CAB
  GLFRAMEBUFFERATTACHMENTOBJECTtyp* = 0x00008CD0
  GlFramebufferAttachmentObjectName* = 0x00008CD1
  GlFramebufferAttachmentTextureLevel* = 0x00008CD2
  GlFramebufferAttachmentTextureCubeMapFace* = 0x00008CD3
  GlFramebufferAttachmentTextureLayer* = 0x00008CD4
  GlFramebufferComplete* = 0x00008CD5
  GlFramebufferIncompleteAttachment* = 0x00008CD6
  GlFramebufferIncompleteMissingAttachment* = 0x00008CD7
  GlFramebufferIncompleteDrawBuffer* = 0x00008CDB
  GlFramebufferIncompleteReadBuffer* = 0x00008CDC
  GlFramebufferUnsupported* = 0x00008CDD
  GlMaxColorAttachments* = 0x00008CDF
  GlColorAttachment0* = 0x00008CE0
  GlColorAttachment1* = 0x00008CE1
  GlColorAttachment2* = 0x00008CE2
  GlColorAttachment3* = 0x00008CE3
  GlColorAttachment4* = 0x00008CE4
  GlColorAttachment5* = 0x00008CE5
  GlColorAttachment6* = 0x00008CE6
  GlColorAttachment7* = 0x00008CE7
  GlColorAttachment8* = 0x00008CE8
  GlColorAttachment9* = 0x00008CE9
  GlColorAttachment10* = 0x00008CEA
  GlColorAttachment11* = 0x00008CEB
  GlColorAttachment12* = 0x00008CEC
  GlColorAttachment13* = 0x00008CED
  GlColorAttachment14* = 0x00008CEE
  GlColorAttachment15* = 0x00008CEF
  GlDepthAttachment* = 0x00008D00
  GlStencilAttachment* = 0x00008D20
  GlFramebuffer* = 0x00008D40
  GlRenderbuffer* = 0x00008D41
  GlRenderbufferWidth* = 0x00008D42
  GlRenderbufferHeight* = 0x00008D43
  GlRenderbufferInternalFormat* = 0x00008D44
  GlStencilIndex1* = 0x00008D46
  GlStencilIndex4* = 0x00008D47
  GlStencilIndex8* = 0x00008D48
  GlStencilIndex16* = 0x00008D49
  GlRenderbufferRedSize* = 0x00008D50
  GlRenderbufferGreenSize* = 0x00008D51
  GlRenderbufferBlueSize* = 0x00008D52
  GlRenderbufferAlphaSize* = 0x00008D53
  GlRenderbufferDepthSize* = 0x00008D54
  GlRenderbufferStencilSize* = 0x00008D55
  GlFramebufferIncompleteMultisample* = 0x00008D56
  GlMaxSamples* = 0x00008D57
  GlIndex* = 0x00008222
  GLTEXTURELUMINANCEtyp* = 0x00008C14
  GLTEXTUREINTENSITYtyp* = 0x00008C15 # GL_ARB_framebuffer_sRGB
  GlFramebufferSrgb* = 0x00008DB9 # GL_ARB_geometry_shader4
  GlLinesAdjacencyArb* = 0x0000000A
  GlLineStripAdjacencyArb* = 0x0000000B
  GlTrianglesAdjacencyArb* = 0x0000000C
  GlTriangleStripAdjacencyArb* = 0x0000000D
  GlProgramPointSizeArb* = 0x00008642
  GlMaxGeometryTextureImageUnitsArb* = 0x00008C29
  GlFramebufferAttachmentLayeredArb* = 0x00008DA7
  GlFramebufferIncompleteLayerTargetsArb* = 0x00008DA8
  GlFramebufferIncompleteLayerCountArb* = 0x00008DA9
  GlGeometryShaderArb* = 0x00008DD9
  GlGeometryVerticesOutArb* = 0x00008DDA
  GLGEOMETRYINPUTtypARB* = 0x00008DDB
  GLGEOMETRYOUTPUTtypARB* = 0x00008DDC
  GlMaxGeometryVaryingComponentsArb* = 0x00008DDD
  GlMaxVertexVaryingComponentsArb* = 0x00008DDE
  GlMaxGeometryUniformComponentsArb* = 0x00008DDF
  GlMaxGeometryOutputVerticesArb* = 0x00008DE0
  GlMaxGeometryTotalOutputComponentsArb* = 0x00008DE1 # reuse 
                                                            # GL_MAX_VARYING_COMPONENTS 
                                                            # reuse 
                                                            # GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER 
                                                            # 
                                                            # GL_ARB_half_float_vertex
  GlHalfFloat* = 0x0000140B # GL_ARB_instanced_arrays
  GlVertexAttribArrayDivisorArb* = 0x000088FE # GL_ARB_map_buffer_range
  GlMapReadBit* = 0x00000001
  GlMapWriteBit* = 0x00000002
  GlMapInvalidateRangeBit* = 0x00000004
  GlMapInvalidateBufferBit* = 0x00000008
  GlMapFlushExplicitBit* = 0x00000010
  GlMapUnsynchronizedBit* = 0x00000020 # GL_ARB_texture_buffer_object
  GlTextureBufferArb* = 0x00008C2A
  GlMaxTextureBufferSizeArb* = 0x00008C2B
  GlTextureBindingBufferArb* = 0x00008C2C
  GlTextureBufferDataStoreBindingArb* = 0x00008C2D
  GlTextureBufferFormatArb* = 0x00008C2E # GL_ARB_texture_compression_rgtc
  GlCompressedRedRgtc1* = 0x00008DBB
  GlCompressedSignedRedRgtc1* = 0x00008DBC
  GlCompressedRgRgtc2* = 0x00008DBD
  GlCompressedSignedRgRgtc2* = 0x00008DBE # GL_ARB_texture_rg
  GlRg* = 0x00008227
  GlRgInteger* = 0x00008228
  GlR8* = 0x00008229
  GlR16* = 0x0000822A
  GlRg8* = 0x0000822B
  GlRg16* = 0x0000822C
  GlR16f* = 0x0000822D
  GlR32f* = 0x0000822E
  GlRg16f* = 0x0000822F
  GlRg32f* = 0x00008230
  GlR8i* = 0x00008231
  GlR8ui* = 0x00008232
  GlR16i* = 0x00008233
  GlR16ui* = 0x00008234
  GlR32i* = 0x00008235
  GlR32ui* = 0x00008236
  GlRg8i* = 0x00008237
  GlRg8ui* = 0x00008238
  GlRg16i* = 0x00008239
  GlRg16ui* = 0x0000823A
  GlRg32i* = 0x0000823B
  GlRg32ui* = 0x0000823C     # GL_ARB_vertex_array_object
  GlVertexArrayBinding* = 0x000085B5 # GL_ARB_uniform_buffer_object
  GlUniformBuffer* = 0x00008A11
  GlUniformBufferBinding* = 0x00008A28
  GlUniformBufferStart* = 0x00008A29
  GlUniformBufferSize* = 0x00008A2A
  GlMaxVertexUniformBlocks* = 0x00008A2B
  GlMaxGeometryUniformBlocks* = 0x00008A2C
  GlMaxFragmentUniformBlocks* = 0x00008A2D
  GlMaxCombinedUniformBlocks* = 0x00008A2E
  GlMaxUniformBufferBindings* = 0x00008A2F
  GlMaxUniformBlockSize* = 0x00008A30
  GlMaxCombinedVertexUniformComponents* = 0x00008A31
  GlMaxCombinedGeometryUniformComponents* = 0x00008A32
  GlMaxCombinedFragmentUniformComponents* = 0x00008A33
  GlUniformBufferOffsetAlignment* = 0x00008A34
  GlActiveUniformBlockMaxNameLength* = 0x00008A35
  GlActiveUniformBlocks* = 0x00008A36
  GLUNIFORMtyp* = 0x00008A37
  GlUniformSize* = 0x00008A38
  GlUniformNameLength* = 0x00008A39
  GlUniformBlockIndex* = 0x00008A3A
  GlUniformOffset* = 0x00008A3B
  GlUniformArrayStride* = 0x00008A3C
  GlUniformMatrixStride* = 0x00008A3D
  GlUniformIsRowMajor* = 0x00008A3E
  cGLUNIFORMBLOCKBINDING* = 0x00008A3F
  GlUniformBlockDataSize* = 0x00008A40
  GlUniformBlockNameLength* = 0x00008A41
  GlUniformBlockActiveUniforms* = 0x00008A42
  GlUniformBlockActiveUniformIndices* = 0x00008A43
  GlUniformBlockReferencedByVertexShader* = 0x00008A44
  GlUniformBlockReferencedByGeometryShader* = 0x00008A45
  GlUniformBlockReferencedByFragmentShader* = 0x00008A46
  GlInvalidIndex* = 0xFFFFFFFF # GL_ARB_compatibility
                                 # ARB_compatibility just defines tokens from core 3.0 
                                 # GL_ARB_copy_buffer
  GlCopyReadBuffer* = 0x00008F36
  GlCopyWriteBuffer* = 0x00008F37 # GL_ARB_depth_clamp
  GlDepthClamp* = 0x0000864F # GL_ARB_provoking_vertex
  GlQuadsFollowProvokingVertexConvention* = 0x00008E4C
  GlFirstVertexConvention* = 0x00008E4D
  GlLastVertexConvention* = 0x00008E4E
  cGLPROVOKINGVERTEX* = 0x00008E4F # GL_ARB_seamless_cube_map
  GlTextureCubeMapSeamless* = 0x0000884F # GL_ARB_sync
  GlMaxServerWaitTimeout* = 0x00009111
  GLOBJECTtyp* = 0x00009112
  GlSyncCondition* = 0x00009113
  GlSyncStatus* = 0x00009114
  GlSyncFlags* = 0x00009115
  GlSyncFence* = 0x00009116
  GlSyncGpuCommandsComplete* = 0x00009117
  GlUnsignaled* = 0x00009118
  GlSignaled* = 0x00009119
  GlAlreadySignaled* = 0x0000911A
  GlTimeoutExpired* = 0x0000911B
  GlConditionSatisfied* = 0x0000911C
  GlWaitFailed* = 0x0000911D
  GlSyncFlushCommandsBit* = 0x00000001
  GlTimeoutIgnored* = int64(- 1) # GL_ARB_texture_multisample
  GlSamplePosition* = 0x00008E50
  GlSampleMask* = 0x00008E51
  GlSampleMaskValue* = 0x00008E52
  GlMaxSampleMaskWords* = 0x00008E59
  GlTexture2dMultisample* = 0x00009100
  GlProxyTexture2dMultisample* = 0x00009101
  GlTexture2dMultisampleArray* = 0x00009102
  GlProxyTexture2dMultisampleArray* = 0x00009103
  GlTextureBinding2dMultisample* = 0x00009104
  GlTextureBinding2dMultisampleArray* = 0x00009105
  GlTextureSamples* = 0x00009106
  GlTextureFixedSampleLocations* = 0x00009107
  GlSampler2dMultisample* = 0x00009108
  GlIntSampler2dMultisample* = 0x00009109
  GlUnsignedIntSampler2dMultisample* = 0x0000910A
  GlSampler2dMultisampleArray* = 0x0000910B
  GlIntSampler2dMultisampleArray* = 0x0000910C
  GlUnsignedIntSampler2dMultisampleArray* = 0x0000910D
  GlMaxColorTextureSamples* = 0x0000910E
  GlMaxDepthTextureSamples* = 0x0000910F
  GlMaxIntegerSamples* = 0x00009110 # GL_ARB_vertex_array_bgra
                                       # reuse GL_BGRA 
                                       # GL_ARB_sample_shading
  GlSampleShadingArb* = 0x00008C36
  GlMinSampleShadingValueArb* = 0x00008C37 # GL_ARB_texture_cube_map_array
  GlTextureCubeMapArrayArb* = 0x00009009
  GlTextureBindingCubeMapArrayArb* = 0x0000900A
  GlProxyTextureCubeMapArrayArb* = 0x0000900B
  GlSamplerCubeMapArrayArb* = 0x0000900C
  GlSamplerCubeMapArrayShadowArb* = 0x0000900D
  GlIntSamplerCubeMapArrayArb* = 0x0000900E
  GlUnsignedIntSamplerCubeMapArrayArb* = 0x0000900F # GL_ARB_texture_gather
  GlMinProgramTextureGatherOffsetArb* = 0x00008E5E
  GlMaxProgramTextureGatherOffsetArb* = 0x00008E5F # 
                                                         # GL_ARB_shading_language_include
  GlShaderIncludeArb* = 0x00008DAE
  GlNamedStringLengthArb* = 0x00008DE9
  GLNAMEDSTRINGtypARB* = 0x00008DEA # GL_ARB_texture_compression_bptc
  GlCompressedRgbaBptcUnormArb* = 0x00008E8C
  GlCompressedSrgbAlphaBptcUnormArb* = 0x00008E8D
  GlCompressedRgbBptcSignedFloatArb* = 0x00008E8E
  GlCompressedRgbBptcUnsignedFloatArb* = 0x00008E8F # 
                                                          # GL_ARB_blend_func_extended
  GlSrc1Color* = 0x000088F9 # reuse GL_SRC1_ALPHA 
  GlOneMinusSrc1Color* = 0x000088FA
  GlOneMinusSrc1Alpha* = 0x000088FB
  GlMaxDualSourceDrawBuffers* = 0x000088FC # GL_ARB_occlusion_query2
  GlAnySamplesPassed* = 0x00008C2F # GL_ARB_sampler_objects
  GlSamplerBinding* = 0x00008919 # GL_ARB_texture_rgb10_a2ui
  GlRgb10A2ui* = 0x0000906F # GL_ARB_texture_swizzle
  GlTextureSwizzleR* = 0x00008E42
  GlTextureSwizzleG* = 0x00008E43
  GlTextureSwizzleB* = 0x00008E44
  GlTextureSwizzleA* = 0x00008E45
  GlTextureSwizzleRgba* = 0x00008E46 # GL_ARB_timer_query
  GlTimeElapsed* = 0x000088BF
  GlTimestamp* = 0x00008E28  # GL_ARB_vertextyp_2_10_10_10_rev
                              # reuse GL_UNSIGNED_INT_2_10_10_10_REV 
  GlInt2101010Rev* = 0x00008D9F # GL_ARB_draw_indirect
  GlDrawIndirectBuffer* = 0x00008F3F
  GlDrawIndirectBufferBinding* = 0x00008F43 # GL_ARB_gpu_shader5
  GlGeometryShaderInvocations* = 0x0000887F
  GlMaxGeometryShaderInvocations* = 0x00008E5A
  GlMinFragmentInterpolationOffset* = 0x00008E5B
  GlMaxFragmentInterpolationOffset* = 0x00008E5C
  GlFragmentInterpolationOffsetBits* = 0x00008E5D # reuse GL_MAX_VERTEX_STREAMS 
                                                      # GL_ARB_gpu_shader_fp64
                                                      # reuse GL_DOUBLE 
  GlDoubleVec2* = 0x00008FFC
  GlDoubleVec3* = 0x00008FFD
  GlDoubleVec4* = 0x00008FFE
  GlDoubleMat2* = 0x00008F46
  GlDoubleMat3* = 0x00008F47
  GlDoubleMat4* = 0x00008F48
  GLDOUBLEMAT2x3* = 0x00008F49
  GLDOUBLEMAT2x4* = 0x00008F4A
  GLDOUBLEMAT3x2* = 0x00008F4B
  GLDOUBLEMAT3x4* = 0x00008F4C
  GLDOUBLEMAT4x2* = 0x00008F4D
  GLDOUBLEMAT4x3* = 0x00008F4E # GL_ARB_shader_subroutine
  GlActiveSubroutines* = 0x00008DE5
  GlActiveSubroutineUniforms* = 0x00008DE6
  GlActiveSubroutineUniformLocations* = 0x00008E47
  GlActiveSubroutineMaxLength* = 0x00008E48
  GlActiveSubroutineUniformMaxLength* = 0x00008E49
  GlMaxSubroutines* = 0x00008DE7
  GlMaxSubroutineUniformLocations* = 0x00008DE8
  GlNumCompatibleSubroutines* = 0x00008E4A
  GlCompatibleSubroutines* = 0x00008E4B # GL_ARB_tessellation_shader
  GlPatches* = 0x0000000E
  GlPatchVertices* = 0x00008E72
  GlPatchDefaultInnerLevel* = 0x00008E73
  GlPatchDefaultOuterLevel* = 0x00008E74
  GlTessControlOutputVertices* = 0x00008E75
  GlTessGenMode* = 0x00008E76
  GlTessGenSpacing* = 0x00008E77
  GlTessGenVertexOrder* = 0x00008E78
  GlTessGenPointMode* = 0x00008E79
  GlIsolines* = 0x00008E7A   # reuse GL_EQUAL 
  GlFractionalOdd* = 0x00008E7B
  GlFractionalEven* = 0x00008E7C
  GlMaxPatchVertices* = 0x00008E7D
  GlMaxTessGenLevel* = 0x00008E7E
  GlMaxTessControlUniformComponents* = 0x00008E7F
  GlMaxTessEvaluationUniformComponents* = 0x00008E80
  GlMaxTessControlTextureImageUnits* = 0x00008E81
  GlMaxTessEvaluationTextureImageUnits* = 0x00008E82
  GlMaxTessControlOutputComponents* = 0x00008E83
  GlMaxTessPatchComponents* = 0x00008E84
  GlMaxTessControlTotalOutputComponents* = 0x00008E85
  GlMaxTessEvaluationOutputComponents* = 0x00008E86
  GlMaxTessControlUniformBlocks* = 0x00008E89
  GlMaxTessEvaluationUniformBlocks* = 0x00008E8A
  GlMaxTessControlInputComponents* = 0x0000886C
  GlMaxTessEvaluationInputComponents* = 0x0000886D
  GlMaxCombinedTessControlUniformComponents* = 0x00008E1E
  GlMaxCombinedTessEvaluationUniformComponents* = 0x00008E1F
  GlUniformBlockReferencedByTessControlShader* = 0x000084F0
  GlUniformBlockReferencedByTessEvaluationShader* = 0x000084F1
  GlTessEvaluationShader* = 0x00008E87
  GlTessControlShader* = 0x00008E88 # GL_ARB_texture_buffer_object_rgb32
                                       # GL_ARB_transform_feedback2
  GlTransformFeedback* = 0x00008E22
  GlTransformFeedbackBufferPaused* = 0x00008E23
  GlTransformFeedbackBufferActive* = 0x00008E24
  GlTransformFeedbackBinding* = 0x00008E25 # GL_ARB_transform_feedback3
  GlMaxTransformFeedbackBuffers* = 0x00008E70
  GlMaxVertexStreams* = 0x00008E71 # GL_ARB_ES2_compatibility
  GlFixed* = 0x0000140C
  GLIMPLEMENTATIONCOLORREADtyp* = 0x00008B9A
  GlImplementationColorReadFormat* = 0x00008B9B
  GlLowFloat* = 0x00008DF0
  GlMediumFloat* = 0x00008DF1
  GlHighFloat* = 0x00008DF2
  GlLowInt* = 0x00008DF3
  GlMediumInt* = 0x00008DF4
  GlHighInt* = 0x00008DF5
  GlShaderCompiler* = 0x00008DFA
  GlNumShaderBinaryFormats* = 0x00008DF9
  GlMaxVertexUniformVectors* = 0x00008DFB
  GlMaxVaryingVectors* = 0x00008DFC
  GlMaxFragmentUniformVectors* = 0x00008DFD # GL_ARB_get_program_binary
  GlProgramBinaryRetrievableHint* = 0x00008257
  GlProgramBinaryLength* = 0x00008741
  GlNumProgramBinaryFormats* = 0x000087FE
  GlProgramBinaryFormats* = 0x000087FF # GL_ARB_separate_shader_objects
  GlVertexShaderBit* = 0x00000001
  GlFragmentShaderBit* = 0x00000002
  GlGeometryShaderBit* = 0x00000004
  GlTessControlShaderBit* = 0x00000008
  GlTessEvaluationShaderBit* = 0x00000010
  GlAllShaderBits* = 0xFFFFFFFF
  GlProgramSeparable* = 0x00008258
  GlActiveProgram* = 0x00008259
  GlProgramPipelineBinding* = 0x0000825A # GL_ARB_vertex_attrib_64bit
  GlMaxViewports* = 0x0000825B
  GlViewportSubpixelBits* = 0x0000825C
  GlViewportBoundsRange* = 0x0000825D
  GlLayerProvokingVertex* = 0x0000825E
  GlViewportIndexProvokingVertex* = 0x0000825F
  GlUndefinedVertex* = 0x00008260 # GL_ARB_cl_event
  GlSyncClEventArb* = 0x00008240
  GlSyncClEventCompleteArb* = 0x00008241 # GL_ARB_debug_output
  GlDebugOutputSynchronousArb* = 0x00008242
  GlDebugNextLoggedMessageLengthArb* = 0x00008243
  GlDebugCallbackFunctionArb* = 0x00008244
  GlDebugCallbackUserParamArb* = 0x00008245
  GlDebugSourceApiArb* = 0x00008246
  GlDebugSourceWindowSystemArb* = 0x00008247
  GlDebugSourceShaderCompilerArb* = 0x00008248
  GlDebugSourceThirdPartyArb* = 0x00008249
  GlDebugSourceApplicationArb* = 0x0000824A
  GlDebugSourceOtherArb* = 0x0000824B
  GLDEBUGtypERRORARB* = 0x0000824C
  GLDEBUGtypDEPRECATEDBEHAVIORARB* = 0x0000824D
  GLDEBUGtypUNDEFINEDBEHAVIORARB* = 0x0000824E
  GLDEBUGtypPORTABILITYARB* = 0x0000824F
  GLDEBUGtypPERFORMANCEARB* = 0x00008250
  GLDEBUGtypOTHERARB* = 0x00008251
  GlMaxDebugMessageLengthArb* = 0x00009143
  GlMaxDebugLoggedMessagesArb* = 0x00009144
  GlDebugLoggedMessagesArb* = 0x00009145
  GlDebugSeverityHighArb* = 0x00009146
  GlDebugSeverityMediumArb* = 0x00009147
  GlDebugSeverityLowArb* = 0x00009148 # GL_ARB_robustness
                                          # reuse GL_NO_ERROR 
  GlContextFlagRobustAccessBitArb* = 0x00000004
  GlLoseContextOnResetArb* = 0x00008252
  GlGuiltyContextResetArb* = 0x00008253
  GlInnocentContextResetArb* = 0x00008254
  GlUnknownContextResetArb* = 0x00008255
  GlResetNotificationStrategyArb* = 0x00008256
  GlNoResetNotificationArb* = 0x00008261 #  
                                             #  GL_ARB_compressed_texture_pixel_storage 
  GlUnpackCompressedBlockWidth* = 0x00009127
  GlUnpackCompressedBlockHeight* = 0x00009128
  GlUnpackCompressedBlockDepth* = 0x00009129
  GlUnpackCompressedBlockSize* = 0x0000912A
  GlPackCompressedBlockWidth* = 0x0000912B
  GlPackCompressedBlockHeight* = 0x0000912C
  GlPackCompressedBlockDepth* = 0x0000912D
  GlPackCompressedBlockSize* = 0x0000912E # GL_ARB_internalformat_query
  GlNumSampleCounts* = 0x00009380 # GL_ARB_map_buffer_alignment
  GlMinMapBufferAlignment* = 0x000090BC # GL_ARB_shader_atomic_counters
  GlAtomicCounterBuffer* = 0x000092C0
  GlAtomicCounterBufferBinding* = 0x000092C1
  GlAtomicCounterBufferStart* = 0x000092C2
  GlAtomicCounterBufferSize* = 0x000092C3
  GlAtomicCounterBufferDataSize* = 0x000092C4
  GlAtomicCounterBufferActiveAtomicCounters* = 0x000092C5
  GlAtomicCounterBufferActiveAtomicCounterIndices* = 0x000092C6
  GlAtomicCounterBufferReferencedByVertexShader* = 0x000092C7
  GlAtomicCounterBufferReferencedByTessControlShader* = 0x000092C8
  GlAtomicCounterBufferReferencedByTessEvaluationShader* = 0x000092C9
  GlAtomicCounterBufferReferencedByGeometryShader* = 0x000092CA
  GlAtomicCounterBufferReferencedByFragmentShader* = 0x000092CB
  GlMaxVertexAtomicCounterBuffers* = 0x000092CC
  GlMaxTessControlAtomicCounterBuffers* = 0x000092CD
  GlMaxTessEvaluationAtomicCounterBuffers* = 0x000092CE
  GlMaxGeometryAtomicCounterBuffers* = 0x000092CF
  GlMaxFragmentAtomicCounterBuffers* = 0x000092D0
  GlMaxCombinedAtomicCounterBuffers* = 0x000092D1
  GlMaxVertexAtomicCounters* = 0x000092D2
  GlMaxTessControlAtomicCounters* = 0x000092D3
  GlMaxTessEvaluationAtomicCounters* = 0x000092D4
  GlMaxGeometryAtomicCounters* = 0x000092D5
  GlMaxFragmentAtomicCounters* = 0x000092D6
  GlMaxCombinedAtomicCounters* = 0x000092D7
  GlMaxAtomicCounterBufferSize* = 0x000092D8
  GlMaxAtomicCounterBufferBindings* = 0x000092DC
  GlActiveAtomicCounterBuffers* = 0x000092D9
  GlUniformAtomicCounterBufferIndex* = 0x000092DA
  GlUnsignedIntAtomicCounter* = 0x000092DB # GL_ARB_shader_image_load_store
  GlVertexAttribArrayBarrierBit* = 0x00000001
  GlElementArrayBarrierBit* = 0x00000002
  GlUniformBarrierBit* = 0x00000004
  GlTextureFetchBarrierBit* = 0x00000008
  GlShaderImageAccessBarrierBit* = 0x00000020
  GlCommandBarrierBit* = 0x00000040
  GlPixelBufferBarrierBit* = 0x00000080
  GlTextureUpdateBarrierBit* = 0x00000100
  GlBufferUpdateBarrierBit* = 0x00000200
  GlFramebufferBarrierBit* = 0x00000400
  GlTransformFeedbackBarrierBit* = 0x00000800
  GlAtomicCounterBarrierBit* = 0x00001000
  GlAllBarrierBits* = 0xFFFFFFFF
  GlMaxImageUnits* = 0x00008F38
  GlMaxCombinedImageUnitsAndFragmentOutputs* = 0x00008F39
  GlImageBindingName* = 0x00008F3A
  GlImageBindingLevel* = 0x00008F3B
  GlImageBindingLayered* = 0x00008F3C
  GlImageBindingLayer* = 0x00008F3D
  GlImageBindingAccess* = 0x00008F3E
  GlImage1d* = 0x0000904C
  GlImage2d* = 0x0000904D
  GlImage3d* = 0x0000904E
  GlImage2dRect* = 0x0000904F
  GlImageCube* = 0x00009050
  GlImageBuffer* = 0x00009051
  GlImage1dArray* = 0x00009052
  GlImage2dArray* = 0x00009053
  GlImageCubeMapArray* = 0x00009054
  GlImage2dMultisample* = 0x00009055
  GlImage2dMultisampleArray* = 0x00009056
  GlIntImage1d* = 0x00009057
  GlIntImage2d* = 0x00009058
  GlIntImage3d* = 0x00009059
  GlIntImage2dRect* = 0x0000905A
  GlIntImageCube* = 0x0000905B
  GlIntImageBuffer* = 0x0000905C
  GlIntImage1dArray* = 0x0000905D
  GlIntImage2dArray* = 0x0000905E
  GlIntImageCubeMapArray* = 0x0000905F
  GlIntImage2dMultisample* = 0x00009060
  GlIntImage2dMultisampleArray* = 0x00009061
  GlUnsignedIntImage1d* = 0x00009062
  GlUnsignedIntImage2d* = 0x00009063
  GlUnsignedIntImage3d* = 0x00009064
  GlUnsignedIntImage2dRect* = 0x00009065
  GlUnsignedIntImageCube* = 0x00009066
  GlUnsignedIntImageBuffer* = 0x00009067
  GlUnsignedIntImage1dArray* = 0x00009068
  GlUnsignedIntImage2dArray* = 0x00009069
  GlUnsignedIntImageCubeMapArray* = 0x0000906A
  GlUnsignedIntImage2dMultisample* = 0x0000906B
  GlUnsignedIntImage2dMultisampleArray* = 0x0000906C
  GlMaxImageSamples* = 0x0000906D
  GlImageBindingFormat* = 0x0000906E
  GLIMAGEFORMATCOMPATIBILITYtyp* = 0x000090C7
  GlImageFormatCompatibilityBySize* = 0x000090C8
  GlImageFormatCompatibilityByClass* = 0x000090C9
  GlMaxVertexImageUniforms* = 0x000090CA
  GlMaxTessControlImageUniforms* = 0x000090CB
  GlMaxTessEvaluationImageUniforms* = 0x000090CC
  GlMaxGeometryImageUniforms* = 0x000090CD
  GlMaxFragmentImageUniforms* = 0x000090CE
  GlMaxCombinedImageUniforms* = 0x000090CF # GL_ARB_texture_storage
  GlTextureImmutableFormat* = 0x0000912F # GL_ATI_draw_buffers
  GlMaxDrawBuffersAti* = 0x00008824
  GlDrawBuffer0Ati* = 0x00008825
  GlDrawBuffer1Ati* = 0x00008826
  GlDrawBuffer2Ati* = 0x00008827
  GlDrawBuffer3Ati* = 0x00008828
  GlDrawBuffer4Ati* = 0x00008829
  GlDrawBuffer5Ati* = 0x0000882A
  GlDrawBuffer6Ati* = 0x0000882B
  GlDrawBuffer7Ati* = 0x0000882C
  GlDrawBuffer8Ati* = 0x0000882D
  GlDrawBuffer9Ati* = 0x0000882E
  GlDrawBuffer10Ati* = 0x0000882F
  GlDrawBuffer11Ati* = 0x00008830
  GlDrawBuffer12Ati* = 0x00008831
  GlDrawBuffer13Ati* = 0x00008832
  GlDrawBuffer14Ati* = 0x00008833
  GlDrawBuffer15Ati* = 0x00008834 # GL_ATI_element_array
  GlElementArrayAti* = 0x00008768
  GLELEMENTARRAYtypATI* = 0x00008769
  GlElementArrayPointerAti* = 0x0000876A # GL_ATI_envmap_bumpmap
  GlBumpRotMatrixAti* = 0x00008775
  GlBumpRotMatrixSizeAti* = 0x00008776
  GlBumpNumTexUnitsAti* = 0x00008777
  GlBumpTexUnitsAti* = 0x00008778
  GlDudvAti* = 0x00008779
  GlDu8dv8Ati* = 0x0000877A
  GlBumpEnvmapAti* = 0x0000877B
  GlBumpTargetAti* = 0x0000877C # GL_ATI_fragment_shader
  GlFragmentShaderAti* = 0x00008920
  GlReg0Ati* = 0x00008921
  GlReg1Ati* = 0x00008922
  GlReg2Ati* = 0x00008923
  GlReg3Ati* = 0x00008924
  GlReg4Ati* = 0x00008925
  GlReg5Ati* = 0x00008926
  GlReg6Ati* = 0x00008927
  GlReg7Ati* = 0x00008928
  GlReg8Ati* = 0x00008929
  GlReg9Ati* = 0x0000892A
  GlReg10Ati* = 0x0000892B
  GlReg11Ati* = 0x0000892C
  GlReg12Ati* = 0x0000892D
  GlReg13Ati* = 0x0000892E
  GlReg14Ati* = 0x0000892F
  GlReg15Ati* = 0x00008930
  GlReg16Ati* = 0x00008931
  GlReg17Ati* = 0x00008932
  GlReg18Ati* = 0x00008933
  GlReg19Ati* = 0x00008934
  GlReg20Ati* = 0x00008935
  GlReg21Ati* = 0x00008936
  GlReg22Ati* = 0x00008937
  GlReg23Ati* = 0x00008938
  GlReg24Ati* = 0x00008939
  GlReg25Ati* = 0x0000893A
  GlReg26Ati* = 0x0000893B
  GlReg27Ati* = 0x0000893C
  GlReg28Ati* = 0x0000893D
  GlReg29Ati* = 0x0000893E
  GlReg30Ati* = 0x0000893F
  GlReg31Ati* = 0x00008940
  GlCon0Ati* = 0x00008941
  GlCon1Ati* = 0x00008942
  GlCon2Ati* = 0x00008943
  GlCon3Ati* = 0x00008944
  GlCon4Ati* = 0x00008945
  GlCon5Ati* = 0x00008946
  GlCon6Ati* = 0x00008947
  GlCon7Ati* = 0x00008948
  GlCon8Ati* = 0x00008949
  GlCon9Ati* = 0x0000894A
  GlCon10Ati* = 0x0000894B
  GlCon11Ati* = 0x0000894C
  GlCon12Ati* = 0x0000894D
  GlCon13Ati* = 0x0000894E
  GlCon14Ati* = 0x0000894F
  GlCon15Ati* = 0x00008950
  GlCon16Ati* = 0x00008951
  GlCon17Ati* = 0x00008952
  GlCon18Ati* = 0x00008953
  GlCon19Ati* = 0x00008954
  GlCon20Ati* = 0x00008955
  GlCon21Ati* = 0x00008956
  GlCon22Ati* = 0x00008957
  GlCon23Ati* = 0x00008958
  GlCon24Ati* = 0x00008959
  GlCon25Ati* = 0x0000895A
  GlCon26Ati* = 0x0000895B
  GlCon27Ati* = 0x0000895C
  GlCon28Ati* = 0x0000895D
  GlCon29Ati* = 0x0000895E
  GlCon30Ati* = 0x0000895F
  GlCon31Ati* = 0x00008960
  GlMovAti* = 0x00008961
  GlAddAti* = 0x00008963
  GlMulAti* = 0x00008964
  GlSubAti* = 0x00008965
  GlDot3Ati* = 0x00008966
  GlDot4Ati* = 0x00008967
  GlMadAti* = 0x00008968
  GlLerpAti* = 0x00008969
  GlCndAti* = 0x0000896A
  GlCnd0Ati* = 0x0000896B
  GlDot2AddAti* = 0x0000896C
  GlSecondaryInterpolatorAti* = 0x0000896D
  GlNumFragmentRegistersAti* = 0x0000896E
  GlNumFragmentConstantsAti* = 0x0000896F
  GlNumPassesAti* = 0x00008970
  GlNumInstructionsPerPassAti* = 0x00008971
  GlNumInstructionsTotalAti* = 0x00008972
  GlNumInputInterpolatorComponentsAti* = 0x00008973
  GlNumLoopbackComponentsAti* = 0x00008974
  GlColorAlphaPairingAti* = 0x00008975
  GlSwizzleStrAti* = 0x00008976
  GlSwizzleStqAti* = 0x00008977
  GlSwizzleStrDrAti* = 0x00008978
  GlSwizzleStqDqAti* = 0x00008979
  GlSwizzleStrqAti* = 0x0000897A
  GlSwizzleStrqDqAti* = 0x0000897B
  GlRedBitAti* = 0x00000001
  GlGreenBitAti* = 0x00000002
  GlBlueBitAti* = 0x00000004
  Gl2xBitAti* = 0x00000001
  Gl4xBitAti* = 0x00000002
  Gl8xBitAti* = 0x00000004
  GlHalfBitAti* = 0x00000008
  GlQuarterBitAti* = 0x00000010
  GlEighthBitAti* = 0x00000020
  GlSaturateBitAti* = 0x00000040
  GlCompBitAti* = 0x00000002
  GlNegateBitAti* = 0x00000004
  GlBiasBitAti* = 0x00000008 # GL_ATI_pn_triangles
  GlPnTrianglesAti* = 0x000087F0
  GlMaxPnTrianglesTesselationLevelAti* = 0x000087F1
  GlPnTrianglesPointModeAti* = 0x000087F2
  GlPnTrianglesNormalModeAti* = 0x000087F3
  GlPnTrianglesTesselationLevelAti* = 0x000087F4
  GlPnTrianglesPointModeLinearAti* = 0x000087F5
  GlPnTrianglesPointModeCubicAti* = 0x000087F6
  GlPnTrianglesNormalModeLinearAti* = 0x000087F7
  GlPnTrianglesNormalModeQuadraticAti* = 0x000087F8 # 
                                                          # GL_ATI_separate_stencil
  GlStencilBackFuncAti* = 0x00008800
  GlStencilBackFailAti* = 0x00008801
  GlStencilBackPassDepthFailAti* = 0x00008802
  GlStencilBackPassDepthPassAti* = 0x00008803 # GL_ATI_text_fragment_shader
  GlTextFragmentShaderAti* = 0x00008200 # GL_ATI_texture_env_combine3
  GlModulateAddAti* = 0x00008744
  GlModulateSignedAddAti* = 0x00008745
  GlModulateSubtractAti* = 0x00008746 # GL_ATI_texture_float
  GlRgbaFloat32Ati* = 0x00008814
  GlRgbFloat32Ati* = 0x00008815
  GlAlphaFloat32Ati* = 0x00008816
  GlIntensityFloat32Ati* = 0x00008817
  GlLuminanceFloat32Ati* = 0x00008818
  GlLuminanceAlphaFloat32Ati* = 0x00008819
  GlRgbaFloat16Ati* = 0x0000881A
  GlRgbFloat16Ati* = 0x0000881B
  GlAlphaFloat16Ati* = 0x0000881C
  GlIntensityFloat16Ati* = 0x0000881D
  GlLuminanceFloat16Ati* = 0x0000881E
  GlLuminanceAlphaFloat16Ati* = 0x0000881F # GL_ATI_texture_mirror_once
  GlMirrorClampAti* = 0x00008742
  GlMirrorClampToEdgeAti* = 0x00008743 # GL_ATI_vertex_array_object
  GlStaticAti* = 0x00008760
  GlDynamicAti* = 0x00008761
  GlPreserveAti* = 0x00008762
  GlDiscardAti* = 0x00008763
  GlObjectBufferSizeAti* = 0x00008764
  GlObjectBufferUsageAti* = 0x00008765
  GlArrayObjectBufferAti* = 0x00008766
  GlArrayObjectOffsetAti* = 0x00008767 # GL_ATI_vertex_streams
  GlMaxVertexStreamsAti* = 0x0000876B
  GlVertexStream0Ati* = 0x0000876C
  GlVertexStream1Ati* = 0x0000876D
  GlVertexStream2Ati* = 0x0000876E
  GlVertexStream3Ati* = 0x0000876F
  GlVertexStream4Ati* = 0x00008770
  GlVertexStream5Ati* = 0x00008771
  GlVertexStream6Ati* = 0x00008772
  GlVertexStream7Ati* = 0x00008773
  GlVertexSourceAti* = 0x00008774 # GL_ATI_meminfo
  GlVboFreeMemoryAti* = 0x000087FB
  GlTextureFreeMemoryAti* = 0x000087FC
  GlRenderbufferFreeMemoryAti* = 0x000087FD # GL_AMD_performance_monitor
  GLCOUNTERtypAMD* = 0x00008BC0
  GlCounterRangeAmd* = 0x00008BC1
  GlUnsignedInt64Amd* = 0x00008BC2
  GlPercentageAmd* = 0x00008BC3
  GlPerfmonResultAvailableAmd* = 0x00008BC4
  GlPerfmonResultSizeAmd* = 0x00008BC5
  GlPerfmonResultAmd* = 0x00008BC6 # GL_AMD_vertex_shader_tesselator
  GlSamplerBufferAmd* = 0x00009001
  GlIntSamplerBufferAmd* = 0x00009002
  GlUnsignedIntSamplerBufferAmd* = 0x00009003
  cGLTESSELLATIONMODEAMD* = 0x00009004
  cGLTESSELLATIONFACTORAMD* = 0x00009005
  GlDiscreteAmd* = 0x00009006
  GlContinuousAmd* = 0x00009007 # GL_AMD_seamless_cubemap_per_texture
                                  # reuse GL_TEXTURE_CUBE_MAP_SEAMLESS 
                                  # GL_AMD_name_gen_delete
  GlDataBufferAmd* = 0x00009151
  GlPerformanceMonitorAmd* = 0x00009152
  GlQueryObjectAmd* = 0x00009153
  GlVertexArrayObjectAmd* = 0x00009154
  GlSamplerObjectAmd* = 0x00009155 # GL_AMD_debug_output
  GlMaxDebugLoggedMessagesAmd* = 0x00009144
  GlDebugLoggedMessagesAmd* = 0x00009145
  GlDebugSeverityHighAmd* = 0x00009146
  GlDebugSeverityMediumAmd* = 0x00009147
  GlDebugSeverityLowAmd* = 0x00009148
  GlDebugCategoryApiErrorAmd* = 0x00009149
  GlDebugCategoryWindowSystemAmd* = 0x0000914A
  GlDebugCategoryDeprecationAmd* = 0x0000914B
  GlDebugCategoryUndefinedBehaviorAmd* = 0x0000914C
  GlDebugCategoryPerformanceAmd* = 0x0000914D
  GlDebugCategoryShaderCompilerAmd* = 0x0000914E
  GlDebugCategoryApplicationAmd* = 0x0000914F
  GlDebugCategoryOtherAmd* = 0x00009150 # GL_AMD_depth_clamp_separate
  GlDepthClampNearAmd* = 0x0000901E
  GlDepthClampFarAmd* = 0x0000901F # GL_EXT_422_pixels
  Gl422Ext* = 0x000080CC
  Gl422RevExt* = 0x000080CD
  Gl422AverageExt* = 0x000080CE
  Gl422RevAverageExt* = 0x000080CF # GL_EXT_abgr
  GlAbgrExt* = 0x00008000   # GL_EXT_bgra
  GlBgrExt* = 0x000080E0
  GlBgraExt* = 0x000080E1   # GL_EXT_blend_color
  GlConstantColorExt* = 0x00008001
  GlOneMinusConstantColorExt* = 0x00008002
  GlConstantAlphaExt* = 0x00008003
  GlOneMinusConstantAlphaExt* = 0x00008004
  cGLBLENDCOLOREXT* = 0x00008005 # GL_EXT_blend_func_separate
  GlBlendDstRgbExt* = 0x000080C8
  GlBlendSrcRgbExt* = 0x000080C9
  GlBlendDstAlphaExt* = 0x000080CA
  GlBlendSrcAlphaExt* = 0x000080CB # GL_EXT_blend_minmax
  GlFuncAddExt* = 0x00008006
  GlMinExt* = 0x00008007
  GlMaxExt* = 0x00008008
  cGLBLENDEQUATIONEXT* = 0x00008009 # GL_EXT_blend_subtract
  GlFuncSubtractExt* = 0x0000800A
  GlFuncReverseSubtractExt* = 0x0000800B # GL_EXT_clip_volume_hint
  GlClipVolumeClippingHintExt* = 0x000080F0 # GL_EXT_cmyka
  GlCmykExt* = 0x0000800C
  GlCmykaExt* = 0x0000800D
  GlPackCmykHintExt* = 0x0000800E
  GlUnpackCmykHintExt* = 0x0000800F # GL_EXT_compiled_vertex_array
  GlArrayElementLockFirstExt* = 0x000081A8
  GlArrayElementLockCountExt* = 0x000081A9 # GL_EXT_convolution
  GlConvolution1dExt* = 0x00008010
  GlConvolution2dExt* = 0x00008011
  GlSeparable2dExt* = 0x00008012
  GlConvolutionBorderModeExt* = 0x00008013
  GlConvolutionFilterScaleExt* = 0x00008014
  GlConvolutionFilterBiasExt* = 0x00008015
  GlReduceExt* = 0x00008016
  GlConvolutionFormatExt* = 0x00008017
  GlConvolutionWidthExt* = 0x00008018
  GlConvolutionHeightExt* = 0x00008019
  GlMaxConvolutionWidthExt* = 0x0000801A
  GlMaxConvolutionHeightExt* = 0x0000801B
  GlPostConvolutionRedScaleExt* = 0x0000801C
  GlPostConvolutionGreenScaleExt* = 0x0000801D
  GlPostConvolutionBlueScaleExt* = 0x0000801E
  GlPostConvolutionAlphaScaleExt* = 0x0000801F
  GlPostConvolutionRedBiasExt* = 0x00008020
  GlPostConvolutionGreenBiasExt* = 0x00008021
  GlPostConvolutionBlueBiasExt* = 0x00008022
  GlPostConvolutionAlphaBiasExt* = 0x00008023 # GL_EXT_coordinate_frame
  GlTangentArrayExt* = 0x00008439
  GlBinormalArrayExt* = 0x0000843A
  GlCurrentTangentExt* = 0x0000843B
  GlCurrentBinormalExt* = 0x0000843C
  GLTANGENTARRAYtypEXT* = 0x0000843E
  GlTangentArrayStrideExt* = 0x0000843F
  GLBINORMALARRAYtypEXT* = 0x00008440
  GlBinormalArrayStrideExt* = 0x00008441
  GlTangentArrayPointerExt* = 0x00008442
  GlBinormalArrayPointerExt* = 0x00008443
  GlMap1TangentExt* = 0x00008444
  GlMap2TangentExt* = 0x00008445
  GlMap1BinormalExt* = 0x00008446
  GlMap2BinormalExt* = 0x00008447 # GL_EXT_cull_vertex
  GlCullVertexExt* = 0x000081AA
  GlCullVertexEyePositionExt* = 0x000081AB
  GlCullVertexObjectPositionExt* = 0x000081AC # GL_EXT_draw_range_elements
  GlMaxElementsVerticesExt* = 0x000080E8
  GlMaxElementsIndicesExt* = 0x000080E9 # GL_EXT_fog_coord
  GlFogCoordinateSourceExt* = 0x00008450
  GlFogCoordinateExt* = 0x00008451
  GlFragmentDepthExt* = 0x00008452
  GlCurrentFogCoordinateExt* = 0x00008453
  GLFOGCOORDINATEARRAYtypEXT* = 0x00008454
  GlFogCoordinateArrayStrideExt* = 0x00008455
  GlFogCoordinateArrayPointerExt* = 0x00008456
  GlFogCoordinateArrayExt* = 0x00008457 # GL_EXT_framebuffer_object
  GlFramebufferExt* = 0x00008D40
  GlRenderbufferExt* = 0x00008D41
  GlStencilIndexExt* = 0x00008D45
  GlStencilIndex1Ext* = 0x00008D46
  GlStencilIndex4Ext* = 0x00008D47
  GlStencilIndex8Ext* = 0x00008D48
  GlStencilIndex16Ext* = 0x00008D49
  GlRenderbufferWidthExt* = 0x00008D42
  GlRenderbufferHeightExt* = 0x00008D43
  GlRenderbufferInternalFormatExt* = 0x00008D44
  GLFRAMEBUFFERATTACHMENTOBJECTtypEXT* = 0x00008CD0
  GlFramebufferAttachmentObjectNameExt* = 0x00008CD1
  GlFramebufferAttachmentTextureLevelExt* = 0x00008CD2
  GlFramebufferAttachmentTextureCubeMapFaceExt* = 0x00008CD3
  GlFramebufferAttachmentTexture3dZoffsetExt* = 0x00008CD4
  GlColorAttachment0Ext* = 0x00008CE0
  GlColorAttachment1Ext* = 0x00008CE1
  GlColorAttachment2Ext* = 0x00008CE2
  GlColorAttachment3Ext* = 0x00008CE3
  GlColorAttachment4Ext* = 0x00008CE4
  GlColorAttachment5Ext* = 0x00008CE5
  GlColorAttachment6Ext* = 0x00008CE6
  GlColorAttachment7Ext* = 0x00008CE7
  GlColorAttachment8Ext* = 0x00008CE8
  GlColorAttachment9Ext* = 0x00008CE9
  GlColorAttachment10Ext* = 0x00008CEA
  GlColorAttachment11Ext* = 0x00008CEB
  GlColorAttachment12Ext* = 0x00008CEC
  GlColorAttachment13Ext* = 0x00008CED
  GlColorAttachment14Ext* = 0x00008CEE
  GlColorAttachment15Ext* = 0x00008CEF
  GlDepthAttachmentExt* = 0x00008D00
  GlStencilAttachmentExt* = 0x00008D20
  GlFramebufferCompleteExt* = 0x00008CD5
  GlFramebufferIncompleteAttachmentExt* = 0x00008CD6
  GlFramebufferIncompleteMissingAttachmentExt* = 0x00008CD7
  GlFramebufferIncompleteDuplicateAttachmentExt* = 0x00008CD8
  GlFramebufferIncompleteDimensionsExt* = 0x00008CD9
  GlFramebufferIncompleteFormatsExt* = 0x00008CDA
  GlFramebufferIncompleteDrawBufferExt* = 0x00008CDB
  GlFramebufferIncompleteReadBufferExt* = 0x00008CDC
  GlFramebufferUnsupportedExt* = 0x00008CDD
  GlFramebufferStatusErrorExt* = 0x00008CDE
  GlFramebufferBindingExt* = 0x00008CA6
  GlRenderbufferBindingExt* = 0x00008CA7
  GlMaxColorAttachmentsExt* = 0x00008CDF
  GlMaxRenderbufferSizeExt* = 0x000084E8
  GlInvalidFramebufferOperationExt* = 0x00000506 # GL_EXT_histogram
  cGLHISTOGRAMEXT* = 0x00008024
  GlProxyHistogramExt* = 0x00008025
  GlHistogramWidthExt* = 0x00008026
  GlHistogramFormatExt* = 0x00008027
  GlHistogramRedSizeExt* = 0x00008028
  GlHistogramGreenSizeExt* = 0x00008029
  GlHistogramBlueSizeExt* = 0x0000802A
  GlHistogramAlphaSizeExt* = 0x0000802B
  GlHistogramLuminanceSizeExt* = 0x0000802C
  GlHistogramSinkExt* = 0x0000802D
  cGLMINMAXEXT* = 0x0000802E
  GlMinmaxFormatExt* = 0x0000802F
  GlMinmaxSinkExt* = 0x00008030
  GlTableTooLargeExt* = 0x00008031 # GL_EXT_index_array_formats
  GlIuiV2fExt* = 0x000081AD
  GlIuiV3fExt* = 0x000081AE
  GlIuiN3fV2fExt* = 0x000081AF
  GlIuiN3fV3fExt* = 0x000081B0
  GlT2fIuiV2fExt* = 0x000081B1
  GlT2fIuiV3fExt* = 0x000081B2
  GlT2fIuiN3fV2fExt* = 0x000081B3
  GlT2fIuiN3fV3fExt* = 0x000081B4 # GL_EXT_index_func
  GlIndexTestExt* = 0x000081B5
  GlIndexTestFuncExt* = 0x000081B6
  GlIndexTestRefExt* = 0x000081B7 # GL_EXT_index_material
  cGLINDEXMATERIALEXT* = 0x000081B8
  GlIndexMaterialParameterExt* = 0x000081B9
  GlIndexMaterialFaceExt* = 0x000081BA # GL_EXT_light_texture
  GlFragmentMaterialExt* = 0x00008349
  GlFragmentNormalExt* = 0x0000834A
  GlFragmentColorExt* = 0x0000834C
  GlAttenuationExt* = 0x0000834D
  GlShadowAttenuationExt* = 0x0000834E
  GlTextureApplicationModeExt* = 0x0000834F
  cGLTEXTURELIGHTEXT* = 0x00008350
  GlTextureMaterialFaceExt* = 0x00008351
  GlTextureMaterialParameterExt* = 0x00008352 # GL_EXT_multisample
  GlMultisampleExt* = 0x0000809D
  GlSampleAlphaToMaskExt* = 0x0000809E
  GlSampleAlphaToOneExt* = 0x0000809F
  cGLSAMPLEMASKEXT* = 0x000080A0
  Gl1passExt* = 0x000080A1
  Gl2pass0Ext* = 0x000080A2
  Gl2pass1Ext* = 0x000080A3
  Gl4pass0Ext* = 0x000080A4
  Gl4pass1Ext* = 0x000080A5
  Gl4pass2Ext* = 0x000080A6
  Gl4pass3Ext* = 0x000080A7
  GlSampleBuffersExt* = 0x000080A8
  GlSamplesExt* = 0x000080A9
  GlSampleMaskValueExt* = 0x000080AA
  GlSampleMaskInvertExt* = 0x000080AB
  cGLSAMPLEPATTERNEXT* = 0x000080AC
  GlMultisampleBitExt* = 0x20000000 # GL_EXT_packed_pixels
  GlUnsignedByte332Ext* = 0x00008032
  GlUnsignedShort4444Ext* = 0x00008033
  GlUnsignedShort5551Ext* = 0x00008034
  GlUnsignedInt8888Ext* = 0x00008035
  GlUnsignedInt1010102Ext* = 0x00008036 # GL_EXT_paletted_texture
  GlColorIndex1Ext* = 0x000080E2
  GlColorIndex2Ext* = 0x000080E3
  GlColorIndex4Ext* = 0x000080E4
  GlColorIndex8Ext* = 0x000080E5
  GlColorIndex12Ext* = 0x000080E6
  GlColorIndex16Ext* = 0x000080E7
  GlTextureIndexSizeExt* = 0x000080ED # GL_EXT_pixel_transform
  GlPixelTransform2dExt* = 0x00008330
  GlPixelMagFilterExt* = 0x00008331
  GlPixelMinFilterExt* = 0x00008332
  GlPixelCubicWeightExt* = 0x00008333
  GlCubicExt* = 0x00008334
  GlAverageExt* = 0x00008335
  GlPixelTransform2dStackDepthExt* = 0x00008336
  GlMaxPixelTransform2dStackDepthExt* = 0x00008337
  GlPixelTransform2dMatrixExt* = 0x00008338 # GL_EXT_point_parameters
  GlPointSizeMinExt* = 0x00008126
  GlPointSizeMaxExt* = 0x00008127
  GlPointFadeThresholdSizeExt* = 0x00008128
  GlDistanceAttenuationExt* = 0x00008129 # GL_EXT_polygon_offset
  cGLPOLYGONOFFSETEXT* = 0x00008037
  GlPolygonOffsetFactorExt* = 0x00008038
  GlPolygonOffsetBiasExt* = 0x00008039 # GL_EXT_rescale_normal
  GlRescaleNormalExt* = 0x0000803A # GL_EXT_secondary_color
  GlColorSumExt* = 0x00008458
  GlCurrentSecondaryColorExt* = 0x00008459
  GlSecondaryColorArraySizeExt* = 0x0000845A
  GLSECONDARYCOLORARRAYtypEXT* = 0x0000845B
  GlSecondaryColorArrayStrideExt* = 0x0000845C
  GlSecondaryColorArrayPointerExt* = 0x0000845D
  GlSecondaryColorArrayExt* = 0x0000845E # GL_EXT_separate_specular_color
  GlLightModelColorControlExt* = 0x000081F8
  GlSingleColorExt* = 0x000081F9
  GlSeparateSpecularColorExt* = 0x000081FA # GL_EXT_shared_texture_palette
  GlSharedTexturePaletteExt* = 0x000081FB # GL_EXT_stencil_two_side
  GlStencilTestTwoSideExt* = 0x00008910
  cGLACTIVESTENCILFACEEXT* = 0x00008911 # GL_EXT_stencil_wrap
  GlIncrWrapExt* = 0x00008507
  GlDecrWrapExt* = 0x00008508 # GL_EXT_texture
  GlAlpha4Ext* = 0x0000803B
  GlAlpha8Ext* = 0x0000803C
  GlAlpha12Ext* = 0x0000803D
  GlAlpha16Ext* = 0x0000803E
  GlLuminance4Ext* = 0x0000803F
  GlLuminance8Ext* = 0x00008040
  GlLuminance12Ext* = 0x00008041
  GlLuminance16Ext* = 0x00008042
  GlLuminance4Alpha4Ext* = 0x00008043
  GlLuminance6Alpha2Ext* = 0x00008044
  GlLuminance8Alpha8Ext* = 0x00008045
  GlLuminance12Alpha4Ext* = 0x00008046
  GlLuminance12Alpha12Ext* = 0x00008047
  GlLuminance16Alpha16Ext* = 0x00008048
  GlIntensityExt* = 0x00008049
  GlIntensity4Ext* = 0x0000804A
  GlIntensity8Ext* = 0x0000804B
  GlIntensity12Ext* = 0x0000804C
  GlIntensity16Ext* = 0x0000804D
  GlRgb2Ext* = 0x0000804E
  GlRgb4Ext* = 0x0000804F
  GlRgb5Ext* = 0x00008050
  GlRgb8Ext* = 0x00008051
  GlRgb10Ext* = 0x00008052
  GlRgb12Ext* = 0x00008053
  GlRgb16Ext* = 0x00008054
  GlRgba2Ext* = 0x00008055
  GlRgba4Ext* = 0x00008056
  GlRgb5A1Ext* = 0x00008057
  GlRgba8Ext* = 0x00008058
  GlRgb10A2Ext* = 0x00008059
  GlRgba12Ext* = 0x0000805A
  GlRgba16Ext* = 0x0000805B
  GlTextureRedSizeExt* = 0x0000805C
  GlTextureGreenSizeExt* = 0x0000805D
  GlTextureBlueSizeExt* = 0x0000805E
  GlTextureAlphaSizeExt* = 0x0000805F
  GlTextureLuminanceSizeExt* = 0x00008060
  GlTextureIntensitySizeExt* = 0x00008061
  GlReplaceExt* = 0x00008062
  GlProxyTexture1dExt* = 0x00008063
  GlProxyTexture2dExt* = 0x00008064
  GlTextureTooLargeExt* = 0x00008065 # GL_EXT_texture3D
  GlPackSkipImagesExt* = 0x0000806B
  GlPackImageHeightExt* = 0x0000806C
  GlUnpackSkipImagesExt* = 0x0000806D
  GlUnpackImageHeightExt* = 0x0000806E
  GlTexture3dExt* = 0x0000806F
  GlProxyTexture3dExt* = 0x00008070
  GlTextureDepthExt* = 0x00008071
  GlTextureWrapRExt* = 0x00008072
  GlMax3dTextureSizeExt* = 0x00008073 # GL_EXT_texture_compression_s3tc
  GlCompressedRgbS3tcDxt1Ext* = 0x000083F0
  GlCompressedRgbaS3tcDxt1Ext* = 0x000083F1
  GlCompressedRgbaS3tcDxt3Ext* = 0x000083F2
  GlCompressedRgbaS3tcDxt5Ext* = 0x000083F3 # GL_EXT_texture_cube_map
  GlNormalMapExt* = 0x00008511
  GlReflectionMapExt* = 0x00008512
  GlTextureCubeMapExt* = 0x00008513
  GlTextureBindingCubeMapExt* = 0x00008514
  GlTextureCubeMapPositiveXExt* = 0x00008515
  GlTextureCubeMapNegativeXExt* = 0x00008516
  GlTextureCubeMapPositiveYExt* = 0x00008517
  GlTextureCubeMapNegativeYExt* = 0x00008518
  GlTextureCubeMapPositiveZExt* = 0x00008519
  GlTextureCubeMapNegativeZExt* = 0x0000851A
  GlProxyTextureCubeMapExt* = 0x0000851B
  GlMaxCubeMapTextureSizeExt* = 0x0000851C # GL_EXT_texture_edge_clamp
  GlClampToEdgeExt* = 0x0000812F # GL_EXT_texture_env_combine
  GlCombineExt* = 0x00008570
  GlCombineRgbExt* = 0x00008571
  GlCombineAlphaExt* = 0x00008572
  GlRgbScaleExt* = 0x00008573
  GlAddSignedExt* = 0x00008574
  GlInterpolateExt* = 0x00008575
  GlConstantExt* = 0x00008576
  GlPrimaryColorExt* = 0x00008577
  GlPreviousExt* = 0x00008578
  GlSource0RgbExt* = 0x00008580
  GlSource1RgbExt* = 0x00008581
  GlSource2RgbExt* = 0x00008582
  GlSource0AlphaExt* = 0x00008588
  GlSource1AlphaExt* = 0x00008589
  GlSource2AlphaExt* = 0x0000858A
  GlOperand0RgbExt* = 0x00008590
  GlOperand1RgbExt* = 0x00008591
  GlOperand2RgbExt* = 0x00008592
  GlOperand0AlphaExt* = 0x00008598
  GlOperand1AlphaExt* = 0x00008599
  GlOperand2AlphaExt* = 0x0000859A # GL_EXT_texture_env_dot3
  GlDot3RgbExt* = 0x00008740
  GlDot3RgbaExt* = 0x00008741 # GL_EXT_texture_filter_anisotropic
  GlTextureMaxAnisotropyExt* = 0x000084FE
  GlMaxTextureMaxAnisotropyExt* = 0x000084FF # GL_EXT_texture_lod_bias
  GlMaxTextureLodBiasExt* = 0x000084FD
  GlTextureFilterControlExt* = 0x00008500
  GlTextureLodBiasExt* = 0x00008501 # GL_EXT_texture_object
  GlTexturePriorityExt* = 0x00008066
  GlTextureResidentExt* = 0x00008067
  GlTexture1dBindingExt* = 0x00008068
  GlTexture2dBindingExt* = 0x00008069
  GlTexture3dBindingExt* = 0x0000806A # GL_EXT_texture_perturb_normal
  GlPerturbExt* = 0x000085AE
  cGLTEXTURENORMALEXT* = 0x000085AF # GL_EXT_texture_rectangle
  GlTextureRectangleExt* = 0x000084F5
  GlTextureBindingRectangleExt* = 0x000084F6
  GlProxyTextureRectangleExt* = 0x000084F7
  GlMaxRectangleTextureSizeExt* = 0x000084F8 # GL_EXT_vertex_array
  GlVertexArrayExt* = 0x00008074
  GlNormalArrayExt* = 0x00008075
  GlColorArrayExt* = 0x00008076
  GlIndexArrayExt* = 0x00008077
  GlTextureCoordArrayExt* = 0x00008078
  GlEdgeFlagArrayExt* = 0x00008079
  GlVertexArraySizeExt* = 0x0000807A
  GLVERTEXARRAYtypEXT* = 0x0000807B
  GlVertexArrayStrideExt* = 0x0000807C
  GlVertexArrayCountExt* = 0x0000807D
  GLNORMALARRAYtypEXT* = 0x0000807E
  GlNormalArrayStrideExt* = 0x0000807F
  GlNormalArrayCountExt* = 0x00008080
  GlColorArraySizeExt* = 0x00008081
  GLCOLORARRAYtypEXT* = 0x00008082
  GlColorArrayStrideExt* = 0x00008083
  GlColorArrayCountExt* = 0x00008084
  GLINDEXARRAYtypEXT* = 0x00008085
  GlIndexArrayStrideExt* = 0x00008086
  GlIndexArrayCountExt* = 0x00008087
  GlTextureCoordArraySizeExt* = 0x00008088
  GLTEXTURECOORDARRAYtypEXT* = 0x00008089
  GlTextureCoordArrayStrideExt* = 0x0000808A
  GlTextureCoordArrayCountExt* = 0x0000808B
  GlEdgeFlagArrayStrideExt* = 0x0000808C
  GlEdgeFlagArrayCountExt* = 0x0000808D
  GlVertexArrayPointerExt* = 0x0000808E
  GlNormalArrayPointerExt* = 0x0000808F
  GlColorArrayPointerExt* = 0x00008090
  GlIndexArrayPointerExt* = 0x00008091
  GlTextureCoordArrayPointerExt* = 0x00008092
  GlEdgeFlagArrayPointerExt* = 0x00008093 # GL_EXT_vertex_shader
  GlVertexShaderExt* = 0x00008780
  GlVertexShaderBindingExt* = 0x00008781
  GlOpIndexExt* = 0x00008782
  GlOpNegateExt* = 0x00008783
  GlOpDot3Ext* = 0x00008784
  GlOpDot4Ext* = 0x00008785
  GlOpMulExt* = 0x00008786
  GlOpAddExt* = 0x00008787
  GlOpMaddExt* = 0x00008788
  GlOpFracExt* = 0x00008789
  GlOpMaxExt* = 0x0000878A
  GlOpMinExt* = 0x0000878B
  GlOpSetGeExt* = 0x0000878C
  GlOpSetLtExt* = 0x0000878D
  GlOpClampExt* = 0x0000878E
  GlOpFloorExt* = 0x0000878F
  GlOpRoundExt* = 0x00008790
  GlOpExpBase2Ext* = 0x00008791
  GlOpLogBase2Ext* = 0x00008792
  GlOpPowerExt* = 0x00008793
  GlOpRecipExt* = 0x00008794
  GlOpRecipSqrtExt* = 0x00008795
  GlOpSubExt* = 0x00008796
  GlOpCrossProductExt* = 0x00008797
  GlOpMultiplyMatrixExt* = 0x00008798
  GlOpMovExt* = 0x00008799
  GlOutputVertexExt* = 0x0000879A
  GlOutputColor0Ext* = 0x0000879B
  GlOutputColor1Ext* = 0x0000879C
  GlOutputTextureCoord0Ext* = 0x0000879D
  GlOutputTextureCoord1Ext* = 0x0000879E
  GlOutputTextureCoord2Ext* = 0x0000879F
  GlOutputTextureCoord3Ext* = 0x000087A0
  GlOutputTextureCoord4Ext* = 0x000087A1
  GlOutputTextureCoord5Ext* = 0x000087A2
  GlOutputTextureCoord6Ext* = 0x000087A3
  GlOutputTextureCoord7Ext* = 0x000087A4
  GlOutputTextureCoord8Ext* = 0x000087A5
  GlOutputTextureCoord9Ext* = 0x000087A6
  GlOutputTextureCoord10Ext* = 0x000087A7
  GlOutputTextureCoord11Ext* = 0x000087A8
  GlOutputTextureCoord12Ext* = 0x000087A9
  GlOutputTextureCoord13Ext* = 0x000087AA
  GlOutputTextureCoord14Ext* = 0x000087AB
  GlOutputTextureCoord15Ext* = 0x000087AC
  GlOutputTextureCoord16Ext* = 0x000087AD
  GlOutputTextureCoord17Ext* = 0x000087AE
  GlOutputTextureCoord18Ext* = 0x000087AF
  GlOutputTextureCoord19Ext* = 0x000087B0
  GlOutputTextureCoord20Ext* = 0x000087B1
  GlOutputTextureCoord21Ext* = 0x000087B2
  GlOutputTextureCoord22Ext* = 0x000087B3
  GlOutputTextureCoord23Ext* = 0x000087B4
  GlOutputTextureCoord24Ext* = 0x000087B5
  GlOutputTextureCoord25Ext* = 0x000087B6
  GlOutputTextureCoord26Ext* = 0x000087B7
  GlOutputTextureCoord27Ext* = 0x000087B8
  GlOutputTextureCoord28Ext* = 0x000087B9
  GlOutputTextureCoord29Ext* = 0x000087BA
  GlOutputTextureCoord30Ext* = 0x000087BB
  GlOutputTextureCoord31Ext* = 0x000087BC
  GlOutputFogExt* = 0x000087BD
  GlScalarExt* = 0x000087BE
  GlVectorExt* = 0x000087BF
  GlMatrixExt* = 0x000087C0
  GlVariantExt* = 0x000087C1
  GlInvariantExt* = 0x000087C2
  GlLocalConstantExt* = 0x000087C3
  GlLocalExt* = 0x000087C4
  GlMaxVertexShaderInstructionsExt* = 0x000087C5
  GlMaxVertexShaderVariantsExt* = 0x000087C6
  GlMaxVertexShaderInvariantsExt* = 0x000087C7
  GlMaxVertexShaderLocalConstantsExt* = 0x000087C8
  GlMaxVertexShaderLocalsExt* = 0x000087C9
  GlMaxOptimizedVertexShaderInstructionsExt* = 0x000087CA
  GlMaxOptimizedVertexShaderVariantsExt* = 0x000087CB
  GlMaxOptimizedVertexShaderLocalConstantsExt* = 0x000087CC
  GlMaxOptimizedVertexShaderInvariantsExt* = 0x000087CD
  GlMaxOptimizedVertexShaderLocalsExt* = 0x000087CE
  GlVertexShaderInstructionsExt* = 0x000087CF
  GlVertexShaderVariantsExt* = 0x000087D0
  GlVertexShaderInvariantsExt* = 0x000087D1
  GlVertexShaderLocalConstantsExt* = 0x000087D2
  GlVertexShaderLocalsExt* = 0x000087D3
  GlVertexShaderOptimizedExt* = 0x000087D4
  GlXExt* = 0x000087D5
  GlYExt* = 0x000087D6
  GlZExt* = 0x000087D7
  GlWExt* = 0x000087D8
  GlNegativeXExt* = 0x000087D9
  GlNegativeYExt* = 0x000087DA
  GlNegativeZExt* = 0x000087DB
  GlNegativeWExt* = 0x000087DC
  GlZeroExt* = 0x000087DD
  GlOneExt* = 0x000087DE
  GlNegativeOneExt* = 0x000087DF
  GlNormalizedRangeExt* = 0x000087E0
  GlFullRangeExt* = 0x000087E1
  GlCurrentVertexExt* = 0x000087E2
  GlMvpMatrixExt* = 0x000087E3
  GlVariantValueExt* = 0x000087E4
  GLVARIANTDATAtypEXT* = 0x000087E5
  GlVariantArrayStrideExt* = 0x000087E6
  GLVARIANTARRAYtypEXT* = 0x000087E7
  GlVariantArrayExt* = 0x000087E8
  GlVariantArrayPointerExt* = 0x000087E9
  GlInvariantValueExt* = 0x000087EA
  GLINVARIANTDATAtypEXT* = 0x000087EB
  GlLocalConstantValueExt* = 0x000087EC
  GLLOCALCONSTANTDATAtypEXT* = 0x000087ED # GL_EXT_vertex_weighting
  GlModelview0StackDepthExt* = 0x00000BA3
  GlModelview1StackDepthExt* = 0x00008502
  GlModelview0MatrixExt* = 0x00000BA6
  GlModelview1MatrixExt* = 0x00008506
  GlVertexWeightingExt* = 0x00008509
  GlModelview0Ext* = 0x00001700
  GlModelview1Ext* = 0x0000850A
  GlCurrentVertexWeightExt* = 0x0000850B
  GlVertexWeightArrayExt* = 0x0000850C
  GlVertexWeightArraySizeExt* = 0x0000850D
  GLVERTEXWEIGHTARRAYtypEXT* = 0x0000850E
  GlVertexWeightArrayStrideExt* = 0x0000850F
  GlVertexWeightArrayPointerExt* = 0x00008510 # GL_EXT_depth_bounds_test
  GlDepthBoundsTestExt* = 0x00008890
  cGLDEPTHBOUNDSEXT* = 0x00008891 # GL_EXT_texture_mirror_clamp
  GlMirrorClampExt* = 0x00008742
  GlMirrorClampToEdgeExt* = 0x00008743
  GlMirrorClampToBorderExt* = 0x00008912 # GL_EXT_blend_equation_separate
  GlBlendEquationRgbExt* = 0x00008009
  GlBlendEquationAlphaExt* = 0x0000883D # GL_EXT_pixel_buffer_object
  GlPixelPackBufferExt* = 0x000088EB
  GlPixelUnpackBufferExt* = 0x000088EC
  GlPixelPackBufferBindingExt* = 0x000088ED
  GlPixelUnpackBufferBindingExt* = 0x000088EF # GL_EXT_stencil_clear_tag
  GlStencilTagBitsExt* = 0x000088F2
  GlStencilClearTagValueExt* = 0x000088F3 # GL_EXT_packed_depth_stencil
  GlDepthStencilExt* = 0x000084F9
  GlUnsignedInt248Ext* = 0x000084FA
  GlDepth24Stencil8Ext* = 0x000088F0
  GlTextureStencilSizeExt* = 0x000088F1 # GL_EXT_texture_sRGB
  GlSrgbExt* = 0x00008C40
  GlSrgb8Ext* = 0x00008C41
  GlSrgbAlphaExt* = 0x00008C42
  GlSrgb8Alpha8Ext* = 0x00008C43
  GlSluminanceAlphaExt* = 0x00008C44
  GlSluminance8Alpha8Ext* = 0x00008C45
  GlSluminanceExt* = 0x00008C46
  GlSluminance8Ext* = 0x00008C47
  GlCompressedSrgbExt* = 0x00008C48
  GlCompressedSrgbAlphaExt* = 0x00008C49
  GlCompressedSluminanceExt* = 0x00008C4A
  GlCompressedSluminanceAlphaExt* = 0x00008C4B
  GlCompressedSrgbS3tcDxt1Ext* = 0x00008C4C
  GlCompressedSrgbAlphaS3tcDxt1Ext* = 0x00008C4D
  GlCompressedSrgbAlphaS3tcDxt3Ext* = 0x00008C4E
  GlCompressedSrgbAlphaS3tcDxt5Ext* = 0x00008C4F # GL_EXT_framebuffer_blit
  GlReadFramebufferExt* = 0x00008CA8
  GlDrawFramebufferExt* = 0x00008CA9
  GlReadFramebufferBindingExt* = GL_FRAMEBUFFER_BINDING_EXT
  GlDrawFramebufferBindingExt* = 0x00008CAA # GL_EXT_framebuffer_multisample
  GlRenderbufferSamplesExt* = 0x00008CAB
  GlFramebufferIncompleteMultisampleExt* = 0x00008D56
  GlMaxSamplesExt* = 0x00008D57 # GL_EXT_timer_query
  GlTimeElapsedExt* = 0x000088BF # GL_EXT_bindable_uniform
  GlMaxVertexBindableUniformsExt* = 0x00008DE2
  GlMaxFragmentBindableUniformsExt* = 0x00008DE3
  GlMaxGeometryBindableUniformsExt* = 0x00008DE4
  GlMaxBindableUniformSizeExt* = 0x00008DED
  cGLUNIFORMBUFFEREXT* = 0x00008DEE
  GlUniformBufferBindingExt* = 0x00008DEF # GL_EXT_framebuffer_sRGB
  GlxFramebufferSrgbCapableExt* = 0x000020B2
  WglFramebufferSrgbCapableExt* = 0x000020A9
  GlFramebufferSrgbExt* = 0x00008DB9
  GlFramebufferSrgbCapableExt* = 0x00008DBA # GL_EXT_geometry_shader4
  GlGeometryShaderExt* = 0x00008DD9
  GlGeometryVerticesOutExt* = 0x00008DDA
  GLGEOMETRYINPUTtypEXT* = 0x00008DDB
  GLGEOMETRYOUTPUTtypEXT* = 0x00008DDC
  GlMaxGeometryTextureImageUnitsExt* = 0x00008C29
  GlMaxGeometryVaryingComponentsExt* = 0x00008DDD
  GlMaxVertexVaryingComponentsExt* = 0x00008DDE
  GlMaxVaryingComponentsExt* = 0x00008B4B
  GlMaxGeometryUniformComponentsExt* = 0x00008DDF
  GlMaxGeometryOutputVerticesExt* = 0x00008DE0
  GlMaxGeometryTotalOutputComponentsExt* = 0x00008DE1
  GlLinesAdjacencyExt* = 0x0000000A
  GlLineStripAdjacencyExt* = 0x0000000B
  GlTrianglesAdjacencyExt* = 0x0000000C
  GlTriangleStripAdjacencyExt* = 0x0000000D
  GlFramebufferIncompleteLayerTargetsExt* = 0x00008DA8
  GlFramebufferIncompleteLayerCountExt* = 0x00008DA9
  GlFramebufferAttachmentLayeredExt* = 0x00008DA7
  GlFramebufferAttachmentTextureLayerExt* = 0x00008CD4
  GlProgramPointSizeExt* = 0x00008642 # GL_EXT_gpu_shader4
  GlVertexAttribArrayIntegerExt* = 0x000088FD
  GlSampler1dArrayExt* = 0x00008DC0
  GlSampler2dArrayExt* = 0x00008DC1
  GlSamplerBufferExt* = 0x00008DC2
  GlSampler1dArrayShadowExt* = 0x00008DC3
  GlSampler2dArrayShadowExt* = 0x00008DC4
  GlSamplerCubeShadowExt* = 0x00008DC5
  GlUnsignedIntVec2Ext* = 0x00008DC6
  GlUnsignedIntVec3Ext* = 0x00008DC7
  GlUnsignedIntVec4Ext* = 0x00008DC8
  GlIntSampler1dExt* = 0x00008DC9
  GlIntSampler2dExt* = 0x00008DCA
  GlIntSampler3dExt* = 0x00008DCB
  GlIntSamplerCubeExt* = 0x00008DCC
  GlIntSampler2dRectExt* = 0x00008DCD
  GlIntSampler1dArrayExt* = 0x00008DCE
  GlIntSampler2dArrayExt* = 0x00008DCF
  GlIntSamplerBufferExt* = 0x00008DD0
  GlUnsignedIntSampler1dExt* = 0x00008DD1
  GlUnsignedIntSampler2dExt* = 0x00008DD2
  GlUnsignedIntSampler3dExt* = 0x00008DD3
  GlUnsignedIntSamplerCubeExt* = 0x00008DD4
  GlUnsignedIntSampler2dRectExt* = 0x00008DD5
  GlUnsignedIntSampler1dArrayExt* = 0x00008DD6
  GlUnsignedIntSampler2dArrayExt* = 0x00008DD7
  GlUnsignedIntSamplerBufferExt* = 0x00008DD8
  GlMinProgramTexelOffsetExt* = 0x00008904
  GlMaxProgramTexelOffsetExt* = 0x00008905 # GL_EXT_packed_float
  GlR11fG11fB10fExt* = 0x00008C3A
  GlUnsignedInt10f11f11fRevExt* = 0x00008C3B
  RgbaSignedComponentsExt* = 0x00008C3C
  WGLtypRGBAUNSIGNEDFLOATEXT* = 0x000020A8
  GLXRGBAUNSIGNEDFLOATtypEXT* = 0x000020B1
  GlxRgbaUnsignedFloatBitExt* = 0x00000008 # GL_EXT_texture_array
  GlTexture1dArrayExt* = 0x00008C18
  GlTexture2dArrayExt* = 0x00008C1A
  GlProxyTexture2dArrayExt* = 0x00008C1B
  GlProxyTexture1dArrayExt* = 0x00008C19
  GlTextureBinding1dArrayExt* = 0x00008C1C
  GlTextureBinding2dArrayExt* = 0x00008C1D
  GlMaxArrayTextureLayersExt* = 0x000088FF
  GlCompareRefDepthToTextureExt* = 0x0000884E # GL_EXT_texture_buffer_object
  cGLTEXTUREBUFFEREXT* = 0x00008C2A
  GlMaxTextureBufferSizeExt* = 0x00008C2B
  GlTextureBindingBufferExt* = 0x00008C2C
  GlTextureBufferDataStoreBindingExt* = 0x00008C2D
  GlTextureBufferFormatExt* = 0x00008C2E # GL_EXT_texture_compression_latc
  GlCompressedLuminanceLatc1Ext* = 0x00008C70
  GlCompressedSignedLuminanceLatc1Ext* = 0x00008C71
  GlCompressedLuminanceAlphaLatc2Ext* = 0x00008C72
  GlCompressedSignedLuminanceAlphaLatc2Ext* = 0x00008C73 # 
                                                               # GL_EXT_texture_compression_rgtc
  GlCompressedRedRgtc1Ext* = 0x00008DBB
  GlCompressedSignedRedRgtc1Ext* = 0x00008DBC
  GlCompressedRedGreenRgtc2Ext* = 0x00008DBD
  GlCompressedSignedRedGreenRgtc2Ext* = 0x00008DBE # GL_EXT_texture_integer
  GlRgbaIntegerModeExt* = 0x00008D9E
  GlRgba32uiExt* = 0x00008D70
  GlRgb32uiExt* = 0x00008D71
  GlAlpha32uiExt* = 0x00008D72
  GlIntensity32uiExt* = 0x00008D73
  GlLuminance32uiExt* = 0x00008D74
  GlLuminanceAlpha32uiExt* = 0x00008D75
  GlRgba16uiExt* = 0x00008D76
  GlRgb16uiExt* = 0x00008D77
  GlAlpha16uiExt* = 0x00008D78
  GlIntensity16uiExt* = 0x00008D79
  GlLuminance16uiExt* = 0x00008D7A
  GlLuminanceAlpha16uiExt* = 0x00008D7B
  GlRgba8uiExt* = 0x00008D7C
  GlRgb8uiExt* = 0x00008D7D
  GlAlpha8uiExt* = 0x00008D7E
  GlIntensity8uiExt* = 0x00008D7F
  GlLuminance8uiExt* = 0x00008D80
  GlLuminanceAlpha8uiExt* = 0x00008D81
  GlRgba32iExt* = 0x00008D82
  GlRgb32iExt* = 0x00008D83
  GlAlpha32iExt* = 0x00008D84
  GlIntensity32iExt* = 0x00008D85
  GlLuminance32iExt* = 0x00008D86
  GlLuminanceAlpha32iExt* = 0x00008D87
  GlRgba16iExt* = 0x00008D88
  GlRgb16iExt* = 0x00008D89
  GlAlpha16iExt* = 0x00008D8A
  GlIntensity16iExt* = 0x00008D8B
  GlLuminance16iExt* = 0x00008D8C
  GlLuminanceAlpha16iExt* = 0x00008D8D
  GlRgba8iExt* = 0x00008D8E
  GlRgb8iExt* = 0x00008D8F
  GlAlpha8iExt* = 0x00008D90
  GlIntensity8iExt* = 0x00008D91
  GlLuminance8iExt* = 0x00008D92
  GlLuminanceAlpha8iExt* = 0x00008D93
  GlRedIntegerExt* = 0x00008D94
  GlGreenIntegerExt* = 0x00008D95
  GlBlueIntegerExt* = 0x00008D96
  GlAlphaIntegerExt* = 0x00008D97
  GlRgbIntegerExt* = 0x00008D98
  GlRgbaIntegerExt* = 0x00008D99
  GlBgrIntegerExt* = 0x00008D9A
  GlBgraIntegerExt* = 0x00008D9B
  GlLuminanceIntegerExt* = 0x00008D9C
  GlLuminanceAlphaIntegerExt* = 0x00008D9D # GL_EXT_texture_shared_exponent
  GlRgb9E5Ext* = 0x00008C3D
  GlUnsignedInt5999RevExt* = 0x00008C3E
  GlTextureSharedSizeExt* = 0x00008C3F # GL_EXT_transform_feedback
  GlTransformFeedbackBufferExt* = 0x00008C8E
  GlTransformFeedbackBufferStartExt* = 0x00008C84
  GlTransformFeedbackBufferSizeExt* = 0x00008C85
  GlTransformFeedbackBufferBindingExt* = 0x00008C8F
  GlInterleavedAttribsExt* = 0x00008C8C
  GlSeparateAttribsExt* = 0x00008C8D
  GlPrimitivesGeneratedExt* = 0x00008C87
  GlTransformFeedbackPrimitivesWrittenExt* = 0x00008C88
  GlRasterizerDiscardExt* = 0x00008C89
  GlMaxTransformFeedbackInterleavedComponentsExt* = 0x00008C8A
  GlMaxTransformFeedbackSeparateAttribsExt* = 0x00008C8B
  GlMaxTransformFeedbackSeparateComponentsExt* = 0x00008C80
  cGLTRANSFORMFEEDBACKVARYINGSEXT* = 0x00008C83
  GlTransformFeedbackBufferModeExt* = 0x00008C7F
  GlTransformFeedbackVaryingMaxLengthExt* = 0x00008C76 # 
                                                             # GL_EXT_direct_state_access
  GlProgramMatrixExt* = 0x00008E2D
  GlTransposeProgramMatrixExt* = 0x00008E2E
  GlProgramMatrixStackDepthExt* = 0x00008E2F # GL_EXT_texture_swizzle
  GlTextureSwizzleRExt* = 0x00008E42
  GlTextureSwizzleGExt* = 0x00008E43
  GlTextureSwizzleBExt* = 0x00008E44
  GlTextureSwizzleAExt* = 0x00008E45
  GlTextureSwizzleRgbaExt* = 0x00008E46 # GL_EXT_provoking_vertex
  GlQuadsFollowProvokingVertexConventionExt* = 0x00008E4C
  GlFirstVertexConventionExt* = 0x00008E4D
  GlLastVertexConventionExt* = 0x00008E4E
  GlProvokingVertexExt* = 0x00008E4F # GL_EXT_texture_snorm
  GlAlphaSnorm* = 0x00009010
  GlLuminanceSnorm* = 0x00009011
  GlLuminanceAlphaSnorm* = 0x00009012
  GlIntensitySnorm* = 0x00009013
  GlAlpha8Snorm* = 0x00009014
  GlLuminance8Snorm* = 0x00009015
  GlLuminance8Alpha8Snorm* = 0x00009016
  GlIntensity8Snorm* = 0x00009017
  GlAlpha16Snorm* = 0x00009018
  GlLuminance16Snorm* = 0x00009019
  GlLuminance16Alpha16Snorm* = 0x0000901A
  GlIntensity16Snorm* = 0x0000901B # GL_EXT_separate_shader_objects
  cGLACTIVEPROGRAMEXT* = 0x00008B8D # GL_EXT_shader_image_load_store
  GlMaxImageUnitsExt* = 0x00008F38
  GlMaxCombinedImageUnitsAndFragmentOutputsExt* = 0x00008F39
  GlImageBindingNameExt* = 0x00008F3A
  GlImageBindingLevelExt* = 0x00008F3B
  GlImageBindingLayeredExt* = 0x00008F3C
  GlImageBindingLayerExt* = 0x00008F3D
  GlImageBindingAccessExt* = 0x00008F3E
  GlImage1dExt* = 0x0000904C
  GlImage2dExt* = 0x0000904D
  GlImage3dExt* = 0x0000904E
  GlImage2dRectExt* = 0x0000904F
  GlImageCubeExt* = 0x00009050
  GlImageBufferExt* = 0x00009051
  GlImage1dArrayExt* = 0x00009052
  GlImage2dArrayExt* = 0x00009053
  GlImageCubeMapArrayExt* = 0x00009054
  GlImage2dMultisampleExt* = 0x00009055
  GlImage2dMultisampleArrayExt* = 0x00009056
  GlIntImage1dExt* = 0x00009057
  GlIntImage2dExt* = 0x00009058
  GlIntImage3dExt* = 0x00009059
  GlIntImage2dRectExt* = 0x0000905A
  GlIntImageCubeExt* = 0x0000905B
  GlIntImageBufferExt* = 0x0000905C
  GlIntImage1dArrayExt* = 0x0000905D
  GlIntImage2dArrayExt* = 0x0000905E
  GlIntImageCubeMapArrayExt* = 0x0000905F
  GlIntImage2dMultisampleExt* = 0x00009060
  GlIntImage2dMultisampleArrayExt* = 0x00009061
  GlUnsignedIntImage1dExt* = 0x00009062
  GlUnsignedIntImage2dExt* = 0x00009063
  GlUnsignedIntImage3dExt* = 0x00009064
  GlUnsignedIntImage2dRectExt* = 0x00009065
  GlUnsignedIntImageCubeExt* = 0x00009066
  GlUnsignedIntImageBufferExt* = 0x00009067
  GlUnsignedIntImage1dArrayExt* = 0x00009068
  GlUnsignedIntImage2dArrayExt* = 0x00009069
  GlUnsignedIntImageCubeMapArrayExt* = 0x0000906A
  GlUnsignedIntImage2dMultisampleExt* = 0x0000906B
  GlUnsignedIntImage2dMultisampleArrayExt* = 0x0000906C
  GlMaxImageSamplesExt* = 0x0000906D
  GlImageBindingFormatExt* = 0x0000906E
  GlVertexAttribArrayBarrierBitExt* = 0x00000001
  GlElementArrayBarrierBitExt* = 0x00000002
  GlUniformBarrierBitExt* = 0x00000004
  GlTextureFetchBarrierBitExt* = 0x00000008
  GlShaderImageAccessBarrierBitExt* = 0x00000020
  GlCommandBarrierBitExt* = 0x00000040
  GlPixelBufferBarrierBitExt* = 0x00000080
  GlTextureUpdateBarrierBitExt* = 0x00000100
  GlBufferUpdateBarrierBitExt* = 0x00000200
  GlFramebufferBarrierBitExt* = 0x00000400
  GlTransformFeedbackBarrierBitExt* = 0x00000800
  GlAtomicCounterBarrierBitExt* = 0x00001000
  GlAllBarrierBitsExt* = 0xFFFFFFFF # GL_EXT_vertex_attrib_64bit
                                        # reuse GL_DOUBLE 
  GlDoubleVec2Ext* = 0x00008FFC
  GlDoubleVec3Ext* = 0x00008FFD
  GlDoubleVec4Ext* = 0x00008FFE
  GlDoubleMat2Ext* = 0x00008F46
  GlDoubleMat3Ext* = 0x00008F47
  GlDoubleMat4Ext* = 0x00008F48
  GLDOUBLEMAT2x3EXT* = 0x00008F49
  GLDOUBLEMAT2x4EXT* = 0x00008F4A
  GLDOUBLEMAT3x2EXT* = 0x00008F4B
  GLDOUBLEMAT3x4EXT* = 0x00008F4C
  GLDOUBLEMAT4x2EXT* = 0x00008F4D
  GLDOUBLEMAT4x3EXT* = 0x00008F4E # GL_EXT_texture_sRGB_decode
  GlTextureSrgbDecodeExt* = 0x00008A48
  GlDecodeExt* = 0x00008A49
  GlSkipDecodeExt* = 0x00008A4A # GL_NV_texture_multisample 
  GlTextureCoverageSamplesNv* = 0x00009045
  GlTextureColorSamplesNv* = 0x00009046 # GL_AMD_blend_minmax_factor
  GlFactorMinAmd* = 0x0000901C
  GlFactorMaxAmd* = 0x0000901D # GL_AMD_sample_positions
  GlSubsampleDistanceAmd* = 0x0000883F # GL_EXT_x11_sync_object
  GlSyncX11FenceExt* = 0x000090E1 # GL_EXT_framebuffer_multisample_blit_scaled
  GlScaledResolveFastestExt* = 0x000090BA
  GlScaledResolveNicestExt* = 0x000090BB # GL_FfdMaskSGIX
  GlTextureDeformationBitSgix* = 0x00000001
  GlGeometryDeformationBitSgix* = 0x00000002 # GL_HP_convolution_border_modes
  GlIgnoreBorderHp* = 0x00008150
  GlConstantBorderHp* = 0x00008151
  GlReplicateBorderHp* = 0x00008153
  GlConvolutionBorderColorHp* = 0x00008154 # GL_HP_image_transform
  GlImageScaleXHp* = 0x00008155
  GlImageScaleYHp* = 0x00008156
  GlImageTranslateXHp* = 0x00008157
  GlImageTranslateYHp* = 0x00008158
  GlImageRotateAngleHp* = 0x00008159
  GlImageRotateOriginXHp* = 0x0000815A
  GlImageRotateOriginYHp* = 0x0000815B
  GlImageMagFilterHp* = 0x0000815C
  GlImageMinFilterHp* = 0x0000815D
  GlImageCubicWeightHp* = 0x0000815E
  GlCubicHp* = 0x0000815F
  GlAverageHp* = 0x00008160
  GlImageTransform2dHp* = 0x00008161
  GlPostImageTransformColorTableHp* = 0x00008162
  GlProxyPostImageTransformColorTableHp* = 0x00008163 # 
                                                             # GL_HP_occlusion_test
  GlOcclusionTestHp* = 0x00008165
  GlOcclusionTestResultHp* = 0x00008166 # GL_HP_texture_lighting
  GlTextureLightingModeHp* = 0x00008167
  GlTexturePostSpecularHp* = 0x00008168
  GlTexturePreSpecularHp* = 0x00008169 # GL_IBM_cull_vertex
  GlCullVertexIbm* = 103050 # GL_IBM_rasterpos_clip
  GlRasterPositionUnclippedIbm* = 0x00019262 # GL_IBM_texture_mirrored_repeat
  GlMirroredRepeatIbm* = 0x00008370 # GL_IBM_vertex_array_lists
  GlVertexArrayListIbm* = 103070
  GlNormalArrayListIbm* = 103071
  GlColorArrayListIbm* = 103072
  GlIndexArrayListIbm* = 103073
  GlTextureCoordArrayListIbm* = 103074
  GlEdgeFlagArrayListIbm* = 103075
  GlFogCoordinateArrayListIbm* = 103076
  GlSecondaryColorArrayListIbm* = 103077
  GlVertexArrayListStrideIbm* = 103080
  GlNormalArrayListStrideIbm* = 103081
  GlColorArrayListStrideIbm* = 103082
  GlIndexArrayListStrideIbm* = 103083
  GlTextureCoordArrayListStrideIbm* = 103084
  GlEdgeFlagArrayListStrideIbm* = 103085
  GlFogCoordinateArrayListStrideIbm* = 103086
  GlSecondaryColorArrayListStrideIbm* = 103087 # GL_INGR_color_clamp
  GlRedMinClampIngr* = 0x00008560
  GlGreenMinClampIngr* = 0x00008561
  GlBlueMinClampIngr* = 0x00008562
  GlAlphaMinClampIngr* = 0x00008563
  GlRedMaxClampIngr* = 0x00008564
  GlGreenMaxClampIngr* = 0x00008565
  GlBlueMaxClampIngr* = 0x00008566
  GlAlphaMaxClampIngr* = 0x00008567 # GL_INGR_interlace_read
  GlInterlaceReadIngr* = 0x00008568 # GL_INTEL_parallel_arrays
  GlParallelArraysIntel* = 0x000083F4
  GlVertexArrayParallelPointersIntel* = 0x000083F5
  GlNormalArrayParallelPointersIntel* = 0x000083F6
  GlColorArrayParallelPointersIntel* = 0x000083F7
  GlTextureCoordArrayParallelPointersIntel* = 0x000083F8 # 
                                                               # GL_NV_copy_depth_to_color
  GlDepthStencilToRgbaNv* = 0x0000886E
  GlDepthStencilToBgraNv* = 0x0000886F # GL_NV_depth_clamp
  GlDepthClampNv* = 0x0000864F # GL_NV_evaluators
  GlEval2dNv* = 0x000086C0
  GlEvalTriangular2dNv* = 0x000086C1
  GlMapTessellationNv* = 0x000086C2
  GlMapAttribUOrderNv* = 0x000086C3
  GlMapAttribVOrderNv* = 0x000086C4
  GlEvalFractionalTessellationNv* = 0x000086C5
  GlEvalVertexAttrib0Nv* = 0x000086C6
  GlEvalVertexAttrib1Nv* = 0x000086C7
  GlEvalVertexAttrib2Nv* = 0x000086C8
  GlEvalVertexAttrib3Nv* = 0x000086C9
  GlEvalVertexAttrib4Nv* = 0x000086CA
  GlEvalVertexAttrib5Nv* = 0x000086CB
  GlEvalVertexAttrib6Nv* = 0x000086CC
  GlEvalVertexAttrib7Nv* = 0x000086CD
  GlEvalVertexAttrib8Nv* = 0x000086CE
  GlEvalVertexAttrib9Nv* = 0x000086CF
  GlEvalVertexAttrib10Nv* = 0x000086D0
  GlEvalVertexAttrib11Nv* = 0x000086D1
  GlEvalVertexAttrib12Nv* = 0x000086D2
  GlEvalVertexAttrib13Nv* = 0x000086D3
  GlEvalVertexAttrib14Nv* = 0x000086D4
  GlEvalVertexAttrib15Nv* = 0x000086D5
  GlMaxMapTessellationNv* = 0x000086D6
  GlMaxRationalEvalOrderNv* = 0x000086D7 # GL_NV_fence
  GlAllCompletedNv* = 0x000084F2
  GlFenceStatusNv* = 0x000084F3
  GlFenceConditionNv* = 0x000084F4 # GL_NV_float_buffer
  GlFloatRNv* = 0x00008880
  GlFloatRgNv* = 0x00008881
  GlFloatRgbNv* = 0x00008882
  GlFloatRgbaNv* = 0x00008883
  GlFloatR16Nv* = 0x00008884
  GlFloatR32Nv* = 0x00008885
  GlFloatRg16Nv* = 0x00008886
  GlFloatRg32Nv* = 0x00008887
  GlFloatRgb16Nv* = 0x00008888
  GlFloatRgb32Nv* = 0x00008889
  GlFloatRgba16Nv* = 0x0000888A
  GlFloatRgba32Nv* = 0x0000888B
  GlTextureFloatComponentsNv* = 0x0000888C
  GlFloatClearColorValueNv* = 0x0000888D
  GlFloatRgbaModeNv* = 0x0000888E # GL_NV_fog_distance
  GlFogDistanceModeNv* = 0x0000855A
  GlEyeRadialNv* = 0x0000855B
  GlEyePlaneAbsoluteNv* = 0x0000855C # GL_NV_fragment_program
  GlMaxFragmentProgramLocalParametersNv* = 0x00008868
  GlFragmentProgramNv* = 0x00008870
  GlMaxTextureCoordsNv* = 0x00008871
  GlMaxTextureImageUnitsNv* = 0x00008872
  GlFragmentProgramBindingNv* = 0x00008873
  GlProgramErrorStringNv* = 0x00008874 # GL_NV_half_float
  GlHalfFloatNv* = 0x0000140B # GL_NV_light_max_exponent
  GlMaxShininessNv* = 0x00008504
  GlMaxSpotExponentNv* = 0x00008505 # GL_NV_multisample_filter_hint
  GlMultisampleFilterHintNv* = 0x00008534 # GL_NV_occlusion_query
  GlPixelCounterBitsNv* = 0x00008864
  GlCurrentOcclusionQueryIdNv* = 0x00008865
  GlPixelCountNv* = 0x00008866
  GlPixelCountAvailableNv* = 0x00008867 # GL_NV_packed_depth_stencil
  GlDepthStencilNv* = 0x000084F9
  GlUnsignedInt248Nv* = 0x000084FA # GL_NV_pixel_data_range
  GlWritePixelDataRangeNv* = 0x00008878
  GlReadPixelDataRangeNv* = 0x00008879
  GlWritePixelDataRangeLengthNv* = 0x0000887A
  GlReadPixelDataRangeLengthNv* = 0x0000887B
  GlWritePixelDataRangePointerNv* = 0x0000887C
  GlReadPixelDataRangePointerNv* = 0x0000887D # GL_NV_point_sprite
  GlPointSpriteNv* = 0x00008861
  GlCoordReplaceNv* = 0x00008862
  GlPointSpriteRModeNv* = 0x00008863 # GL_NV_primitive_restart
  cGLPRIMITIVERESTARTNV* = 0x00008558
  cGLPRIMITIVERESTARTINDEXNV* = 0x00008559 # GL_NV_register_combiners
  GlRegisterCombinersNv* = 0x00008522
  GlVariableANv* = 0x00008523
  GlVariableBNv* = 0x00008524
  GlVariableCNv* = 0x00008525
  GlVariableDNv* = 0x00008526
  GlVariableENv* = 0x00008527
  GlVariableFNv* = 0x00008528
  GlVariableGNv* = 0x00008529
  GlConstantColor0Nv* = 0x0000852A
  GlConstantColor1Nv* = 0x0000852B
  GlPrimaryColorNv* = 0x0000852C
  GlSecondaryColorNv* = 0x0000852D
  GlSpare0Nv* = 0x0000852E
  GlSpare1Nv* = 0x0000852F
  GlDiscardNv* = 0x00008530
  GlETimesFNv* = 0x00008531
  GlSpare0PlusSecondaryColorNv* = 0x00008532
  GlUnsignedIdentityNv* = 0x00008536
  GlUnsignedInvertNv* = 0x00008537
  GlExpandNormalNv* = 0x00008538
  GlExpandNegateNv* = 0x00008539
  GlHalfBiasNormalNv* = 0x0000853A
  GlHalfBiasNegateNv* = 0x0000853B
  GlSignedIdentityNv* = 0x0000853C
  GlSignedNegateNv* = 0x0000853D
  GlScaleByTwoNv* = 0x0000853E
  GlScaleByFourNv* = 0x0000853F
  GlScaleByOneHalfNv* = 0x00008540
  GlBiasByNegativeOneHalfNv* = 0x00008541
  cGLCOMBINERINPUTNV* = 0x00008542
  GlCombinerMappingNv* = 0x00008543
  GlCombinerComponentUsageNv* = 0x00008544
  GlCombinerAbDotProductNv* = 0x00008545
  GlCombinerCdDotProductNv* = 0x00008546
  GlCombinerMuxSumNv* = 0x00008547
  GlCombinerScaleNv* = 0x00008548
  GlCombinerBiasNv* = 0x00008549
  GlCombinerAbOutputNv* = 0x0000854A
  GlCombinerCdOutputNv* = 0x0000854B
  GlCombinerSumOutputNv* = 0x0000854C
  GlMaxGeneralCombinersNv* = 0x0000854D
  GlNumGeneralCombinersNv* = 0x0000854E
  GlColorSumClampNv* = 0x0000854F
  GlCombiner0Nv* = 0x00008550
  GlCombiner1Nv* = 0x00008551
  GlCombiner2Nv* = 0x00008552
  GlCombiner3Nv* = 0x00008553
  GlCombiner4Nv* = 0x00008554
  GlCombiner5Nv* = 0x00008555
  GlCombiner6Nv* = 0x00008556
  GlCombiner7Nv* = 0x00008557 # GL_NV_register_combiners2
  GlPerStageConstantsNv* = 0x00008535 # GL_NV_texgen_emboss
  GlEmbossLightNv* = 0x0000855D
  GlEmbossConstantNv* = 0x0000855E
  GlEmbossMapNv* = 0x0000855F # GL_NV_texgen_reflection
  GlNormalMapNv* = 0x00008511
  GlReflectionMapNv* = 0x00008512 # GL_NV_texture_env_combine4
  GlCombine4Nv* = 0x00008503
  GlSource3RgbNv* = 0x00008583
  GlSource3AlphaNv* = 0x0000858B
  GlOperand3RgbNv* = 0x00008593
  GlOperand3AlphaNv* = 0x0000859B # GL_NV_texture_expand_normal
  GlTextureUnsignedRemapModeNv* = 0x0000888F # GL_NV_texture_rectangle
  GlTextureRectangleNv* = 0x000084F5
  GlTextureBindingRectangleNv* = 0x000084F6
  GlProxyTextureRectangleNv* = 0x000084F7
  GlMaxRectangleTextureSizeNv* = 0x000084F8 # GL_NV_texture_shader
  GlOffsetTextureRectangleNv* = 0x0000864C
  GlOffsetTextureRectangleScaleNv* = 0x0000864D
  GlDotProductTextureRectangleNv* = 0x0000864E
  GlRgbaUnsignedDotProductMappingNv* = 0x000086D9
  GlUnsignedIntS8S888Nv* = 0x000086DA
  GlUnsignedInt88S8S8RevNv* = 0x000086DB
  GlDsdtMagIntensityNv* = 0x000086DC
  GlShaderConsistentNv* = 0x000086DD
  GlTextureShaderNv* = 0x000086DE
  GlShaderOperationNv* = 0x000086DF
  GlCullModesNv* = 0x000086E0
  GlOffsetTextureMatrixNv* = 0x000086E1
  GlOffsetTextureScaleNv* = 0x000086E2
  GlOffsetTextureBiasNv* = 0x000086E3
  GlOffsetTexture2dMatrixNv* = GL_OFFSET_TEXTURE_MATRIX_NV
  GlOffsetTexture2dScaleNv* = GL_OFFSET_TEXTURE_SCALE_NV
  GlOffsetTexture2dBiasNv* = GL_OFFSET_TEXTURE_BIAS_NV
  GlPreviousTextureInputNv* = 0x000086E4
  GlConstEyeNv* = 0x000086E5
  GlPassThroughNv* = 0x000086E6
  GlCullFragmentNv* = 0x000086E7
  GlOffsetTexture2dNv* = 0x000086E8
  GlDependentArTexture2dNv* = 0x000086E9
  GlDependentGbTexture2dNv* = 0x000086EA
  GlDotProductNv* = 0x000086EC
  GlDotProductDepthReplaceNv* = 0x000086ED
  GlDotProductTexture2dNv* = 0x000086EE
  GlDotProductTextureCubeMapNv* = 0x000086F0
  GlDotProductDiffuseCubeMapNv* = 0x000086F1
  GlDotProductReflectCubeMapNv* = 0x000086F2
  GlDotProductConstEyeReflectCubeMapNv* = 0x000086F3
  GlHiloNv* = 0x000086F4
  GlDsdtNv* = 0x000086F5
  GlDsdtMagNv* = 0x000086F6
  GlDsdtMagVibNv* = 0x000086F7
  GlHilo16Nv* = 0x000086F8
  GlSignedHiloNv* = 0x000086F9
  GlSignedHilo16Nv* = 0x000086FA
  GlSignedRgbaNv* = 0x000086FB
  GlSignedRgba8Nv* = 0x000086FC
  GlSignedRgbNv* = 0x000086FE
  GlSignedRgb8Nv* = 0x000086FF
  GlSignedLuminanceNv* = 0x00008701
  GlSignedLuminance8Nv* = 0x00008702
  GlSignedLuminanceAlphaNv* = 0x00008703
  GlSignedLuminance8Alpha8Nv* = 0x00008704
  GlSignedAlphaNv* = 0x00008705
  GlSignedAlpha8Nv* = 0x00008706
  GlSignedIntensityNv* = 0x00008707
  GlSignedIntensity8Nv* = 0x00008708
  GlDsdt8Nv* = 0x00008709
  GlDsdt8Mag8Nv* = 0x0000870A
  GlDsdt8Mag8Intensity8Nv* = 0x0000870B
  GlSignedRgbUnsignedAlphaNv* = 0x0000870C
  GlSignedRgb8UnsignedAlpha8Nv* = 0x0000870D
  GlHiScaleNv* = 0x0000870E
  GlLoScaleNv* = 0x0000870F
  GlDsScaleNv* = 0x00008710
  GlDtScaleNv* = 0x00008711
  GlMagnitudeScaleNv* = 0x00008712
  GlVibranceScaleNv* = 0x00008713
  GlHiBiasNv* = 0x00008714
  GlLoBiasNv* = 0x00008715
  GlDsBiasNv* = 0x00008716
  GlDtBiasNv* = 0x00008717
  GlMagnitudeBiasNv* = 0x00008718
  GlVibranceBiasNv* = 0x00008719
  GlTextureBorderValuesNv* = 0x0000871A
  GlTextureHiSizeNv* = 0x0000871B
  GlTextureLoSizeNv* = 0x0000871C
  GlTextureDsSizeNv* = 0x0000871D
  GlTextureDtSizeNv* = 0x0000871E
  GlTextureMagSizeNv* = 0x0000871F # GL_NV_texture_shader2
  GlDotProductTexture3dNv* = 0x000086EF # GL_NV_texture_shader3
  GlOffsetProjectiveTexture2dNv* = 0x00008850
  GlOffsetProjectiveTexture2dScaleNv* = 0x00008851
  GlOffsetProjectiveTextureRectangleNv* = 0x00008852
  GlOffsetProjectiveTextureRectangleScaleNv* = 0x00008853
  GlOffsetHiloTexture2dNv* = 0x00008854
  GlOffsetHiloTextureRectangleNv* = 0x00008855
  GlOffsetHiloProjectiveTexture2dNv* = 0x00008856
  GlOffsetHiloProjectiveTextureRectangleNv* = 0x00008857
  GlDependentHiloTexture2dNv* = 0x00008858
  GlDependentRgbTexture3dNv* = 0x00008859
  GlDependentRgbTextureCubeMapNv* = 0x0000885A
  GlDotProductPassThroughNv* = 0x0000885B
  GlDotProductTexture1dNv* = 0x0000885C
  GlDotProductAffineDepthReplaceNv* = 0x0000885D
  GlHilo8Nv* = 0x0000885E
  GlSignedHilo8Nv* = 0x0000885F
  GlForceBlueToOneNv* = 0x00008860 # GL_NV_vertex_array_range
  cGLVERTEXARRAYRANGENV* = 0x0000851D
  GlVertexArrayRangeLengthNv* = 0x0000851E
  GlVertexArrayRangeValidNv* = 0x0000851F
  GlMaxVertexArrayRangeElementNv* = 0x00008520
  GlVertexArrayRangePointerNv* = 0x00008521 # GL_NV_vertex_array_range2
  GlVertexArrayRangeWithoutFlushNv* = 0x00008533 # GL_NV_vertex_program
  GlVertexProgramNv* = 0x00008620
  GlVertexStateProgramNv* = 0x00008621
  GlAttribArraySizeNv* = 0x00008623
  GlAttribArrayStrideNv* = 0x00008624
  GLATTRIBARRAYtypNV* = 0x00008625
  GlCurrentAttribNv* = 0x00008626
  GlProgramLengthNv* = 0x00008627
  GlProgramStringNv* = 0x00008628
  GlModelviewProjectionNv* = 0x00008629
  GlIdentityNv* = 0x0000862A
  GlInverseNv* = 0x0000862B
  GlTransposeNv* = 0x0000862C
  GlInverseTransposeNv* = 0x0000862D
  GlMaxTrackMatrixStackDepthNv* = 0x0000862E
  GlMaxTrackMatricesNv* = 0x0000862F
  GlMatrix0Nv* = 0x00008630
  GlMatrix1Nv* = 0x00008631
  GlMatrix2Nv* = 0x00008632
  GlMatrix3Nv* = 0x00008633
  GlMatrix4Nv* = 0x00008634
  GlMatrix5Nv* = 0x00008635
  GlMatrix6Nv* = 0x00008636
  GlMatrix7Nv* = 0x00008637
  GlCurrentMatrixStackDepthNv* = 0x00008640
  GlCurrentMatrixNv* = 0x00008641
  GlVertexProgramPointSizeNv* = 0x00008642
  GlVertexProgramTwoSideNv* = 0x00008643
  GlProgramParameterNv* = 0x00008644
  GlAttribArrayPointerNv* = 0x00008645
  GlProgramTargetNv* = 0x00008646
  GlProgramResidentNv* = 0x00008647
  cGLTRACKMATRIXNV* = 0x00008648
  GlTrackMatrixTransformNv* = 0x00008649
  GlVertexProgramBindingNv* = 0x0000864A
  GlProgramErrorPositionNv* = 0x0000864B
  GlVertexAttribArray0Nv* = 0x00008650
  GlVertexAttribArray1Nv* = 0x00008651
  GlVertexAttribArray2Nv* = 0x00008652
  GlVertexAttribArray3Nv* = 0x00008653
  GlVertexAttribArray4Nv* = 0x00008654
  GlVertexAttribArray5Nv* = 0x00008655
  GlVertexAttribArray6Nv* = 0x00008656
  GlVertexAttribArray7Nv* = 0x00008657
  GlVertexAttribArray8Nv* = 0x00008658
  GlVertexAttribArray9Nv* = 0x00008659
  GlVertexAttribArray10Nv* = 0x0000865A
  GlVertexAttribArray11Nv* = 0x0000865B
  GlVertexAttribArray12Nv* = 0x0000865C
  GlVertexAttribArray13Nv* = 0x0000865D
  GlVertexAttribArray14Nv* = 0x0000865E
  GlVertexAttribArray15Nv* = 0x0000865F
  GlMap1VertexAttrib04Nv* = 0x00008660
  GlMap1VertexAttrib14Nv* = 0x00008661
  GlMap1VertexAttrib24Nv* = 0x00008662
  GlMap1VertexAttrib34Nv* = 0x00008663
  GlMap1VertexAttrib44Nv* = 0x00008664
  GlMap1VertexAttrib54Nv* = 0x00008665
  GlMap1VertexAttrib64Nv* = 0x00008666
  GlMap1VertexAttrib74Nv* = 0x00008667
  GlMap1VertexAttrib84Nv* = 0x00008668
  GlMap1VertexAttrib94Nv* = 0x00008669
  GlMap1VertexAttrib104Nv* = 0x0000866A
  GlMap1VertexAttrib114Nv* = 0x0000866B
  GlMap1VertexAttrib124Nv* = 0x0000866C
  GlMap1VertexAttrib134Nv* = 0x0000866D
  GlMap1VertexAttrib144Nv* = 0x0000866E
  GlMap1VertexAttrib154Nv* = 0x0000866F
  GlMap2VertexAttrib04Nv* = 0x00008670
  GlMap2VertexAttrib14Nv* = 0x00008671
  GlMap2VertexAttrib24Nv* = 0x00008672
  GlMap2VertexAttrib34Nv* = 0x00008673
  GlMap2VertexAttrib44Nv* = 0x00008674
  GlMap2VertexAttrib54Nv* = 0x00008675
  GlMap2VertexAttrib64Nv* = 0x00008676
  GlMap2VertexAttrib74Nv* = 0x00008677
  GlMap2VertexAttrib84Nv* = 0x00008678
  GlMap2VertexAttrib94Nv* = 0x00008679
  GlMap2VertexAttrib104Nv* = 0x0000867A
  GlMap2VertexAttrib114Nv* = 0x0000867B
  GlMap2VertexAttrib124Nv* = 0x0000867C
  GlMap2VertexAttrib134Nv* = 0x0000867D
  GlMap2VertexAttrib144Nv* = 0x0000867E
  GlMap2VertexAttrib154Nv* = 0x0000867F # GL_NV_fragment_program2 and GL_NV_vertex_program2_option
  GlMaxProgramExecInstructionsNv* = 0x000088F4
  GlMaxProgramCallDepthNv* = 0x000088F5 # GL_NV_fragment_program2
  GlMaxProgramIfDepthNv* = 0x000088F6
  GlMaxProgramLoopDepthNv* = 0x000088F7
  GlMaxProgramLoopCountNv* = 0x000088F8 # GL_NV_vertex_program3
  MaxVertexTextureImageUnitsArb* = 0x00008B4C # GL_NV_depth_buffer_float
  GlFloat32UnsignedInt248RevNv* = 0x00008DAD
  GlDepthBufferFloatModeNv* = 0x00008DAF # 
                                              # GL_NV_framebuffer_multisample_coverage
  GlRenderbufferCoverageSamplesNv* = 0x00008CAB
  GlRenderbufferColorSamplesNv* = 0x00008E10 # GL_NV_geometry_program4
  GlGeometryProgramNv* = 0x00008C26
  GlMaxProgramOutputVerticesNv* = 0x00008C27
  GlMaxProgramTotalOutputComponentsNv* = 0x00008C28 # GL_NV_gpu_program4
  GlProgramAttribComponentsNv* = 0x00008906
  GlProgramResultComponentsNv* = 0x00008907
  GlMaxProgramAttribComponentsNv* = 0x00008908
  GlMaxProgramResultComponentsNv* = 0x00008909
  GlMaxProgramGenericAttribsNv* = 0x00008DA5
  GlMaxProgramGenericResultsNv* = 0x00008DA6 # GL_NV_parameter_buffer_object
  GlMaxProgramParameterBufferBindingsNv* = 0x00008DA0
  GlMaxProgramParameterBufferSizeNv* = 0x00008DA1
  GlVertexProgramParameterBufferNv* = 0x00008DA2
  GlGeometryProgramParameterBufferNv* = 0x00008DA3
  GlFragmentProgramParameterBufferNv* = 0x00008DA4 # GL_NV_transform_feedback
  GlTransformFeedbackBufferNv* = 0x00008C8E
  GlTransformFeedbackBufferStartNv* = 0x00008C84
  GlTransformFeedbackBufferSizeNv* = 0x00008C85
  GlTransformFeedbackRecordNv* = 0x00008C86
  GlTransformFeedbackBufferBindingNv* = 0x00008C8F
  GlInterleavedAttribsNv* = 0x00008C8C
  GlSeparateAttribsNv* = 0x00008C8D
  GlPrimitivesGeneratedNv* = 0x00008C87
  GlTransformFeedbackPrimitivesWrittenNv* = 0x00008C88
  GlRasterizerDiscardNv* = 0x00008C89
  GlMaxTransformFeedbackInterleavedComponentsNv* = 0x00008C8A
  GlMaxTransformFeedbackSeparateAttribsNv* = 0x00008C8B
  GlMaxTransformFeedbackSeparateComponentsNv* = 0x00008C80
  cGLTRANSFORMFEEDBACKATTRIBSNV* = 0x00008C7E
  GlActiveVaryingsNv* = 0x00008C81
  GlActiveVaryingMaxLengthNv* = 0x00008C82
  cGLTRANSFORMFEEDBACKVARYINGSNV* = 0x00008C83
  GlTransformFeedbackBufferModeNv* = 0x00008C7F
  GlBackPrimaryColorNv* = 0x00008C77
  GlBackSecondaryColorNv* = 0x00008C78
  GlTextureCoordNv* = 0x00008C79
  GlClipDistanceNv* = 0x00008C7A
  GlVertexIdNv* = 0x00008C7B
  GlPrimitiveIdNv* = 0x00008C7C
  GlGenericAttribNv* = 0x00008C7D
  GlLayerNv* = 0x00008DAA
  GlNextBufferNv* = - 2
  GlSkipComponents4Nv* = - 3
  GlSkipComponents3Nv* = - 4
  GlSkipComponents2Nv* = - 5
  GlSkipComponents1Nv* = - 6 # GL_NV_conditional_render
  GlQueryWaitNv* = 0x00008E13
  GlQueryNoWaitNv* = 0x00008E14
  GlQueryByRegionWaitNv* = 0x00008E15
  GlQueryByRegionNoWaitNv* = 0x00008E16 # GL_NV_present_video
  GlFrameNv* = 0x00008E26
  GlFieldsNv* = 0x00008E27
  GlCurrentTimeNv* = 0x00008E28
  GlNumFillStreamsNv* = 0x00008E29
  GlPresentTimeNv* = 0x00008E2A
  GlPresentDurationNv* = 0x00008E2B # GL_NV_explicit_multisample
  GlSamplePositionNv* = 0x00008E50
  GlSampleMaskNv* = 0x00008E51
  GlSampleMaskValueNv* = 0x00008E52
  GlTextureBindingRenderbufferNv* = 0x00008E53
  GlTextureRenderbufferDataStoreBindingNv* = 0x00008E54
  GlTextureRenderbufferNv* = 0x00008E55
  GlSamplerRenderbufferNv* = 0x00008E56
  GlIntSamplerRenderbufferNv* = 0x00008E57
  GlUnsignedIntSamplerRenderbufferNv* = 0x00008E58
  GlMaxSampleMaskWordsNv* = 0x00008E59 # GL_NV_transform_feedback2
  GlTransformFeedbackNv* = 0x00008E22
  GlTransformFeedbackBufferPausedNv* = 0x00008E23
  GlTransformFeedbackBufferActiveNv* = 0x00008E24
  GlTransformFeedbackBindingNv* = 0x00008E25 # GL_NV_video_capture
  GlVideoBufferNv* = 0x00009020
  GlVideoBufferBindingNv* = 0x00009021
  GlFieldUpperNv* = 0x00009022
  GlFieldLowerNv* = 0x00009023
  GlNumVideoCaptureStreamsNv* = 0x00009024
  GlNextVideoCaptureBufferStatusNv* = 0x00009025
  GlVideoCaptureTo422SupportedNv* = 0x00009026
  GlLastVideoCaptureStatusNv* = 0x00009027
  GlVideoBufferPitchNv* = 0x00009028
  GlVideoColorConversionMatrixNv* = 0x00009029
  GlVideoColorConversionMaxNv* = 0x0000902A
  GlVideoColorConversionMinNv* = 0x0000902B
  GlVideoColorConversionOffsetNv* = 0x0000902C
  GlVideoBufferInternalFormatNv* = 0x0000902D
  GlPartialSuccessNv* = 0x0000902E
  GlSuccessNv* = 0x0000902F
  GlFailureNv* = 0x00009030
  GlYcbycr8422Nv* = 0x00009031
  GlYcbaycr8a4224Nv* = 0x00009032
  GlZ6y10z6cb10z6y10z6cr10422Nv* = 0x00009033
  GlZ6y10z6cb10z6a10z6y10z6cr10z6a104224Nv* = 0x00009034
  GlZ4y12z4cb12z4y12z4cr12422Nv* = 0x00009035
  GlZ4y12z4cb12z4a12z4y12z4cr12z4a124224Nv* = 0x00009036
  GlZ4y12z4cb12z4cr12444Nv* = 0x00009037
  GlVideoCaptureFrameWidthNv* = 0x00009038
  GlVideoCaptureFrameHeightNv* = 0x00009039
  GlVideoCaptureFieldUpperHeightNv* = 0x0000903A
  GlVideoCaptureFieldLowerHeightNv* = 0x0000903B
  GlVideoCaptureSurfaceOriginNv* = 0x0000903C # GL_NV_shader_buffer_load
  GlBufferGpuAddressNv* = 0x00008F1D
  GlGpuAddressNv* = 0x00008F34
  GlMaxShaderBufferAddressNv* = 0x00008F35 # 
                                                # GL_NV_vertex_buffer_unified_memory
  GlVertexAttribArrayUnifiedNv* = 0x00008F1E
  GlElementArrayUnifiedNv* = 0x00008F1F
  GlVertexAttribArrayAddressNv* = 0x00008F20
  GlVertexArrayAddressNv* = 0x00008F21
  GlNormalArrayAddressNv* = 0x00008F22
  GlColorArrayAddressNv* = 0x00008F23
  GlIndexArrayAddressNv* = 0x00008F24
  GlTextureCoordArrayAddressNv* = 0x00008F25
  GlEdgeFlagArrayAddressNv* = 0x00008F26
  GlSecondaryColorArrayAddressNv* = 0x00008F27
  GlFogCoordArrayAddressNv* = 0x00008F28
  GlElementArrayAddressNv* = 0x00008F29
  GlVertexAttribArrayLengthNv* = 0x00008F2A
  GlVertexArrayLengthNv* = 0x00008F2B
  GlNormalArrayLengthNv* = 0x00008F2C
  GlColorArrayLengthNv* = 0x00008F2D
  GlIndexArrayLengthNv* = 0x00008F2E
  GlTextureCoordArrayLengthNv* = 0x00008F2F
  GlEdgeFlagArrayLengthNv* = 0x00008F30
  GlSecondaryColorArrayLengthNv* = 0x00008F31
  GlFogCoordArrayLengthNv* = 0x00008F32
  GlElementArrayLengthNv* = 0x00008F33
  GlDrawIndirectUnifiedNv* = 0x00008F40
  GlDrawIndirectAddressNv* = 0x00008F41
  GlDrawIndirectLengthNv* = 0x00008F42 # GL_NV_gpu_program5
  GlMaxGeometryProgramInvocationsNv* = 0x00008E5A
  GlMinFragmentInterpolationOffsetNv* = 0x00008E5B
  GlMaxFragmentInterpolationOffsetNv* = 0x00008E5C
  GlFragmentProgramInterpolationOffsetBitsNv* = 0x00008E5D
  GlMinProgramTextureGatherOffsetNv* = 0x00008E5E
  GlMaxProgramTextureGatherOffsetNv* = 0x00008E5F
  GlMaxProgramSubroutineParametersNv* = 0x00008F44
  GlMaxProgramSubroutineNumNv* = 0x00008F45 # GL_NV_gpu_shader5
  GlInt64Nv* = 0x0000140E
  GlUnsignedInt64Nv* = 0x0000140F
  GlInt8Nv* = 0x00008FE0
  GlInt8Vec2Nv* = 0x00008FE1
  GlInt8Vec3Nv* = 0x00008FE2
  GlInt8Vec4Nv* = 0x00008FE3
  GlInt16Nv* = 0x00008FE4
  GlInt16Vec2Nv* = 0x00008FE5
  GlInt16Vec3Nv* = 0x00008FE6
  GlInt16Vec4Nv* = 0x00008FE7
  GlInt64Vec2Nv* = 0x00008FE9
  GlInt64Vec3Nv* = 0x00008FEA
  GlInt64Vec4Nv* = 0x00008FEB
  GlUnsignedInt8Nv* = 0x00008FEC
  GlUnsignedInt8Vec2Nv* = 0x00008FED
  GlUnsignedInt8Vec3Nv* = 0x00008FEE
  GlUnsignedInt8Vec4Nv* = 0x00008FEF
  GlUnsignedInt16Nv* = 0x00008FF0
  GlUnsignedInt16Vec2Nv* = 0x00008FF1
  GlUnsignedInt16Vec3Nv* = 0x00008FF2
  GlUnsignedInt16Vec4Nv* = 0x00008FF3
  GlUnsignedInt64Vec2Nv* = 0x00008FF5
  GlUnsignedInt64Vec3Nv* = 0x00008FF6
  GlUnsignedInt64Vec4Nv* = 0x00008FF7
  GlFloat16Nv* = 0x00008FF8
  GlFloat16Vec2Nv* = 0x00008FF9
  GlFloat16Vec3Nv* = 0x00008FFA
  GlFloat16Vec4Nv* = 0x00008FFB # reuse GL_PATCHES 
                                   # GL_NV_shader_buffer_store
  GlShaderGlobalAccessBarrierBitNv* = 0x00000010 # reuse GL_READ_WRITE 
                                                       # reuse GL_WRITE_ONLY 
                                                       # 
                                                       # GL_NV_tessellation_program5
  GlMaxProgramPatchAttribsNv* = 0x000086D8
  GlTessControlProgramNv* = 0x0000891E
  GlTessEvaluationProgramNv* = 0x0000891F
  GlTessControlProgramParameterBufferNv* = 0x00008C74
  GlTessEvaluationProgramParameterBufferNv* = 0x00008C75 # 
                                                               # GL_NV_vertex_attrib_integer_64bit
                                                               # reuse GL_INT64_NV 
                                                               # reuse 
                                                               # GL_UNSIGNED_INT64_NV 
                                                               # 
                                                               # GL_NV_multisample_coverage
  GlCoverageSamplesNv* = 0x000080A9
  GlColorSamplesNv* = 0x00008E20 # GL_NV_vdpau_interop
  GlSurfaceStateNv* = 0x000086EB
  GlSurfaceRegisteredNv* = 0x000086FD
  GlSurfaceMappedNv* = 0x00008700
  GlWriteDiscardNv* = 0x000088BE # GL_OML_interlace
  GlInterlaceOml* = 0x00008980
  GlInterlaceReadOml* = 0x00008981 # GL_OML_resample
  GlPackResampleOml* = 0x00008984
  GlUnpackResampleOml* = 0x00008985
  GlResampleReplicateOml* = 0x00008986
  GlResampleZeroFillOml* = 0x00008987
  GlResampleAverageOml* = 0x00008988
  GlResampleDecimateOml* = 0x00008989 # GL_OML_subsample
  GlFormatSubsample2424Oml* = 0x00008982
  GlFormatSubsample244244Oml* = 0x00008983 # GL_PGI_misc_hints
  GlPreferDoublebufferHintPgi* = 0x0001A1F8
  GlConserveMemoryHintPgi* = 0x0001A1FD
  GlReclaimMemoryHintPgi* = 0x0001A1FE
  GlNativeGraphicsHandlePgi* = 0x0001A202
  GlNativeGraphicsBeginHintPgi* = 0x0001A203
  GlNativeGraphicsEndHintPgi* = 0x0001A204
  GlAlwaysFastHintPgi* = 0x0001A20C
  GlAlwaysSoftHintPgi* = 0x0001A20D
  GlAllowDrawObjHintPgi* = 0x0001A20E
  GlAllowDrawWinHintPgi* = 0x0001A20F
  GlAllowDrawFrgHintPgi* = 0x0001A210
  GlAllowDrawMemHintPgi* = 0x0001A211
  GlStrictDepthfuncHintPgi* = 0x0001A216
  GlStrictLightingHintPgi* = 0x0001A217
  GlStrictScissorHintPgi* = 0x0001A218
  GlFullStippleHintPgi* = 0x0001A219
  GlClipNearHintPgi* = 0x0001A220
  GlClipFarHintPgi* = 0x0001A221
  GlWideLineHintPgi* = 0x0001A222
  GlBackNormalsHintPgi* = 0x0001A223 # GL_PGI_vertex_hints
  GlVertexDataHintPgi* = 0x0001A22A
  GlVertexConsistentHintPgi* = 0x0001A22B
  GlMaterialSideHintPgi* = 0x0001A22C
  GlMaxVertexHintPgi* = 0x0001A22D
  GlColor3BitPgi* = 0x00010000
  GlColor4BitPgi* = 0x00020000
  GlEdgeflagBitPgi* = 0x00040000
  GlIndexBitPgi* = 0x00080000
  GlMatAmbientBitPgi* = 0x00100000
  GlMatAmbientAndDiffuseBitPgi* = 0x00200000
  GlMatDiffuseBitPgi* = 0x00400000
  GlMatEmissionBitPgi* = 0x00800000
  GlMatColorIndexesBitPgi* = 0x01000000
  GlMatShininessBitPgi* = 0x02000000
  GlMatSpecularBitPgi* = 0x04000000
  GlNormalBitPgi* = 0x08000000
  GlTexcoord1BitPgi* = 0x10000000
  GlTexcoord2BitPgi* = 0x20000000
  GlTexcoord3BitPgi* = 0x40000000
  GlTexcoord4BitPgi* = 0x80000000
  GlVertex23BitPgi* = 0x00000004
  GlVertex4BitPgi* = 0x00000008 # GL_REND_screen_coordinates
  GlScreenCoordinatesRend* = 0x00008490
  GlInvertedScreenWRend* = 0x00008491 # GL_S3_s3tc
  GlRgbS3tc* = 0x000083A0
  GlRgb4S3tc* = 0x000083A1
  GlRgbaS3tc* = 0x000083A2
  GlRgba4S3tc* = 0x000083A3 # GL_SGIS_detail_texture
  GlDetailTexture2dSgis* = 0x00008095
  GlDetailTexture2dBindingSgis* = 0x00008096
  GlLinearDetailSgis* = 0x00008097
  GlLinearDetailAlphaSgis* = 0x00008098
  GlLinearDetailColorSgis* = 0x00008099
  GlDetailTextureLevelSgis* = 0x0000809A
  GlDetailTextureModeSgis* = 0x0000809B
  GlDetailTextureFuncPointsSgis* = 0x0000809C # GL_SGIS_fog_function
  cGLFOGFUNCSGIS* = 0x0000812A
  GlFogFuncPointsSgis* = 0x0000812B
  GlMaxFogFuncPointsSgis* = 0x0000812C # GL_SGIS_generate_mipmap
  GlGenerateMipmapSgis* = 0x00008191
  GlGenerateMipmapHintSgis* = 0x00008192 # GL_SGIS_multisample
  GlMultisampleSgis* = 0x0000809D
  GlSampleAlphaToMaskSgis* = 0x0000809E
  GlSampleAlphaToOneSgis* = 0x0000809F
  cGLSAMPLEMASKSGIS* = 0x000080A0
  Gl1passSgis* = 0x000080A1
  Gl2pass0Sgis* = 0x000080A2
  Gl2pass1Sgis* = 0x000080A3
  Gl4pass0Sgis* = 0x000080A4
  Gl4pass1Sgis* = 0x000080A5
  Gl4pass2Sgis* = 0x000080A6
  Gl4pass3Sgis* = 0x000080A7
  GlSampleBuffersSgis* = 0x000080A8
  GlSamplesSgis* = 0x000080A9
  GlSampleMaskValueSgis* = 0x000080AA
  GlSampleMaskInvertSgis* = 0x000080AB
  cGLSAMPLEPATTERNSGIS* = 0x000080AC # GL_SGIS_pixel_texture
  GlPixelTextureSgis* = 0x00008353
  GlPixelFragmentRgbSourceSgis* = 0x00008354
  GlPixelFragmentAlphaSourceSgis* = 0x00008355
  GlPixelGroupColorSgis* = 0x00008356 # GL_SGIS_point_line_texgen
  GlEyeDistanceToPointSgis* = 0x000081F0
  GlObjectDistanceToPointSgis* = 0x000081F1
  GlEyeDistanceToLineSgis* = 0x000081F2
  GlObjectDistanceToLineSgis* = 0x000081F3
  GlEyePointSgis* = 0x000081F4
  GlObjectPointSgis* = 0x000081F5
  GlEyeLineSgis* = 0x000081F6
  GlObjectLineSgis* = 0x000081F7 # GL_SGIS_point_parameters
  GlPointSizeMinSgis* = 0x00008126
  GlPointSizeMaxSgis* = 0x00008127
  GlPointFadeThresholdSizeSgis* = 0x00008128
  GlDistanceAttenuationSgis* = 0x00008129 # GL_SGIS_sharpen_texture
  GlLinearSharpenSgis* = 0x000080AD
  GlLinearSharpenAlphaSgis* = 0x000080AE
  GlLinearSharpenColorSgis* = 0x000080AF
  GlSharpenTextureFuncPointsSgis* = 0x000080B0 # GL_SGIS_texture4D
  GlPackSkipVolumesSgis* = 0x00008130
  GlPackImageDepthSgis* = 0x00008131
  GlUnpackSkipVolumesSgis* = 0x00008132
  GlUnpackImageDepthSgis* = 0x00008133
  GlTexture4dSgis* = 0x00008134
  GlProxyTexture4dSgis* = 0x00008135
  GlTexture4dsizeSgis* = 0x00008136
  GlTextureWrapQSgis* = 0x00008137
  GlMax4dTextureSizeSgis* = 0x00008138
  GlTexture4dBindingSgis* = 0x0000814F # GL_SGIS_texture_color_mask
  GlTextureColorWritemaskSgis* = 0x000081EF # GL_SGIS_texture_edge_clamp
  GlClampToEdgeSgis* = 0x0000812F # GL_SGIS_texture_filter4
  GlFilter4Sgis* = 0x00008146
  GlTextureFilter4SizeSgis* = 0x00008147 # GL_SGIS_texture_lod
  GlTextureMinLodSgis* = 0x0000813A
  GlTextureMaxLodSgis* = 0x0000813B
  GlTextureBaseLevelSgis* = 0x0000813C
  GlTextureMaxLevelSgis* = 0x0000813D # GL_SGIS_texture_select
  GlDualAlpha4Sgis* = 0x00008110
  GlDualAlpha8Sgis* = 0x00008111
  GlDualAlpha12Sgis* = 0x00008112
  GlDualAlpha16Sgis* = 0x00008113
  GlDualLuminance4Sgis* = 0x00008114
  GlDualLuminance8Sgis* = 0x00008115
  GlDualLuminance12Sgis* = 0x00008116
  GlDualLuminance16Sgis* = 0x00008117
  GlDualIntensity4Sgis* = 0x00008118
  GlDualIntensity8Sgis* = 0x00008119
  GlDualIntensity12Sgis* = 0x0000811A
  GlDualIntensity16Sgis* = 0x0000811B
  GlDualLuminanceAlpha4Sgis* = 0x0000811C
  GlDualLuminanceAlpha8Sgis* = 0x0000811D
  GlQuadAlpha4Sgis* = 0x0000811E
  GlQuadAlpha8Sgis* = 0x0000811F
  GlQuadLuminance4Sgis* = 0x00008120
  GlQuadLuminance8Sgis* = 0x00008121
  GlQuadIntensity4Sgis* = 0x00008122
  GlQuadIntensity8Sgis* = 0x00008123
  GlDualTextureSelectSgis* = 0x00008124
  GlQuadTextureSelectSgis* = 0x00008125 # GL_SGIX_async
  cGLASYNCMARKERSGIX* = 0x00008329 # GL_SGIX_async_histogram
  GlAsyncHistogramSgix* = 0x0000832C
  GlMaxAsyncHistogramSgix* = 0x0000832D # GL_SGIX_async_pixel
  GlAsyncTexImageSgix* = 0x0000835C
  GlAsyncDrawPixelsSgix* = 0x0000835D
  GlAsyncReadPixelsSgix* = 0x0000835E
  GlMaxAsyncTexImageSgix* = 0x0000835F
  GlMaxAsyncDrawPixelsSgix* = 0x00008360
  GlMaxAsyncReadPixelsSgix* = 0x00008361 # GL_SGIX_blend_alpha_minmax
  GlAlphaMinSgix* = 0x00008320
  GlAlphaMaxSgix* = 0x00008321 # GL_SGIX_calligraphic_fragment
  GlCalligraphicFragmentSgix* = 0x00008183 # GL_SGIX_clipmap
  GlLinearClipmapLinearSgix* = 0x00008170
  GlTextureClipmapCenterSgix* = 0x00008171
  GlTextureClipmapFrameSgix* = 0x00008172
  GlTextureClipmapOffsetSgix* = 0x00008173
  GlTextureClipmapVirtualDepthSgix* = 0x00008174
  GlTextureClipmapLodOffsetSgix* = 0x00008175
  GlTextureClipmapDepthSgix* = 0x00008176
  GlMaxClipmapDepthSgix* = 0x00008177
  GlMaxClipmapVirtualDepthSgix* = 0x00008178
  GlNearestClipmapNearestSgix* = 0x0000844D
  GlNearestClipmapLinearSgix* = 0x0000844E
  GlLinearClipmapNearestSgix* = 0x0000844F # GL_SGIX_convolution_accuracy
  GlConvolutionHintSgix* = 0x00008316 # GL_SGIX_depth_texture
  GlDepthComponent16Sgix* = 0x000081A5
  GlDepthComponent24Sgix* = 0x000081A6
  GlDepthComponent32Sgix* = 0x000081A7 # GL_SGIX_fog_offset
  GlFogOffsetSgix* = 0x00008198
  GlFogOffsetValueSgix* = 0x00008199 # GL_SGIX_fog_scale
  GlFogScaleSgix* = 0x000081FC
  GlFogScaleValueSgix* = 0x000081FD # GL_SGIX_fragment_lighting
  GlFragmentLightingSgix* = 0x00008400
  cGLFRAGMENTCOLORMATERIALSGIX* = 0x00008401
  GlFragmentColorMaterialFaceSgix* = 0x00008402
  GlFragmentColorMaterialParameterSgix* = 0x00008403
  GlMaxFragmentLightsSgix* = 0x00008404
  GlMaxActiveLightsSgix* = 0x00008405
  GlCurrentRasterNormalSgix* = 0x00008406
  GlLightEnvModeSgix* = 0x00008407
  GlFragmentLightModelLocalViewerSgix* = 0x00008408
  GlFragmentLightModelTwoSideSgix* = 0x00008409
  GlFragmentLightModelAmbientSgix* = 0x0000840A
  GlFragmentLightModelNormalInterpolationSgix* = 0x0000840B
  GlFragmentLight0Sgix* = 0x0000840C
  GlFragmentLight1Sgix* = 0x0000840D
  GlFragmentLight2Sgix* = 0x0000840E
  GlFragmentLight3Sgix* = 0x0000840F
  GlFragmentLight4Sgix* = 0x00008410
  GlFragmentLight5Sgix* = 0x00008411
  GlFragmentLight6Sgix* = 0x00008412
  GlFragmentLight7Sgix* = 0x00008413 # GL_SGIX_framezoom
  cGLFRAMEZOOMSGIX* = 0x0000818B
  GlFramezoomFactorSgix* = 0x0000818C
  GlMaxFramezoomFactorSgix* = 0x0000818D # GL_SGIX_impact_pixel_texture
  GlPixelTexGenQCeilingSgix* = 0x00008184
  GlPixelTexGenQRoundSgix* = 0x00008185
  GlPixelTexGenQFloorSgix* = 0x00008186
  GlPixelTexGenAlphaReplaceSgix* = 0x00008187
  GlPixelTexGenAlphaNoReplaceSgix* = 0x00008188
  GlPixelTexGenAlphaLsSgix* = 0x00008189
  GlPixelTexGenAlphaMsSgix* = 0x0000818A # GL_SGIX_instruments
  GlInstrumentBufferPointerSgix* = 0x00008180
  GlInstrumentMeasurementsSgix* = 0x00008181 # GL_SGIX_interlace
  GlInterlaceSgix* = 0x00008094 # GL_SGIX_ir_instrument1
  GlIrInstrument1Sgix* = 0x0000817F # GL_SGIX_list_priority
  GlListPrioritySgix* = 0x00008182 # GL_SGIX_pixel_texture
  cGLPIXELTEXGENSGIX* = 0x00008139
  GlPixelTexGenModeSgix* = 0x0000832B # GL_SGIX_pixel_tiles
  GlPixelTileBestAlignmentSgix* = 0x0000813E
  GlPixelTileCacheIncrementSgix* = 0x0000813F
  GlPixelTileWidthSgix* = 0x00008140
  GlPixelTileHeightSgix* = 0x00008141
  GlPixelTileGridWidthSgix* = 0x00008142
  GlPixelTileGridHeightSgix* = 0x00008143
  GlPixelTileGridDepthSgix* = 0x00008144
  GlPixelTileCacheSizeSgix* = 0x00008145 # GL_SGIX_polynomial_ffd
  GlGeometryDeformationSgix* = 0x00008194
  GlTextureDeformationSgix* = 0x00008195
  GlDeformationsMaskSgix* = 0x00008196
  GlMaxDeformationOrderSgix* = 0x00008197 # GL_SGIX_reference_plane
  cGLREFERENCEPLANESGIX* = 0x0000817D
  GlReferencePlaneEquationSgix* = 0x0000817E # GL_SGIX_resample
  GlPackResampleSgix* = 0x0000842C
  GlUnpackResampleSgix* = 0x0000842D
  GlResampleReplicateSgix* = 0x0000842E
  GlResampleZeroFillSgix* = 0x0000842F
  GlResampleDecimateSgix* = 0x00008430 # GL_SGIX_scalebias_hint
  GlScalebiasHintSgix* = 0x00008322 # GL_SGIX_shadow
  GlTextureCompareSgix* = 0x0000819A
  GlTextureCompareOperatorSgix* = 0x0000819B
  GlTextureLequalRSgix* = 0x0000819C
  GlTextureGequalRSgix* = 0x0000819D # GL_SGIX_shadow_ambient
  GlShadowAmbientSgix* = 0x000080BF # GL_SGIX_sprite
  GlSpriteSgix* = 0x00008148
  GlSpriteModeSgix* = 0x00008149
  GlSpriteAxisSgix* = 0x0000814A
  GlSpriteTranslationSgix* = 0x0000814B
  GlSpriteAxialSgix* = 0x0000814C
  GlSpriteObjectAlignedSgix* = 0x0000814D
  GlSpriteEyeAlignedSgix* = 0x0000814E # GL_SGIX_subsample
  GlPackSubsampleRateSgix* = 0x000085A0
  GlUnpackSubsampleRateSgix* = 0x000085A1
  GlPixelSubsample4444Sgix* = 0x000085A2
  GlPixelSubsample2424Sgix* = 0x000085A3
  GlPixelSubsample4242Sgix* = 0x000085A4 # GL_SGIX_texture_add_env
  GlTextureEnvBiasSgix* = 0x000080BE # GL_SGIX_texture_coordinate_clamp
  GlTextureMaxClampSSgix* = 0x00008369
  GlTextureMaxClampTSgix* = 0x0000836A
  GlTextureMaxClampRSgix* = 0x0000836B # GL_SGIX_texture_lod_bias
  GlTextureLodBiasSSgix* = 0x0000818E
  GlTextureLodBiasTSgix* = 0x0000818F
  GlTextureLodBiasRSgix* = 0x00008190 # GL_SGIX_texture_multi_buffer
  GlTextureMultiBufferHintSgix* = 0x0000812E # GL_SGIX_texture_scale_bias
  GlPostTextureFilterBiasSgix* = 0x00008179
  GlPostTextureFilterScaleSgix* = 0x0000817A
  GlPostTextureFilterBiasRangeSgix* = 0x0000817B
  GlPostTextureFilterScaleRangeSgix* = 0x0000817C # GL_SGIX_vertex_preclip
  GlVertexPreclipSgix* = 0x000083EE
  GlVertexPreclipHintSgix* = 0x000083EF # GL_SGIX_ycrcb
  GlYcrcb422Sgix* = 0x000081BB
  GlYcrcb444Sgix* = 0x000081BC # GL_SGIX_ycrcba
  GlYcrcbSgix* = 0x00008318
  GlYcrcbaSgix* = 0x00008319 # GL_SGI_color_matrix
  GlColorMatrixSgi* = 0x000080B1
  GlColorMatrixStackDepthSgi* = 0x000080B2
  GlMaxColorMatrixStackDepthSgi* = 0x000080B3
  GlPostColorMatrixRedScaleSgi* = 0x000080B4
  GlPostColorMatrixGreenScaleSgi* = 0x000080B5
  GlPostColorMatrixBlueScaleSgi* = 0x000080B6
  GlPostColorMatrixAlphaScaleSgi* = 0x000080B7
  GlPostColorMatrixRedBiasSgi* = 0x000080B8
  GlPostColorMatrixGreenBiasSgi* = 0x000080B9
  GlPostColorMatrixBlueBiasSgi* = 0x000080BA
  GlPostColorMatrixAlphaBiasSgi* = 0x000080BB # GL_SGI_color_table
  cGLCOLORTABLESGI* = 0x000080D0
  GlPostConvolutionColorTableSgi* = 0x000080D1
  GlPostColorMatrixColorTableSgi* = 0x000080D2
  GlProxyColorTableSgi* = 0x000080D3
  GlProxyPostConvolutionColorTableSgi* = 0x000080D4
  GlProxyPostColorMatrixColorTableSgi* = 0x000080D5
  GlColorTableScaleSgi* = 0x000080D6
  GlColorTableBiasSgi* = 0x000080D7
  GlColorTableFormatSgi* = 0x000080D8
  GlColorTableWidthSgi* = 0x000080D9
  GlColorTableRedSizeSgi* = 0x000080DA
  GlColorTableGreenSizeSgi* = 0x000080DB
  GlColorTableBlueSizeSgi* = 0x000080DC
  GlColorTableAlphaSizeSgi* = 0x000080DD
  GlColorTableLuminanceSizeSgi* = 0x000080DE
  GlColorTableIntensitySizeSgi* = 0x000080DF # GL_SGI_depth_pass_instrument
  GlDepthPassInstrumentSgix* = 0x00008310
  GlDepthPassInstrumentCountersSgix* = 0x00008311
  GlDepthPassInstrumentMaxSgix* = 0x00008312 # GL_SGI_texture_color_table
  GlTextureColorTableSgi* = 0x000080BC
  GlProxyTextureColorTableSgi* = 0x000080BD # GL_SUNX_constant_data
  GlUnpackConstantDataSunx* = 0x000081D5
  GlTextureConstantDataSunx* = 0x000081D6 # GL_SUN_convolution_border_modes
  GlWrapBorderSun* = 0x000081D4 # GL_SUN_global_alpha
  GlGlobalAlphaSun* = 0x000081D9
  GlGlobalAlphaFactorSun* = 0x000081DA # GL_SUN_mesh_array
  GlQuadMeshSun* = 0x00008614
  GlTriangleMeshSun* = 0x00008615 # GL_SUN_slice_accum
  GlSliceAccumSun* = 0x000085CC # GL_SUN_triangle_list
  GlRestartSun* = 0x00000001
  GlReplaceMiddleSun* = 0x00000002
  GlReplaceOldestSun* = 0x00000003
  GlTriangleListSun* = 0x000081D7
  GlReplacementCodeSun* = 0x000081D8
  GlReplacementCodeArraySun* = 0x000085C0
  GLREPLACEMENTCODEARRAYtypSUN* = 0x000085C1
  GlReplacementCodeArrayStrideSun* = 0x000085C2
  GlReplacementCodeArrayPointerSun* = 0x000085C3
  GlR1uiV3fSun* = 0x000085C4
  GlR1uiC4ubV3fSun* = 0x000085C5
  GlR1uiC3fV3fSun* = 0x000085C6
  GlR1uiN3fV3fSun* = 0x000085C7
  GlR1uiC4fN3fV3fSun* = 0x000085C8
  GlR1uiT2fV3fSun* = 0x000085C9
  GlR1uiT2fN3fV3fSun* = 0x000085CA
  GlR1uiT2fC4fN3fV3fSun* = 0x000085CB # GL_WIN_phong_shading
  GlPhongWin* = 0x000080EA
  GlPhongHintWin* = 0x000080EB # GL_WIN_specular_fog
  GlFogSpecularTextureWin* = 0x000080EC # GL_ARB_vertex_shader
  GlVertexShaderArb* = 0x00008B31
  GlMaxVertexUniformComponentsArb* = 0x00008B4A
  GlMaxVaryingFloatsArb* = 0x00008B4B
  GlMaxVertexTextureImageUnitsArb* = 0x00008B4C
  GlMaxCombinedTextureImageUnitsArb* = 0x00008B4D
  GlObjectActiveAttributesArb* = 0x00008B89
  GlObjectActiveAttributeMaxLengthArb* = 0x00008B8A # GL_ARB_fragment_shader
  GlFragmentShaderArb* = 0x00008B30
  GlMaxFragmentUniformComponentsArb* = 0x00008B49 # 1.4
  GlFragmentShaderDerivativeHintArb* = 0x00008B8B # 1.4
                                                       # GL_ARB_occlusion_query
  GlSamplesPassedArb* = 0x00008914
  GlQueryCounterBitsArb* = 0x00008864
  GlCurrentQueryArb* = 0x00008865
  GlQueryResultArb* = 0x00008866
  GlQueryResultAvailableArb* = 0x00008867 # GL_ARB_point_sprite
  GlPointSpriteArb* = 0x00008861
  GlCoordReplaceArb* = 0x00008862 # GL_ARB_shading_language_100
  GlShadingLanguageVersionArb* = 0x00008B8C # 1.4
                                                # GL_ARB_shader_objects
  GlProgramObjectArb* = 0x00008B40
  GLOBJECTtypARB* = 0x00008B4E
  GLOBJECTSUBtypARB* = 0x00008B4F
  GlObjectDeleteStatusArb* = 0x00008B80
  GlObjectCompileStatusArb* = 0x00008B81
  GlObjectLinkStatusArb* = 0x00008B82
  GlObjectValidateStatusArb* = 0x00008B83
  GlObjectInfoLogLengthArb* = 0x00008B84
  GlObjectAttachedObjectsArb* = 0x00008B85
  GlObjectActiveUniformsArb* = 0x00008B86
  GlObjectActiveUniformMaxLengthArb* = 0x00008B87
  GlObjectShaderSourceLengthArb* = 0x00008B88
  GlShaderObjectArb* = 0x00008B48
  GlFloatVec2Arb* = 0x00008B50
  GlFloatVec3Arb* = 0x00008B51
  GlFloatVec4Arb* = 0x00008B52
  GlIntVec2Arb* = 0x00008B53
  GlIntVec3Arb* = 0x00008B54
  GlIntVec4Arb* = 0x00008B55
  GlBoolArb* = 0x00008B56
  GlBoolVec2Arb* = 0x00008B57
  GlBoolVec3Arb* = 0x00008B58
  GlBoolVec4Arb* = 0x00008B59
  GlFloatMat2Arb* = 0x00008B5A
  GlFloatMat3Arb* = 0x00008B5B
  GlFloatMat4Arb* = 0x00008B5C
  GlSampler1dArb* = 0x00008B5D
  GlSampler2dArb* = 0x00008B5E
  GlSampler3dArb* = 0x00008B5F
  GlSamplerCubeArb* = 0x00008B60
  GlSampler1dShadowArb* = 0x00008B61
  GlSampler2dShadowArb* = 0x00008B62
  GlSampler2dRectArb* = 0x00008B63
  GlSampler2dRectShadowArb* = 0x00008B64 # WGL_3DFX_multisample
  WglSampleBuffers3dfx* = 0x00002060
  WglSamples3dfx* = 0x00002061 # WGL_ARB_buffer_region
  WglFrontColorBufferBitArb* = 0x00000001
  WglBackColorBufferBitArb* = 0x00000002
  WglDepthBufferBitArb* = 0x00000004
  WglStencilBufferBitArb* = 0x00000008 # WGL_ARB_make_current_read
  ERRORINVALIDPIXELtypARB* = 0x00002043
  ErrorIncompatibleDeviceContextsArb* = 0x00002054 # WGL_ARB_multisample
  WglSampleBuffersArb* = 0x00002041
  WglSamplesArb* = 0x00002042 # WGL_ARB_pbuffer
  WglDrawToPbufferArb* = 0x0000202D
  WglMaxPbufferPixelsArb* = 0x0000202E
  WglMaxPbufferWidthArb* = 0x0000202F
  WglMaxPbufferHeightArb* = 0x00002030
  WglPbufferLargestArb* = 0x00002033
  WglPbufferWidthArb* = 0x00002034
  WglPbufferHeightArb* = 0x00002035
  WglPbufferLostArb* = 0x00002036 # WGL_ARB_pixel_format
  WglNumberPixelFormatsArb* = 0x00002000
  WglDrawToWindowArb* = 0x00002001
  WglDrawToBitmapArb* = 0x00002002
  WglAccelerationArb* = 0x00002003
  WglNeedPaletteArb* = 0x00002004
  WglNeedSystemPaletteArb* = 0x00002005
  WglSwapLayerBuffersArb* = 0x00002006
  WglSwapMethodArb* = 0x00002007
  WglNumberOverlaysArb* = 0x00002008
  WglNumberUnderlaysArb* = 0x00002009
  WglTransparentArb* = 0x0000200A
  WglTransparentRedValueArb* = 0x00002037
  WglTransparentGreenValueArb* = 0x00002038
  WglTransparentBlueValueArb* = 0x00002039
  WglTransparentAlphaValueArb* = 0x0000203A
  WglTransparentIndexValueArb* = 0x0000203B
  WglShareDepthArb* = 0x0000200C
  WglShareStencilArb* = 0x0000200D
  WglShareAccumArb* = 0x0000200E
  WglSupportGdiArb* = 0x0000200F
  WglSupportOpenglArb* = 0x00002010
  WglDoubleBufferArb* = 0x00002011
  WglStereoArb* = 0x00002012
  WGLPIXELtypARB* = 0x00002013
  WglColorBitsArb* = 0x00002014
  WglRedBitsArb* = 0x00002015
  WglRedShiftArb* = 0x00002016
  WglGreenBitsArb* = 0x00002017
  WglGreenShiftArb* = 0x00002018
  WglBlueBitsArb* = 0x00002019
  WglBlueShiftArb* = 0x0000201A
  WglAlphaBitsArb* = 0x0000201B
  WglAlphaShiftArb* = 0x0000201C
  WglAccumBitsArb* = 0x0000201D
  WglAccumRedBitsArb* = 0x0000201E
  WglAccumGreenBitsArb* = 0x0000201F
  WglAccumBlueBitsArb* = 0x00002020
  WglAccumAlphaBitsArb* = 0x00002021
  WglDepthBitsArb* = 0x00002022
  WglStencilBitsArb* = 0x00002023
  WglAuxBuffersArb* = 0x00002024
  WglNoAccelerationArb* = 0x00002025
  WglGenericAccelerationArb* = 0x00002026
  WglFullAccelerationArb* = 0x00002027
  WglSwapExchangeArb* = 0x00002028
  WglSwapCopyArb* = 0x00002029
  WglSwapUndefinedArb* = 0x0000202A
  WGLtypRGBAARB* = 0x0000202B
  WGLtypCOLORINDEXARB* = 0x0000202C # WGL_ARB_pixel_format_float
  WglRgbaFloatModeArb* = 0x00008820
  WglClampVertexColorArb* = 0x0000891A
  WglClampFragmentColorArb* = 0x0000891B
  WglClampReadColorArb* = 0x0000891C
  WglFixedOnlyArb* = 0x0000891D # WGL_ARB_render_texture
  WglBindToTextureRgbArb* = 0x00002070
  WglBindToTextureRgbaArb* = 0x00002071
  WglTextureFormatArb* = 0x00002072
  WglTextureTargetArb* = 0x00002073
  WglMipmapTextureArb* = 0x00002074
  WglTextureRgbArb* = 0x00002075
  WglTextureRgbaArb* = 0x00002076
  WglNoTextureArb* = 0x00002077
  WglTextureCubeMapArb* = 0x00002078
  WglTexture1dArb* = 0x00002079
  WglTexture2dArb* = 0x0000207A
  WglMipmapLevelArb* = 0x0000207B
  WglCubeMapFaceArb* = 0x0000207C
  WglTextureCubeMapPositiveXArb* = 0x0000207D
  WglTextureCubeMapNegativeXArb* = 0x0000207E
  WglTextureCubeMapPositiveYArb* = 0x0000207F
  WglTextureCubeMapNegativeYArb* = 0x00002080
  WglTextureCubeMapPositiveZArb* = 0x00002081
  WglTextureCubeMapNegativeZArb* = 0x00002082
  WglFrontLeftArb* = 0x00002083
  WglFrontRightArb* = 0x00002084
  WglBackLeftArb* = 0x00002085
  WglBackRightArb* = 0x00002086
  WglAux0Arb* = 0x00002087
  WglAux1Arb* = 0x00002088
  WglAux2Arb* = 0x00002089
  WglAux3Arb* = 0x0000208A
  WglAux4Arb* = 0x0000208B
  WglAux5Arb* = 0x0000208C
  WglAux6Arb* = 0x0000208D
  WglAux7Arb* = 0x0000208E
  WglAux8Arb* = 0x0000208F
  WglAux9Arb* = 0x00002090  # WGL_ARB_create_context
  WglContextDebugBitArb* = 0x00000001
  WglContextForwardCompatibleBitArb* = 0x00000002
  WglContextMajorVersionArb* = 0x00002091
  WglContextMinorVersionArb* = 0x00002092
  WglContextLayerPlaneArb* = 0x00002093
  WglContextFlagsArb* = 0x00002094
  ErrorInvalidVersionArb* = 0x00002095 # WGL_ARB_create_context_profile
  WglContextProfileMaskArb* = 0x00009126
  WglContextCoreProfileBitArb* = 0x00000001
  WglContextCompatibilityProfileBitArb* = 0x00000002
  ErrorInvalidProfileArb* = 0x00002096 # WGL_ARB_framebuffer_sRGB
  WglFramebufferSrgbCapableArb* = 0x000020A9 # 
                                                 # WGL_ARB_create_context_robustness
  WglContextRobustAccessBitArb* = 0x00000004
  WglLoseContextOnResetArb* = 0x00008252
  WglContextResetNotificationStrategyArb* = 0x00008256
  WglNoResetNotificationArb* = 0x00008261 # WGL_ATI_pixel_format_float
  WGLtypRGBAFLOATATI* = 0x000021A0
  GLtypRGBAFLOATATI* = 0x00008820
  GlColorClearUnclampedValueAti* = 0x00008835 # WGL_AMD_gpu_association
  WglGpuVendorAmd* = 0x00001F00
  WglGpuRendererStringAmd* = 0x00001F01
  WglGpuOpenglVersionStringAmd* = 0x00001F02
  WglGpuFastestTargetGpusAmd* = 0x000021A2
  WglGpuRamAmd* = 0x000021A3
  WglGpuClockAmd* = 0x000021A4
  WglGpuNumPipesAmd* = 0x000021A5
  WglGpuNumSimdAmd* = 0x000021A6
  WglGpuNumRbAmd* = 0x000021A7
  WglGpuNumSpiAmd* = 0x000021A8 # WGL_EXT_depth_float
  WglDepthFloatExt* = 0x00002040 # WGL_EXT_make_current_read
  ERRORINVALIDPIXELtypEXT* = 0x00002043 # WGL_EXT_multisample
  WglSampleBuffersExt* = 0x00002041
  WglSamplesExt* = 0x00002042 # WGL_EXT_pbuffer
  WglDrawToPbufferExt* = 0x0000202D
  WglMaxPbufferPixelsExt* = 0x0000202E
  WglMaxPbufferWidthExt* = 0x0000202F
  WglMaxPbufferHeightExt* = 0x00002030
  WglOptimalPbufferWidthExt* = 0x00002031
  WglOptimalPbufferHeightExt* = 0x00002032
  WglPbufferLargestExt* = 0x00002033
  WglPbufferWidthExt* = 0x00002034
  WglPbufferHeightExt* = 0x00002035 # WGL_EXT_pixel_format
  WglNumberPixelFormatsExt* = 0x00002000
  WglDrawToWindowExt* = 0x00002001
  WglDrawToBitmapExt* = 0x00002002
  WglAccelerationExt* = 0x00002003
  WglNeedPaletteExt* = 0x00002004
  WglNeedSystemPaletteExt* = 0x00002005
  WglSwapLayerBuffersExt* = 0x00002006
  WglSwapMethodExt* = 0x00002007
  WglNumberOverlaysExt* = 0x00002008
  WglNumberUnderlaysExt* = 0x00002009
  WglTransparentExt* = 0x0000200A
  WglTransparentValueExt* = 0x0000200B
  WglShareDepthExt* = 0x0000200C
  WglShareStencilExt* = 0x0000200D
  WglShareAccumExt* = 0x0000200E
  WglSupportGdiExt* = 0x0000200F
  WglSupportOpenglExt* = 0x00002010
  WglDoubleBufferExt* = 0x00002011
  WglStereoExt* = 0x00002012
  WGLPIXELtypEXT* = 0x00002013
  WglColorBitsExt* = 0x00002014
  WglRedBitsExt* = 0x00002015
  WglRedShiftExt* = 0x00002016
  WglGreenBitsExt* = 0x00002017
  WglGreenShiftExt* = 0x00002018
  WglBlueBitsExt* = 0x00002019
  WglBlueShiftExt* = 0x0000201A
  WglAlphaBitsExt* = 0x0000201B
  WglAlphaShiftExt* = 0x0000201C
  WglAccumBitsExt* = 0x0000201D
  WglAccumRedBitsExt* = 0x0000201E
  WglAccumGreenBitsExt* = 0x0000201F
  WglAccumBlueBitsExt* = 0x00002020
  WglAccumAlphaBitsExt* = 0x00002021
  WglDepthBitsExt* = 0x00002022
  WglStencilBitsExt* = 0x00002023
  WglAuxBuffersExt* = 0x00002024
  WglNoAccelerationExt* = 0x00002025
  WglGenericAccelerationExt* = 0x00002026
  WglFullAccelerationExt* = 0x00002027
  WglSwapExchangeExt* = 0x00002028
  WglSwapCopyExt* = 0x00002029
  WglSwapUndefinedExt* = 0x0000202A
  WGLtypRGBAEXT* = 0x0000202B
  WGLtypCOLORINDEXEXT* = 0x0000202C # WGL_I3D_digital_video_control
  WglDigitalVideoCursorAlphaFramebufferI3d* = 0x00002050
  WglDigitalVideoCursorAlphaValueI3d* = 0x00002051
  WglDigitalVideoCursorIncludedI3d* = 0x00002052
  WglDigitalVideoGammaCorrectedI3d* = 0x00002053 # WGL_I3D_gamma
  WglGammaTableSizeI3d* = 0x0000204E
  WglGammaExcludeDesktopI3d* = 0x0000204F # WGL_I3D_genlock
  WglGenlockSourceMultiviewI3d* = 0x00002044
  WglGenlockSourceExtenalSyncI3d* = 0x00002045
  WglGenlockSourceExtenalFieldI3d* = 0x00002046
  WglGenlockSourceExtenalTtlI3d* = 0x00002047
  WglGenlockSourceDigitalSyncI3d* = 0x00002048
  WglGenlockSourceDigitalFieldI3d* = 0x00002049
  WglGenlockSourceEdgeFallingI3d* = 0x0000204A
  WglGenlockSourceEdgeRisingI3d* = 0x0000204B
  WglGenlockSourceEdgeBothI3d* = 0x0000204C # WGL_I3D_image_buffer
  WglImageBufferMinAccessI3d* = 0x00000001
  WglImageBufferLockI3d* = 0x00000002 # WGL_NV_float_buffer
  WglFloatComponentsNv* = 0x000020B0
  WglBindToTextureRectangleFloatRNv* = 0x000020B1
  WglBindToTextureRectangleFloatRgNv* = 0x000020B2
  WglBindToTextureRectangleFloatRgbNv* = 0x000020B3
  WglBindToTextureRectangleFloatRgbaNv* = 0x000020B4
  WglTextureFloatRNv* = 0x000020B5
  WglTextureFloatRgNv* = 0x000020B6
  WglTextureFloatRgbNv* = 0x000020B7
  WglTextureFloatRgbaNv* = 0x000020B8 # WGL_NV_render_depth_texture
  WglBindToTextureDepthNv* = 0x000020A3
  WglBindToTextureRectangleDepthNv* = 0x000020A4
  WglDepthTextureFormatNv* = 0x000020A5
  WglTextureDepthComponentNv* = 0x000020A6
  WglDepthComponentNv* = 0x000020A7 # WGL_NV_render_texture_rectangle
  WglBindToTextureRectangleRgbNv* = 0x000020A0
  WglBindToTextureRectangleRgbaNv* = 0x000020A1
  WglTextureRectangleNv* = 0x000020A2 # WGL_NV_present_video
  WglNumVideoSlotsNv* = 0x000020F0 # WGL_NV_video_output
  WglBindToVideoRgbNv* = 0x000020C0
  WglBindToVideoRgbaNv* = 0x000020C1
  WglBindToVideoRgbAndDepthNv* = 0x000020C2
  WglVideoOutColorNv* = 0x000020C3
  WglVideoOutAlphaNv* = 0x000020C4
  WglVideoOutDepthNv* = 0x000020C5
  WglVideoOutColorAndAlphaNv* = 0x000020C6
  WglVideoOutColorAndDepthNv* = 0x000020C7
  WglVideoOutFrame* = 0x000020C8
  WglVideoOutField1* = 0x000020C9
  WglVideoOutField2* = 0x000020CA
  WglVideoOutStackedFields12* = 0x000020CB
  WglVideoOutStackedFields21* = 0x000020CC # WGL_NV_gpu_affinity
  WglErrorIncompatibleAffinityMasksNv* = 0x000020D0
  WglErrorMissingAffinityMaskNv* = 0x000020D1 # WGL_NV_video_capture
  WglUniqueIdNv* = 0x000020CE
  WglNumVideoCaptureSlotsNv* = 0x000020CF # WGL_NV_multisample_coverage
  WglCoverageSamplesNv* = 0x00002042
  WglColorSamplesNv* = 0x000020B9 # WGL_EXT_create_context_es2_profile
  WglContextEs2ProfileBitExt* = 0x00000004 # WGL_NV_DX_interop
  WglAccessReadOnlyNv* = 0x00000000
  WglAccessReadWriteNv* = 0x00000001
  WglAccessWriteDiscardNv* = 0x00000002 # WIN_draw_range_elements
  GlMaxElementsVerticesWin* = 0x000080E8
  GlMaxElementsIndicesWin* = 0x000080E9 # GLX 1.1 and later:
  GlxVendor* = 1
  GlxVersion* = 2
  GlxExtensions* = 3
  GlxUseGl* = 1
  GlxBufferSize* = 2
  GlxLevel* = 3
  GlxRgba* = 4
  GlxDoublebuffer* = 5
  GlxStereo* = 6
  GlxAuxBuffers* = 7
  GlxRedSize* = 8
  GlxGreenSize* = 9
  GlxBlueSize* = 10
  GlxAlphaSize* = 11
  GlxDepthSize* = 12
  GlxStencilSize* = 13
  GlxAccumRedSize* = 14
  GlxAccumGreenSize* = 15
  GlxAccumBlueSize* = 16
  GlxAccumAlphaSize* = 17  # GLX_VERSION_1_3
  GlxWindowBit* = 0x00000001
  GlxPixmapBit* = 0x00000002
  GlxPbufferBit* = 0x00000004
  GlxRgbaBit* = 0x00000001
  GlxColorIndexBit* = 0x00000002
  GlxPbufferClobberMask* = 0x08000000
  GlxFrontLeftBufferBit* = 0x00000001
  GlxFrontRightBufferBit* = 0x00000002
  GlxBackLeftBufferBit* = 0x00000004
  GlxBackRightBufferBit* = 0x00000008
  GlxAuxBuffersBit* = 0x00000010
  GlxDepthBufferBit* = 0x00000020
  GlxStencilBufferBit* = 0x00000040
  GlxAccumBufferBit* = 0x00000080
  GlxConfigCaveat* = 0x00000020
  GLXXVISUALtyp* = 0x00000022
  GLXTRANSPARENTtyp* = 0x00000023
  GlxTransparentIndexValue* = 0x00000024
  GlxTransparentRedValue* = 0x00000025
  GlxTransparentGreenValue* = 0x00000026
  GlxTransparentBlueValue* = 0x00000027
  GlxTransparentAlphaValue* = 0x00000028
  GlxDontCare* = 0xFFFFFFFF
  GlxNone* = 0x00008000
  GlxSlowConfig* = 0x00008001
  GlxTrueColor* = 0x00008002
  GlxDirectColor* = 0x00008003
  GlxPseudoColor* = 0x00008004
  GlxStaticColor* = 0x00008005
  GlxGrayScale* = 0x00008006
  GlxStaticGray* = 0x00008007
  GlxTransparentRgb* = 0x00008008
  GlxTransparentIndex* = 0x00008009
  GlxVisualId* = 0x0000800B
  GlxScreen* = 0x0000800C
  GlxNonConformantConfig* = 0x0000800D
  GLXDRAWABLEtyp* = 0x00008010
  GLXRENDERtyp* = 0x00008011
  GlxXRenderable* = 0x00008012
  GlxFbconfigId* = 0x00008013
  GLXRGBAtyp* = 0x00008014
  GLXCOLORINDEXtyp* = 0x00008015
  GlxMaxPbufferWidth* = 0x00008016
  GlxMaxPbufferHeight* = 0x00008017
  GlxMaxPbufferPixels* = 0x00008018
  GlxPreservedContents* = 0x0000801B
  GlxLargestPbuffer* = 0x0000801C
  GlxWidth* = 0x0000801D
  GlxHeight* = 0x0000801E
  GlxEventMask* = 0x0000801F
  GlxDamaged* = 0x00008020
  GlxSaved* = 0x00008021
  cGLXWINDOW* = 0x00008022
  cGLXPBUFFER* = 0x00008023
  GlxPbufferHeight* = 0x00008040
  GlxPbufferWidth* = 0x00008041 # GLX_VERSION_1_4
  GlxSampleBuffers* = 100000
  GlxSamples* = 100001       # GLX_ARB_multisample
  GlxSampleBuffersArb* = 100000
  GlxSamplesArb* = 100001   # GLX_ARB_fbconfig_float
  GLXRGBAFLOATtypARB* = 0x000020B9
  GlxRgbaFloatBitArb* = 0x00000004 # GLX_ARB_create_context
  GlxContextDebugBitArb* = 0x00000001
  GlxContextForwardCompatibleBitArb* = 0x00000002
  GlxContextMajorVersionArb* = 0x00002091
  GlxContextMinorVersionArb* = 0x00002092
  GlxContextFlagsArb* = 0x00002094 # GLX_ARB_create_context_profile
  GlxContextCoreProfileBitArb* = 0x00000001
  GlxContextCompatibilityProfileBitArb* = 0x00000002
  GlxContextProfileMaskArb* = 0x00009126 # GLX_ARB_vertex_buffer_object
  GlxContextAllowBufferByteOrderMismatchArb* = 0x00002095 # 
                                                                 # GLX_ARB_framebuffer_sRGB
  GlxFramebufferSrgbCapableArb* = 0x000020B2 # 
                                                 # GLX_ARB_create_context_robustness
  GlxContextRobustAccessBitArb* = 0x00000004
  GlxLoseContextOnResetArb* = 0x00008252
  GlxContextResetNotificationStrategyArb* = 0x00008256
  GlxNoResetNotificationArb* = 0x00008261 # GLX_EXT_visual_info
  GLXXVISUALtypEXT* = 0x00000022
  GLXTRANSPARENTtypEXT* = 0x00000023
  GlxTransparentIndexValueExt* = 0x00000024
  GlxTransparentRedValueExt* = 0x00000025
  GlxTransparentGreenValueExt* = 0x00000026
  GlxTransparentBlueValueExt* = 0x00000027
  GlxTransparentAlphaValueExt* = 0x00000028
  GlxNoneExt* = 0x00008000
  GlxTrueColorExt* = 0x00008002
  GlxDirectColorExt* = 0x00008003
  GlxPseudoColorExt* = 0x00008004
  GlxStaticColorExt* = 0x00008005
  GlxGrayScaleExt* = 0x00008006
  GlxStaticGrayExt* = 0x00008007
  GlxTransparentRgbExt* = 0x00008008
  GlxTransparentIndexExt* = 0x00008009 # GLX_EXT_visual_rating
  GlxVisualCaveatExt* = 0x00000020
  GlxSlowVisualExt* = 0x00008001
  GlxNonConformantVisualExt* = 0x0000800D # reuse GLX_NONE_EXT 
                                              # GLX_EXT_import_context
  GlxShareContextExt* = 0x0000800A
  GlxVisualIdExt* = 0x0000800B
  GlxScreenExt* = 0x0000800C # GLX_EXT_fbconfig_packed_float
                               #  GLX_RGBA_UNSIGNED_FLOATtyp_EXT = $20B1;
                               #  GLX_RGBA_UNSIGNED_FLOAT_BIT_EXT = $00000008;
                               # GLX_EXT_framebuffer_sRGB
                               #  GLX_FRAMEBUFFER_SRGB_CAPABLE_EXT = $20B2;
                               # GLX_EXT_texture_from_pixmap
  GlxTexture1dBitExt* = 0x00000001
  GlxTexture2dBitExt* = 0x00000002
  GlxTextureRectangleBitExt* = 0x00000004
  GlxBindToTextureRgbExt* = 0x000020D0
  GlxBindToTextureRgbaExt* = 0x000020D1
  GlxBindToMipmapTextureExt* = 0x000020D2
  GlxBindToTextureTargetsExt* = 0x000020D3
  GlxYInvertedExt* = 0x000020D4
  GlxTextureFormatExt* = 0x000020D5
  GlxTextureTargetExt* = 0x000020D6
  GlxMipmapTextureExt* = 0x000020D7
  GlxTextureFormatNoneExt* = 0x000020D8
  GlxTextureFormatRgbExt* = 0x000020D9
  GlxTextureFormatRgbaExt* = 0x000020DA
  GlxTexture1dExt* = 0x000020DB
  GlxTexture2dExt* = 0x000020DC
  GlxTextureRectangleExt* = 0x000020DD
  GlxFrontLeftExt* = 0x000020DE
  GlxFrontRightExt* = 0x000020DF
  GlxBackLeftExt* = 0x000020E0
  GlxBackRightExt* = 0x000020E1
  GlxFrontExt* = GLX_FRONT_LEFT_EXT
  GlxBackExt* = GLX_BACK_LEFT_EXT
  GlxAux0Ext* = 0x000020E2
  GlxAux1Ext* = 0x000020E3
  GlxAux2Ext* = 0x000020E4
  GlxAux3Ext* = 0x000020E5
  GlxAux4Ext* = 0x000020E6
  GlxAux5Ext* = 0x000020E7
  GlxAux6Ext* = 0x000020E8
  GlxAux7Ext* = 0x000020E9
  GlxAux8Ext* = 0x000020EA
  GlxAux9Ext* = 0x000020EB  # GLX_EXT_swap_control
  GlxSwapIntervalExt* = 0x000020F1
  GlxMaxSwapIntervalExt* = 0x000020F2 # GLX_EXT_create_context_es2_profile
  GlxContextEs2ProfileBitExt* = 0x00000004 # GLU
  GluInvalidEnum* = 100900
  GluInvalidValue* = 100901
  GluOutOfMemory* = 100902
  GluIncompatibleGlVersion* = 100903
  GluVersion* = 100800
  GluExtensions* = 100801
  GluTrue* = GL_TRUE
  GluFalse* = GL_FALSE
  GluSmooth* = 100000
  GluFlat* = 100001
  GluNone* = 100002
  GluPoint* = 100010
  GluLine* = 100011
  GluFill* = 100012
  GluSilhouette* = 100013
  GluOutside* = 100020
  GluInside* = 100021
  GluTessMaxCoord* = 1.0000000000000005e+150
  GluTessWindingRule* = 100140
  GluTessBoundaryOnly* = 100141
  GluTessTolerance* = 100142
  GluTessWindingOdd* = 100130
  GluTessWindingNonzero* = 100131
  GluTessWindingPositive* = 100132
  GluTessWindingNegative* = 100133
  GluTessWindingAbsGeqTwo* = 100134
  GluTessBegin* = 100100    # TGLUTessBeginProc
  cGLUTESSVERTEX* = 100101   # TGLUTessVertexProc
  GluTessEnd* = 100102      # TGLUTessEndProc
  GluTessError* = 100103    # TGLUTessErrorProc
  GluTessEdgeFlag* = 100104 # TGLUTessEdgeFlagProc
  GluTessCombine* = 100105  # TGLUTessCombineProc
  GluTessBeginData* = 100106 # TGLUTessBeginDataProc
  GluTessVertexData* = 100107 # TGLUTessVertexDataProc
  GluTessEndData* = 100108 # TGLUTessEndDataProc
  GluTessErrorData* = 100109 # TGLUTessErrorDataProc
  GluTessEdgeFlagData* = 100110 # TGLUTessEdgeFlagDataProc
  GluTessCombineData* = 100111 # TGLUTessCombineDataProc
  GluTessError1* = 100151
  GluTessError2* = 100152
  GluTessError3* = 100153
  GluTessError4* = 100154
  GluTessError5* = 100155
  GluTessError6* = 100156
  GluTessError7* = 100157
  GluTessError8* = 100158
  GluTessMissingBeginPolygon* = GLU_TESS_ERROR1
  GluTessMissingBeginContour* = GLU_TESS_ERROR2
  GluTessMissingEndPolygon* = GLU_TESS_ERROR3
  GluTessMissingEndContour* = GLU_TESS_ERROR4
  GluTessCoordTooLarge* = GLU_TESS_ERROR5
  GluTessNeedCombineCallback* = GLU_TESS_ERROR6
  GluAutoLoadMatrix* = 100200
  GluCulling* = 100201
  GluSamplingTolerance* = 100203
  GluDisplayMode* = 100204
  GluParametricTolerance* = 100202
  GluSamplingMethod* = 100205
  GluUStep* = 100206
  GluVStep* = 100207
  GluPathLength* = 100215
  GluParametricError* = 100216
  GluDomainDistance* = 100217
  GluMap1Trim2* = 100210
  GluMap1Trim3* = 100211
  GluOutlinePolygon* = 100240
  GluOutlinePatch* = 100241
  GluNurbsError1* = 100251
  GluNurbsError2* = 100252
  GluNurbsError3* = 100253
  GluNurbsError4* = 100254
  GluNurbsError5* = 100255
  GluNurbsError6* = 100256
  GluNurbsError7* = 100257
  GluNurbsError8* = 100258
  GluNurbsError9* = 100259
  GluNurbsError10* = 100260
  GluNurbsError11* = 100261
  GluNurbsError12* = 100262
  GluNurbsError13* = 100263
  GluNurbsError14* = 100264
  GluNurbsError15* = 100265
  GluNurbsError16* = 100266
  GluNurbsError17* = 100267
  GluNurbsError18* = 100268
  GluNurbsError19* = 100269
  GluNurbsError20* = 100270
  GluNurbsError21* = 100271
  GluNurbsError22* = 100272
  GluNurbsError23* = 100273
  GluNurbsError24* = 100274
  GluNurbsError25* = 100275
  GluNurbsError26* = 100276
  GluNurbsError27* = 100277
  GluNurbsError28* = 100278
  GluNurbsError29* = 100279
  GluNurbsError30* = 100280
  GluNurbsError31* = 100281
  GluNurbsError32* = 100282
  GluNurbsError33* = 100283
  GluNurbsError34* = 100284
  GluNurbsError35* = 100285
  GluNurbsError36* = 100286
  GluNurbsError37* = 100287
  GluCw* = 100120
  GluCcw* = 100121
  GluInterior* = 100122
  GluExterior* = 100123
  GluUnknown* = 100124
  GluBegin* = GLU_TESS_BEGIN
  GluVertex* = cGLU_TESS_VERTEX
  GluEnd* = GLU_TESS_END
  GluError* = GLU_TESS_ERROR
  GluEdgeFlag* = GLU_TESS_EDGE_FLAG

proc glCullFace*(mode: GLenum){.stdcall, importc, ogl.}
proc glFrontFace*(mode: GLenum){.stdcall, importc, ogl.}
proc glHint*(target: GLenum, mode: GLenum){.stdcall, importc, ogl.}
proc glLineWidth*(width: GLfloat){.stdcall, importc, ogl.}
proc glPointSize*(size: GLfloat){.stdcall, importc, ogl.}
proc glPolygonMode*(face: GLenum, mode: GLenum){.stdcall, importc, ogl.}
proc glScissor*(x: GLint, y: GLint, width: GLsizei, height: GLsizei){.stdcall, importc, ogl.}
proc glTexParameterf*(target: GLenum, pname: GLenum, param: GLfloat){.stdcall, importc, ogl.}
proc glTexParameterfv*(target: GLenum, pname: GLenum, params: PGLfloat){.stdcall, importc, ogl.}
proc glTexParameteri*(target: GLenum, pname: GLenum, param: GLint){.stdcall, importc, ogl.}
proc glTexParameteriv*(target: GLenum, pname: GLenum, params: PGLint){.stdcall, importc, ogl.}
proc glTexImage1D*(target: GLenum, level: GLint, internalformat: GLint, 
                   width: GLsizei, border: GLint, format: GLenum, typ: GLenum, 
                   pixels: PGLvoid){.stdcall, importc, ogl.}
proc glTexImage2D*(target: GLenum, level: GLint, internalformat: GLint, 
                   width: GLsizei, height: GLsizei, border: GLint, 
                   format: GLenum, typ: GLenum, pixels: PGLvoid){.stdcall, importc, ogl.}
proc glDrawBuffer*(mode: GLenum){.stdcall, importc, ogl.}
proc glClear*(mask: GLbitfield){.stdcall, importc, ogl.}
proc glClearColor*(red: GLclampf, green: GLclampf, blue: GLclampf, 
                   alpha: GLclampf){.stdcall, importc, ogl.}
proc glClearStencil*(s: GLint){.stdcall, importc, ogl.}
proc glClearDepth*(depth: GLclampd){.stdcall, importc, ogl.}
proc glStencilMask*(mask: GLuint){.stdcall, importc, ogl.}
proc glColorMask*(red: GLboolean, green: GLboolean, blue: GLboolean, 
                  alpha: GLboolean){.stdcall, importc, ogl.}
proc glDepthMask*(flag: GLboolean){.stdcall, importc, ogl.}
proc glDisable*(cap: GLenum){.stdcall, importc, ogl.}
proc glEnable*(cap: GLenum){.stdcall, importc, ogl.}
proc glFinish*(){.stdcall, importc, ogl.}
proc glFlush*(){.stdcall, importc, ogl.}
proc glBlendFunc*(sfactor: GLenum, dfactor: GLenum){.stdcall, importc, ogl.}
proc glLogicOp*(opcode: GLenum){.stdcall, importc, ogl.}
proc glStencilFunc*(func: GLenum, theRef: GLint, mask: GLuint){.stdcall, importc, ogl.}
proc glStencilOp*(fail: GLenum, zfail: GLenum, zpass: GLenum){.stdcall, importc, ogl.}
proc glDepthFunc*(func: GLenum){.stdcall, importc, ogl.}
proc glPixelStoref*(pname: GLenum, param: GLfloat){.stdcall, importc, ogl.}
proc glPixelStorei*(pname: GLenum, param: GLint){.stdcall, importc, ogl.}
proc glReadBuffer*(mode: GLenum){.stdcall, importc, ogl.}
proc glReadPixels*(x: GLint, y: GLint, width: GLsizei, height: GLsizei, 
                   format: GLenum, typ: GLenum, pixels: PGLvoid){.stdcall, importc, ogl.}
proc glGetBooleanv*(pname: GLenum, params: PGLboolean){.stdcall, importc, ogl.}
proc glGetDoublev*(pname: GLenum, params: PGLdouble){.stdcall, importc, ogl.}
proc glGetError*(): GLenum{.stdcall, importc, ogl.}
proc glGetFloatv*(pname: GLenum, params: PGLfloat){.stdcall, importc, ogl.}
proc glGetIntegerv*(pname: GLenum, params: PGLint){.stdcall, importc, ogl.}
proc glGetString*(name: GLenum): Cstring{.stdcall, importc, ogl.}
proc glGetTexImage*(target: GLenum, level: GLint, format: GLenum, typ: GLenum, 
                    pixels: PGLvoid){.stdcall, importc, ogl.}
proc glGetTexParameteriv*(target: GLenum, pname: GLenum, params: PGLint){.
    stdcall, importc, ogl.}
proc glGetTexParameterfv*(target: GLenum, pname: GLenum, params: PGLfloat){.
    stdcall, importc, ogl.}
proc glGetTexLevelParameterfv*(target: GLenum, level: GLint, pname: GLenum, 
                               params: PGLfloat){.stdcall, importc, ogl.}
proc glGetTexLevelParameteriv*(target: GLenum, level: GLint, pname: GLenum, 
                               params: PGLint){.stdcall, importc, ogl.}
proc glIsEnabled*(cap: GLenum): GLboolean{.stdcall, importc, ogl.}
proc glDepthRange*(zNear: GLclampd, zFar: GLclampd){.stdcall, importc, ogl.}
proc glViewport*(x: GLint, y: GLint, width: GLsizei, height: GLsizei){.stdcall, importc, ogl.}
  # GL_VERSION_1_1
proc glDrawArrays*(mode: GLenum, first: GLint, count: GLsizei){.stdcall, importc, ogl.}
proc glDrawElements*(mode: GLenum, count: GLsizei, typ: GLenum, indices: PGLvoid){.
    stdcall, importc, ogl.}
proc glGetPointerv*(pname: GLenum, params: PGLvoid){.stdcall, importc, ogl.}
proc glPolygonOffset*(factor: GLfloat, units: GLfloat){.stdcall, importc, ogl.}
proc glCopyTexImage1D*(target: GLenum, level: GLint, internalFormat: GLenum, 
                       x: GLint, y: GLint, width: GLsizei, border: GLint){.
    stdcall, importc, ogl.}
proc glCopyTexImage2D*(target: GLenum, level: GLint, internalFormat: GLenum, 
                       x: GLint, y: GLint, width: GLsizei, height: GLsizei, 
                       border: GLint){.stdcall, importc, ogl.}
proc glCopyTexSubImage1D*(target: GLenum, level: GLint, xoffset: GLint, 
                          x: GLint, y: GLint, width: GLsizei){.stdcall, importc, ogl.}
proc glCopyTexSubImage2D*(target: GLenum, level: GLint, xoffset: GLint, 
                          yoffset: GLint, x: GLint, y: GLint, width: GLsizei, 
                          height: GLsizei){.stdcall, importc, ogl.}
proc glTexSubImage1D*(target: GLenum, level: GLint, xoffset: GLint, 
                      width: GLsizei, format: GLenum, typ: GLenum, 
                      pixels: PGLvoid){.stdcall, importc, ogl.}
proc glTexSubImage2D*(target: GLenum, level: GLint, xoffset: GLint, 
                      yoffset: GLint, width: GLsizei, height: GLsizei, 
                      format: GLenum, typ: GLenum, pixels: PGLvoid){.stdcall, importc, ogl.}
proc glBindTexture*(target: GLenum, texture: GLuint){.stdcall, importc, ogl.}
proc glDeleteTextures*(n: GLsizei, textures: PGLuint){.stdcall, importc, ogl.}
proc glGenTextures*(n: GLsizei, textures: PGLuint){.stdcall, importc, ogl.}
proc glAccum*(op: GLenum, value: GLfloat){.stdcall, importc, ogl.}
proc glAlphaFunc*(func: GLenum, theRef: GLclampf){.stdcall, importc, ogl.}
proc glAreTexturesResident*(n: GLsizei, textures: PGLuint, 
                            residences: PGLboolean): GLboolean{.stdcall, importc, ogl.}
proc glArrayElement*(i: GLint){.stdcall, importc, ogl.}
proc glBegin*(mode: GLenum){.stdcall, importc, ogl.}
proc glBitmap*(width: GLsizei, height: GLsizei, xorig: GLfloat, yorig: GLfloat, 
               xmove: GLfloat, ymove: GLfloat, bitmap: PGLubyte){.stdcall, importc, ogl.}
proc glCallList*(list: GLuint){.stdcall, importc, ogl.}
proc glCallLists*(n: GLsizei, typ: GLenum, lists: PGLvoid){.stdcall, importc, ogl.}
proc glClearAccum*(red: GLfloat, green: GLfloat, blue: GLfloat, alpha: GLfloat){.
    stdcall, importc, ogl.}
proc glClearIndex*(c: GLfloat){.stdcall, importc, ogl.}
proc glClipPlane*(plane: GLenum, equation: PGLdouble){.stdcall, importc, ogl.}
proc glColor3b*(red: GLbyte, green: GLbyte, blue: GLbyte){.stdcall, importc, ogl.}
proc glColor3bv*(v: PGLbyte){.stdcall, importc, ogl.}
proc glColor3d*(red: GLdouble, green: GLdouble, blue: GLdouble){.stdcall, importc, ogl.}
proc glColor3dv*(v: PGLdouble){.stdcall, importc, ogl.}
proc glColor3f*(red: GLfloat, green: GLfloat, blue: GLfloat){.stdcall, importc, ogl.}
proc glColor3fv*(v: PGLfloat){.stdcall, importc, ogl.}
proc glColor3i*(red: GLint, green: GLint, blue: GLint){.stdcall, importc, ogl.}
proc glColor3iv*(v: PGLint){.stdcall, importc, ogl.}
proc glColor3s*(red: GLshort, green: GLshort, blue: GLshort){.stdcall, importc, ogl.}
proc glColor3sv*(v: PGLshort){.stdcall, importc, ogl.}
proc glColor3ub*(red: GLubyte, green: GLubyte, blue: GLubyte){.stdcall, importc, ogl.}
proc glColor3ubv*(v: PGLubyte){.stdcall, importc, ogl.}
proc glColor3ui*(red: GLuint, green: GLuint, blue: GLuint){.stdcall, importc, ogl.}
proc glColor3uiv*(v: PGLuint){.stdcall, importc, ogl.}
proc glColor3us*(red: GLushort, green: GLushort, blue: GLushort){.stdcall, importc, ogl.}
proc glColor3usv*(v: PGLushort){.stdcall, importc, ogl.}
proc glColor4b*(red: GLbyte, green: GLbyte, blue: GLbyte, alpha: GLbyte){.
    stdcall, importc, ogl.}
proc glColor4bv*(v: PGLbyte){.stdcall, importc, ogl.}
proc glColor4d*(red: GLdouble, green: GLdouble, blue: GLdouble, alpha: GLdouble){.
    stdcall, importc, ogl.}
proc glColor4dv*(v: PGLdouble){.stdcall, importc, ogl.}
proc glColor4f*(red: GLfloat, green: GLfloat, blue: GLfloat, alpha: GLfloat){.
    stdcall, importc, ogl.}
proc glColor4fv*(v: PGLfloat){.stdcall, importc, ogl.}
proc glColor4i*(red: GLint, green: GLint, blue: GLint, alpha: GLint){.stdcall, importc, ogl.}
proc glColor4iv*(v: PGLint){.stdcall, importc, ogl.}
proc glColor4s*(red: GLshort, green: GLshort, blue: GLshort, alpha: GLshort){.
    stdcall, importc, ogl.}
proc glColor4sv*(v: PGLshort){.stdcall, importc, ogl.}
proc glColor4ub*(red: GLubyte, green: GLubyte, blue: GLubyte, alpha: GLubyte){.
    stdcall, importc, ogl.}
proc glColor4ubv*(v: PGLubyte){.stdcall, importc, ogl.}
proc glColor4ui*(red: GLuint, green: GLuint, blue: GLuint, alpha: GLuint){.
    stdcall, importc, ogl.}
proc glColor4uiv*(v: PGLuint){.stdcall, importc, ogl.}
proc glColor4us*(red: GLushort, green: GLushort, blue: GLushort, alpha: GLushort){.
    stdcall, importc, ogl.}
proc glColor4usv*(v: PGLushort){.stdcall, importc, ogl.}
proc glColorMaterial*(face: GLenum, mode: GLenum){.stdcall, importc, ogl.}
proc glColorPointer*(size: GLint, typ: GLenum, stride: GLsizei, pointer: PGLvoid){.
    stdcall, importc, ogl.}
proc glCopyPixels*(x: GLint, y: GLint, width: GLsizei, height: GLsizei, 
                   typ: GLenum){.stdcall, importc, ogl.}
proc glDeleteLists*(list: GLuint, range: GLsizei){.stdcall, importc, ogl.}
proc glDisableClientState*(arr: GLenum){.stdcall, importc, ogl.}
proc glDrawPixels*(width: GLsizei, height: GLsizei, format: GLenum, typ: GLenum, 
                   pixels: PGLvoid){.stdcall, importc, ogl.}
proc glEdgeFlag*(flag: GLboolean){.stdcall, importc, ogl.}
proc glEdgeFlagPointer*(stride: GLsizei, pointer: PGLvoid){.stdcall, importc, ogl.}
proc glEdgeFlagv*(flag: PGLboolean){.stdcall, importc, ogl.}
proc glEnableClientState*(arr: GLenum){.stdcall, importc, ogl.}
proc glEnd*(){.stdcall, importc, ogl.}
proc glEndList*(){.stdcall, importc, ogl.}
proc glEvalCoord1d*(u: GLdouble){.stdcall, importc, ogl.}
proc glEvalCoord1dv*(u: PGLdouble){.stdcall, importc, ogl.}
proc glEvalCoord1f*(u: GLfloat){.stdcall, importc, ogl.}
proc glEvalCoord1fv*(u: PGLfloat){.stdcall, importc, ogl.}
proc glEvalCoord2d*(u: GLdouble, v: GLdouble){.stdcall, importc, ogl.}
proc glEvalCoord2dv*(u: PGLdouble){.stdcall, importc, ogl.}
proc glEvalCoord2f*(u: GLfloat, v: GLfloat){.stdcall, importc, ogl.}
proc glEvalCoord2fv*(u: PGLfloat){.stdcall, importc, ogl.}
proc glEvalMesh1*(mode: GLenum, i1: GLint, i2: GLint){.stdcall, importc, ogl.}
proc glEvalMesh2*(mode: GLenum, i1: GLint, i2: GLint, j1: GLint, j2: GLint){.
    stdcall, importc, ogl.}
proc glEvalPoint1*(i: GLint){.stdcall, importc, ogl.}
proc glEvalPoint2*(i: GLint, j: GLint){.stdcall, importc, ogl.}
proc glFeedbackBuffer*(size: GLsizei, typ: GLenum, buffer: PGLfloat){.stdcall, importc, ogl.}
proc glFogf*(pname: GLenum, param: GLfloat){.stdcall, importc, ogl.}
proc glFogfv*(pname: GLenum, params: PGLfloat){.stdcall, importc, ogl.}
proc glFogi*(pname: GLenum, param: GLint){.stdcall, importc, ogl.}
proc glFogiv*(pname: GLenum, params: PGLint){.stdcall, importc, ogl.}
proc glFrustum*(left: GLdouble, right: GLdouble, bottom: GLdouble, 
                top: GLdouble, zNear: GLdouble, zFar: GLdouble){.stdcall, importc, ogl.}
proc glGenLists*(range: GLsizei): GLuint{.stdcall, importc, ogl.}
proc glGetClipPlane*(plane: GLenum, equation: PGLdouble){.stdcall, importc, ogl.}
proc glGetLightfv*(light: GLenum, pname: GLenum, params: PGLfloat){.stdcall, importc, ogl.}
proc glGetLightiv*(light: GLenum, pname: GLenum, params: PGLint){.stdcall, importc, ogl.}
proc glGetMapdv*(target: GLenum, query: GLenum, v: PGLdouble){.stdcall, importc, ogl.}
proc glGetMapfv*(target: GLenum, query: GLenum, v: PGLfloat){.stdcall, importc, ogl.}
proc glGetMapiv*(target: GLenum, query: GLenum, v: PGLint){.stdcall, importc, ogl.}
proc glGetMaterialfv*(face: GLenum, pname: GLenum, params: PGLfloat){.stdcall, importc, ogl.}
proc glGetMaterialiv*(face: GLenum, pname: GLenum, params: PGLint){.stdcall, importc, ogl.}
proc glGetPixelMapfv*(map: GLenum, values: PGLfloat){.stdcall, importc, ogl.}
proc glGetPixelMapuiv*(map: GLenum, values: PGLuint){.stdcall, importc, ogl.}
proc glGetPixelMapusv*(map: GLenum, values: PGLushort){.stdcall, importc, ogl.}
proc glGetPolygonStipple*(mask: PGLubyte){.stdcall, importc, ogl.}
proc glGetTexEnvfv*(target: GLenum, pname: GLenum, params: PGLfloat){.stdcall, importc, ogl.}
proc glGetTexEnviv*(target: GLenum, pname: GLenum, params: PGLint){.stdcall, importc, ogl.}
proc glGetTexGendv*(coord: GLenum, pname: GLenum, params: PGLdouble){.stdcall, importc, ogl.}
proc glGetTexGenfv*(coord: GLenum, pname: GLenum, params: PGLfloat){.stdcall, importc, ogl.}
proc glGetTexGeniv*(coord: GLenum, pname: GLenum, params: PGLint){.stdcall, importc, ogl.}
proc glIndexMask*(mask: GLuint){.stdcall, importc, ogl.}
proc glIndexPointer*(typ: GLenum, stride: GLsizei, pointer: PGLvoid){.stdcall, importc, ogl.}
proc glIndexd*(c: GLdouble){.stdcall, importc, ogl.}
proc glIndexdv*(c: PGLdouble){.stdcall, importc, ogl.}
proc glIndexf*(c: GLfloat){.stdcall, importc, ogl.}
proc glIndexfv*(c: PGLfloat){.stdcall, importc, ogl.}
proc glIndexi*(c: GLint){.stdcall, importc, ogl.}
proc glIndexiv*(c: PGLint){.stdcall, importc, ogl.}
proc glIndexs*(c: GLshort){.stdcall, importc, ogl.}
proc glIndexsv*(c: PGLshort){.stdcall, importc, ogl.}
proc glIndexub*(c: GLubyte){.stdcall, importc, ogl.}
proc glIndexubv*(c: PGLubyte){.stdcall, importc, ogl.}
proc glInitNames*(){.stdcall, importc, ogl.}
proc glInterleavedArrays*(format: GLenum, stride: GLsizei, pointer: PGLvoid){.
    stdcall, importc, ogl.}
proc glIsList*(list: GLuint): GLboolean{.stdcall, importc, ogl.}
proc glIsTexture*(texture: GLuint): GLboolean{.stdcall, importc, ogl.}
proc glLightModelf*(pname: GLenum, param: GLfloat){.stdcall, importc, ogl.}
proc glLightModelfv*(pname: GLenum, params: PGLfloat){.stdcall, importc, ogl.}
proc glLightModeli*(pname: GLenum, param: GLint){.stdcall, importc, ogl.}
proc glLightModeliv*(pname: GLenum, params: PGLint){.stdcall, importc, ogl.}
proc glLightf*(light: GLenum, pname: GLenum, param: GLfloat){.stdcall, importc, ogl.}
proc glLightfv*(light: GLenum, pname: GLenum, params: PGLfloat){.stdcall, importc, ogl.}
proc glLighti*(light: GLenum, pname: GLenum, param: GLint){.stdcall, importc, ogl.}
proc glLightiv*(light: GLenum, pname: GLenum, params: PGLint){.stdcall, importc, ogl.}
proc glLineStipple*(factor: GLint, pattern: GLushort){.stdcall, importc, ogl.}
proc glListBase*(base: GLuint){.stdcall, importc, ogl.}
proc glLoadIdentity*(){.stdcall, importc, ogl.}
proc glLoadMatrixd*(m: PGLdouble){.stdcall, importc, ogl.}
proc glLoadMatrixf*(m: PGLfloat){.stdcall, importc, ogl.}
proc glLoadName*(name: GLuint){.stdcall, importc, ogl.}
proc glMap1d*(target: GLenum, u1: GLdouble, u2: GLdouble, stride: GLint, 
              order: GLint, points: PGLdouble){.stdcall, importc, ogl.}
proc glMap1f*(target: GLenum, u1: GLfloat, u2: GLfloat, stride: GLint, 
              order: GLint, points: PGLfloat){.stdcall, importc, ogl.}
proc glMap2d*(target: GLenum, u1: GLdouble, u2: GLdouble, ustride: GLint, 
              uorder: GLint, v1: GLdouble, v2: GLdouble, vstride: GLint, 
              vorder: GLint, points: PGLdouble){.stdcall, importc, ogl.}
proc glMap2f*(target: GLenum, u1: GLfloat, u2: GLfloat, ustride: GLint, 
              uorder: GLint, v1: GLfloat, v2: GLfloat, vstride: GLint, 
              vorder: GLint, points: PGLfloat){.stdcall, importc, ogl.}
proc glMapGrid1d*(un: GLint, u1: GLdouble, u2: GLdouble){.stdcall, importc, ogl.}
proc glMapGrid1f*(un: GLint, u1: GLfloat, u2: GLfloat){.stdcall, importc, ogl.}
proc glMapGrid2d*(un: GLint, u1: GLdouble, u2: GLdouble, vn: GLint, 
                  v1: GLdouble, v2: GLdouble){.stdcall, importc, ogl.}
proc glMapGrid2f*(un: GLint, u1: GLfloat, u2: GLfloat, vn: GLint, v1: GLfloat, 
                  v2: GLfloat){.stdcall, importc, ogl.}
proc glMaterialf*(face: GLenum, pname: GLenum, param: GLfloat){.stdcall, importc, ogl.}
proc glMaterialfv*(face: GLenum, pname: GLenum, params: PGLfloat){.stdcall, importc, ogl.}
proc glMateriali*(face: GLenum, pname: GLenum, param: GLint){.stdcall, importc, ogl.}
proc glMaterialiv*(face: GLenum, pname: GLenum, params: PGLint){.stdcall, importc, ogl.}
proc glMatrixMode*(mode: GLenum){.stdcall, importc, ogl.}
proc glMultMatrixd*(m: PGLdouble){.stdcall, importc, ogl.}
proc glMultMatrixf*(m: PGLfloat){.stdcall, importc, ogl.}
proc glNewList*(list: GLuint, mode: GLenum){.stdcall, importc, ogl.}
proc glNormal3b*(nx: GLbyte, ny: GLbyte, nz: GLbyte){.stdcall, importc, ogl.}
proc glNormal3bv*(v: PGLbyte){.stdcall, importc, ogl.}
proc glNormal3d*(nx: GLdouble, ny: GLdouble, nz: GLdouble){.stdcall, importc, ogl.}
proc glNormal3dv*(v: PGLdouble){.stdcall, importc, ogl.}
proc glNormal3f*(nx: GLfloat, ny: GLfloat, nz: GLfloat){.stdcall, importc, ogl.}
proc glNormal3fv*(v: PGLfloat){.stdcall, importc, ogl.}
proc glNormal3i*(nx: GLint, ny: GLint, nz: GLint){.stdcall, importc, ogl.}
proc glNormal3iv*(v: PGLint){.stdcall, importc, ogl.}
proc glNormal3s*(nx: GLshort, ny: GLshort, nz: GLshort){.stdcall, importc, ogl.}
proc glNormal3sv*(v: PGLshort){.stdcall, importc, ogl.}
proc glNormalPointer*(typ: GLenum, stride: GLsizei, pointer: PGLvoid){.stdcall, importc, ogl.}
proc glOrtho*(left: GLdouble, right: GLdouble, bottom: GLdouble, top: GLdouble, 
              zNear: GLdouble, zFar: GLdouble){.stdcall, importc, ogl.}
proc glPassThrough*(token: GLfloat){.stdcall, importc, ogl.}
proc glPixelMapfv*(map: GLenum, mapsize: GLsizei, values: PGLfloat){.stdcall, importc, ogl.}
proc glPixelMapuiv*(map: GLenum, mapsize: GLsizei, values: PGLuint){.stdcall, importc, ogl.}
proc glPixelMapusv*(map: GLenum, mapsize: GLsizei, values: PGLushort){.stdcall, importc, ogl.}
proc glPixelTransferf*(pname: GLenum, param: GLfloat){.stdcall, importc, ogl.}
proc glPixelTransferi*(pname: GLenum, param: GLint){.stdcall, importc, ogl.}
proc glPixelZoom*(xfactor: GLfloat, yfactor: GLfloat){.stdcall, importc, ogl.}
proc glPolygonStipple*(mask: PGLubyte){.stdcall, importc, ogl.}
proc glPopAttrib*(){.stdcall, importc, ogl.}
proc glPopClientAttrib*(){.stdcall, importc, ogl.}
proc glPopMatrix*(){.stdcall, importc, ogl.}
proc glPopName*(){.stdcall, importc, ogl.}
proc glPrioritizeTextures*(n: GLsizei, textures: PGLuint, priorities: PGLclampf){.
    stdcall, importc, ogl.}
proc glPushAttrib*(mask: GLbitfield){.stdcall, importc, ogl.}
proc glPushClientAttrib*(mask: GLbitfield){.stdcall, importc, ogl.}
proc glPushMatrix*(){.stdcall, importc, ogl.}
proc glPushName*(name: GLuint){.stdcall, importc, ogl.}
proc glRasterPos2d*(x: GLdouble, y: GLdouble){.stdcall, importc, ogl.}
proc glRasterPos2dv*(v: PGLdouble){.stdcall, importc, ogl.}
proc glRasterPos2f*(x: GLfloat, y: GLfloat){.stdcall, importc, ogl.}
proc glRasterPos2fv*(v: PGLfloat){.stdcall, importc, ogl.}
proc glRasterPos2i*(x: GLint, y: GLint){.stdcall, importc, ogl.}
proc glRasterPos2iv*(v: PGLint){.stdcall, importc, ogl.}
proc glRasterPos2s*(x: GLshort, y: GLshort){.stdcall, importc, ogl.}
proc glRasterPos2sv*(v: PGLshort){.stdcall, importc, ogl.}
proc glRasterPos3d*(x: GLdouble, y: GLdouble, z: GLdouble){.stdcall, importc, ogl.}
proc glRasterPos3dv*(v: PGLdouble){.stdcall, importc, ogl.}
proc glRasterPos3f*(x: GLfloat, y: GLfloat, z: GLfloat){.stdcall, importc, ogl.}
proc glRasterPos3fv*(v: PGLfloat){.stdcall, importc, ogl.}
proc glRasterPos3i*(x: GLint, y: GLint, z: GLint){.stdcall, importc, ogl.}
proc glRasterPos3iv*(v: PGLint){.stdcall, importc, ogl.}
proc glRasterPos3s*(x: GLshort, y: GLshort, z: GLshort){.stdcall, importc, ogl.}
proc glRasterPos3sv*(v: PGLshort){.stdcall, importc, ogl.}
proc glRasterPos4d*(x: GLdouble, y: GLdouble, z: GLdouble, w: GLdouble){.stdcall, importc, ogl.}
proc glRasterPos4dv*(v: PGLdouble){.stdcall, importc, ogl.}
proc glRasterPos4f*(x: GLfloat, y: GLfloat, z: GLfloat, w: GLfloat){.stdcall, importc, ogl.}
proc glRasterPos4fv*(v: PGLfloat){.stdcall, importc, ogl.}
proc glRasterPos4i*(x: GLint, y: GLint, z: GLint, w: GLint){.stdcall, importc, ogl.}
proc glRasterPos4iv*(v: PGLint){.stdcall, importc, ogl.}
proc glRasterPos4s*(x: GLshort, y: GLshort, z: GLshort, w: GLshort){.stdcall, importc, ogl.}
proc glRasterPos4sv*(v: PGLshort){.stdcall, importc, ogl.}
proc glRectd*(x1: GLdouble, y1: GLdouble, x2: GLdouble, y2: GLdouble){.stdcall, importc, ogl.}
proc glRectdv*(v1: PGLdouble, v2: PGLdouble){.stdcall, importc, ogl.}
proc glRectf*(x1: GLfloat, y1: GLfloat, x2: GLfloat, y2: GLfloat){.stdcall, importc, ogl.}
proc glRectfv*(v1: PGLfloat, v2: PGLfloat){.stdcall, importc, ogl.}
proc glRecti*(x1: GLint, y1: GLint, x2: GLint, y2: GLint){.stdcall, importc, ogl.}
proc glRectiv*(v1: PGLint, v2: PGLint){.stdcall, importc, ogl.}
proc glRects*(x1: GLshort, y1: GLshort, x2: GLshort, y2: GLshort){.stdcall, importc, ogl.}
proc glRectsv*(v1: PGLshort, v2: PGLshort){.stdcall, importc, ogl.}
proc glRenderMode*(mode: GLenum): GLint{.stdcall, importc, ogl.}
proc glRotated*(angle: GLdouble, x: GLdouble, y: GLdouble, z: GLdouble){.stdcall, importc, ogl.}
proc glRotatef*(angle: GLfloat, x: GLfloat, y: GLfloat, z: GLfloat){.stdcall, importc, ogl.}
proc glScaled*(x: GLdouble, y: GLdouble, z: GLdouble){.stdcall, importc, ogl.}
proc glScalef*(x: GLfloat, y: GLfloat, z: GLfloat){.stdcall, importc, ogl.}
proc glSelectBuffer*(size: GLsizei, buffer: PGLuint){.stdcall, importc, ogl.}
proc glShadeModel*(mode: GLenum){.stdcall, importc, ogl.}
proc glTexCoord1d*(s: GLdouble){.stdcall, importc, ogl.}
proc glTexCoord1dv*(v: PGLdouble){.stdcall, importc, ogl.}
proc glTexCoord1f*(s: GLfloat){.stdcall, importc, ogl.}
proc glTexCoord1fv*(v: PGLfloat){.stdcall, importc, ogl.}
proc glTexCoord1i*(s: GLint){.stdcall, importc, ogl.}
proc glTexCoord1iv*(v: PGLint){.stdcall, importc, ogl.}
proc glTexCoord1s*(s: GLshort){.stdcall, importc, ogl.}
proc glTexCoord1sv*(v: PGLshort){.stdcall, importc, ogl.}
proc glTexCoord2d*(s: GLdouble, t: GLdouble){.stdcall, importc, ogl.}
proc glTexCoord2dv*(v: PGLdouble){.stdcall, importc, ogl.}
proc glTexCoord2f*(s: GLfloat, t: GLfloat){.stdcall, importc, ogl.}
proc glTexCoord2fv*(v: PGLfloat){.stdcall, importc, ogl.}
proc glTexCoord2i*(s: GLint, t: GLint){.stdcall, importc, ogl.}
proc glTexCoord2iv*(v: PGLint){.stdcall, importc, ogl.}
proc glTexCoord2s*(s: GLshort, t: GLshort){.stdcall, importc, ogl.}
proc glTexCoord2sv*(v: PGLshort){.stdcall, importc, ogl.}
proc glTexCoord3d*(s: GLdouble, t: GLdouble, r: GLdouble){.stdcall, importc, ogl.}
proc glTexCoord3dv*(v: PGLdouble){.stdcall, importc, ogl.}
proc glTexCoord3f*(s: GLfloat, t: GLfloat, r: GLfloat){.stdcall, importc, ogl.}
proc glTexCoord3fv*(v: PGLfloat){.stdcall, importc, ogl.}
proc glTexCoord3i*(s: GLint, t: GLint, r: GLint){.stdcall, importc, ogl.}
proc glTexCoord3iv*(v: PGLint){.stdcall, importc, ogl.}
proc glTexCoord3s*(s: GLshort, t: GLshort, r: GLshort){.stdcall, importc, ogl.}
proc glTexCoord3sv*(v: PGLshort){.stdcall, importc, ogl.}
proc glTexCoord4d*(s: GLdouble, t: GLdouble, r: GLdouble, q: GLdouble){.stdcall, importc, ogl.}
proc glTexCoord4dv*(v: PGLdouble){.stdcall, importc, ogl.}
proc glTexCoord4f*(s: GLfloat, t: GLfloat, r: GLfloat, q: GLfloat){.stdcall, importc, ogl.}
proc glTexCoord4fv*(v: PGLfloat){.stdcall, importc, ogl.}
proc glTexCoord4i*(s: GLint, t: GLint, r: GLint, q: GLint){.stdcall, importc, ogl.}
proc glTexCoord4iv*(v: PGLint){.stdcall, importc, ogl.}
proc glTexCoord4s*(s: GLshort, t: GLshort, r: GLshort, q: GLshort){.stdcall, importc, ogl.}
proc glTexCoord4sv*(v: PGLshort){.stdcall, importc, ogl.}
proc glTexCoordPointer*(size: GLint, typ: GLenum, stride: GLsizei, 
                        pointer: PGLvoid){.stdcall, importc, ogl.}
proc glTexEnvf*(target: GLenum, pname: GLenum, param: GLfloat){.stdcall, importc, ogl.}
proc glTexEnvfv*(target: GLenum, pname: GLenum, params: PGLfloat){.stdcall, importc, ogl.}
proc glTexEnvi*(target: GLenum, pname: GLenum, param: GLint){.stdcall, importc, ogl.}
proc glTexEnviv*(target: GLenum, pname: GLenum, params: PGLint){.stdcall, importc, ogl.}
proc glTexGend*(coord: GLenum, pname: GLenum, param: GLdouble){.stdcall, importc, ogl.}
proc glTexGendv*(coord: GLenum, pname: GLenum, params: PGLdouble){.stdcall, importc, ogl.}
proc glTexGenf*(coord: GLenum, pname: GLenum, param: GLfloat){.stdcall, importc, ogl.}
proc glTexGenfv*(coord: GLenum, pname: GLenum, params: PGLfloat){.stdcall, importc, ogl.}
proc glTexGeni*(coord: GLenum, pname: GLenum, param: GLint){.stdcall, importc, ogl.}
proc glTexGeniv*(coord: GLenum, pname: GLenum, params: PGLint){.stdcall, importc, ogl.}
proc glTranslated*(x: GLdouble, y: GLdouble, z: GLdouble){.stdcall, importc, ogl.}
proc glTranslatef*(x: GLfloat, y: GLfloat, z: GLfloat){.stdcall, importc, ogl.}
proc glVertex2d*(x: GLdouble, y: GLdouble){.stdcall, importc, ogl.}
proc glVertex2dv*(v: PGLdouble){.stdcall, importc, ogl.}
proc glVertex2f*(x: GLfloat, y: GLfloat){.stdcall, importc, ogl.}
proc glVertex2fv*(v: PGLfloat){.stdcall, importc, ogl.}
proc glVertex2i*(x: GLint, y: GLint){.stdcall, importc, ogl.}
proc glVertex2iv*(v: PGLint){.stdcall, importc, ogl.}
proc glVertex2s*(x: GLshort, y: GLshort){.stdcall, importc, ogl.}
proc glVertex2sv*(v: PGLshort){.stdcall, importc, ogl.}
proc glVertex3d*(x: GLdouble, y: GLdouble, z: GLdouble){.stdcall, importc, ogl.}
proc glVertex3dv*(v: PGLdouble){.stdcall, importc, ogl.}
proc glVertex3f*(x: GLfloat, y: GLfloat, z: GLfloat){.stdcall, importc, ogl.}
proc glVertex3fv*(v: PGLfloat){.stdcall, importc, ogl.}
proc glVertex3i*(x: GLint, y: GLint, z: GLint){.stdcall, importc, ogl.}
proc glVertex3iv*(v: PGLint){.stdcall, importc, ogl.}
proc glVertex3s*(x: GLshort, y: GLshort, z: GLshort){.stdcall, importc, ogl.}
proc glVertex3sv*(v: PGLshort){.stdcall, importc, ogl.}
proc glVertex4d*(x: GLdouble, y: GLdouble, z: GLdouble, w: GLdouble){.stdcall, importc, ogl.}
proc glVertex4dv*(v: PGLdouble){.stdcall, importc, ogl.}
proc glVertex4f*(x: GLfloat, y: GLfloat, z: GLfloat, w: GLfloat){.stdcall, importc, ogl.}
proc glVertex4fv*(v: PGLfloat){.stdcall, importc, ogl.}
proc glVertex4i*(x: GLint, y: GLint, z: GLint, w: GLint){.stdcall, importc, ogl.}
proc glVertex4iv*(v: PGLint){.stdcall, importc, ogl.}
proc glVertex4s*(x: GLshort, y: GLshort, z: GLshort, w: GLshort){.stdcall, importc, ogl.}
proc glVertex4sv*(v: PGLshort){.stdcall, importc, ogl.}
proc glVertexPointer*(size: GLint, typ: GLenum, stride: GLsizei, 
                      pointer: PGLvoid){.stdcall, importc, ogl.}
  # GL_VERSION_1_2
proc glBlendColor*(red: GLclampf, green: GLclampf, blue: GLclampf, 
                   alpha: GLclampf){.stdcall, importc, ogl.}
proc glBlendEquation*(mode: GLenum){.stdcall, importc, ogl.}
proc glDrawRangeElements*(mode: GLenum, start: GLuint, ending: GLuint, 
                          count: GLsizei, typ: GLenum, indices: PGLvoid){.
    stdcall, importc, ogl.}
proc glTexImage3D*(target: GLenum, level: GLint, internalformat: GLint, 
                   width: GLsizei, height: GLsizei, depth: GLsizei, 
                   border: GLint, format: GLenum, typ: GLenum, pixels: PGLvoid){.
    stdcall, importc, ogl.}
proc glTexSubImage3D*(target: GLenum, level: GLint, xoffset: GLint, 
                      yoffset: GLint, zoffset: GLint, width: GLsizei, 
                      height: GLsizei, depth: GLsizei, format: GLenum, 
                      typ: GLenum, pixels: PGLvoid){.stdcall, importc, ogl.}
proc glCopyTexSubImage3D*(target: GLenum, level: GLint, xoffset: GLint, 
                          yoffset: GLint, zoffset: GLint, x: GLint, y: GLint, 
                          width: GLsizei, height: GLsizei){.stdcall, importc, ogl.}
proc glColorTable*(target: GLenum, internalformat: GLenum, width: GLsizei, 
                   format: GLenum, typ: GLenum, table: PGLvoid){.stdcall, importc, ogl.}
proc glColorTableParameterfv*(target: GLenum, pname: GLenum, params: PGLfloat){.
    stdcall, importc, ogl.}
proc glColorTableParameteriv*(target: GLenum, pname: GLenum, params: PGLint){.
    stdcall, importc, ogl.}
proc glCopyColorTable*(target: GLenum, internalformat: GLenum, x: GLint, 
                       y: GLint, width: GLsizei){.stdcall, importc, ogl.}
proc glGetColorTable*(target: GLenum, format: GLenum, typ: GLenum, 
                      table: PGLvoid){.stdcall, importc, ogl.}
proc glGetColorTableParameterfv*(target: GLenum, pname: GLenum, params: PGLfloat){.
    stdcall, importc, ogl.}
proc glGetColorTableParameteriv*(target: GLenum, pname: GLenum, params: PGLint){.
    stdcall, importc, ogl.}
proc glColorSubTable*(target: GLenum, start: GLsizei, count: GLsizei, 
                      format: GLenum, typ: GLenum, data: PGLvoid){.stdcall, importc, ogl.}
proc glCopyColorSubTable*(target: GLenum, start: GLsizei, x: GLint, y: GLint, 
                          width: GLsizei){.stdcall, importc, ogl.}
proc glConvolutionFilter1D*(target: GLenum, internalformat: GLenum, 
                            width: GLsizei, format: GLenum, typ: GLenum, 
                            image: PGLvoid){.stdcall, importc, ogl.}
proc glConvolutionFilter2D*(target: GLenum, internalformat: GLenum, 
                            width: GLsizei, height: GLsizei, format: GLenum, 
                            typ: GLenum, image: PGLvoid){.stdcall, importc, ogl.}
proc glConvolutionParameterf*(target: GLenum, pname: GLenum, params: GLfloat){.
    stdcall, importc, ogl.}
proc glConvolutionParameterfv*(target: GLenum, pname: GLenum, params: PGLfloat){.
    stdcall, importc, ogl.}
proc glConvolutionParameteri*(target: GLenum, pname: GLenum, params: GLint){.
    stdcall, importc, ogl.}
proc glConvolutionParameteriv*(target: GLenum, pname: GLenum, params: PGLint){.
    stdcall, importc, ogl.}
proc glCopyConvolutionFilter1D*(target: GLenum, internalformat: GLenum, 
                                x: GLint, y: GLint, width: GLsizei){.stdcall, importc, ogl.}
proc glCopyConvolutionFilter2D*(target: GLenum, internalformat: GLenum, 
                                x: GLint, y: GLint, width: GLsizei, 
                                height: GLsizei){.stdcall, importc, ogl.}
proc glGetConvolutionFilter*(target: GLenum, format: GLenum, typ: GLenum, 
                             image: PGLvoid){.stdcall, importc, ogl.}
proc glGetConvolutionParameterfv*(target: GLenum, pname: GLenum, 
                                  params: PGLfloat){.stdcall, importc, ogl.}
proc glGetConvolutionParameteriv*(target: GLenum, pname: GLenum, params: PGLint){.
    stdcall, importc, ogl.}
proc glGetSeparableFilter*(target: GLenum, format: GLenum, typ: GLenum, 
                           row: PGLvoid, column: PGLvoid, span: PGLvoid){.
    stdcall, importc, ogl.}
proc glSeparableFilter2D*(target: GLenum, internalformat: GLenum, 
                          width: GLsizei, height: GLsizei, format: GLenum, 
                          typ: GLenum, row: PGLvoid, column: PGLvoid){.stdcall, importc, ogl.}
proc glGetHistogram*(target: GLenum, reset: GLboolean, format: GLenum, 
                     typ: GLenum, values: PGLvoid){.stdcall, importc, ogl.}
proc glGetHistogramParameterfv*(target: GLenum, pname: GLenum, params: PGLfloat){.
    stdcall, importc, ogl.}
proc glGetHistogramParameteriv*(target: GLenum, pname: GLenum, params: PGLint){.
    stdcall, importc, ogl.}
proc glGetMinmax*(target: GLenum, reset: GLboolean, format: GLenum, typ: GLenum, 
                  values: PGLvoid){.stdcall, importc, ogl.}
proc glGetMinmaxParameterfv*(target: GLenum, pname: GLenum, params: PGLfloat){.
    stdcall, importc, ogl.}
proc glGetMinmaxParameteriv*(target: GLenum, pname: GLenum, params: PGLint){.
    stdcall, importc, ogl.}
proc glHistogram*(target: GLenum, width: GLsizei, internalformat: GLenum, 
                  sink: GLboolean){.stdcall, importc, ogl.}
proc glMinmax*(target: GLenum, internalformat: GLenum, sink: GLboolean){.stdcall, importc, ogl.}
proc glResetHistogram*(target: GLenum){.stdcall, importc, ogl.}
proc glResetMinmax*(target: GLenum){.stdcall, importc, ogl.}
  # GL_VERSION_1_3
proc glActiveTexture*(texture: GLenum){.stdcall, importc, ogl.}
proc glSampleCoverage*(value: GLclampf, invert: GLboolean){.stdcall, importc, ogl.}
proc glCompressedTexImage3D*(target: GLenum, level: GLint, 
                             internalformat: GLenum, width: GLsizei, 
                             height: GLsizei, depth: GLsizei, border: GLint, 
                             imageSize: GLsizei, data: PGLvoid){.stdcall, importc, ogl.}
proc glCompressedTexImage2D*(target: GLenum, level: GLint, 
                             internalformat: GLenum, width: GLsizei, 
                             height: GLsizei, border: GLint, imageSize: GLsizei, 
                             data: PGLvoid){.stdcall, importc, ogl.}
proc glCompressedTexImage1D*(target: GLenum, level: GLint, 
                             internalformat: GLenum, width: GLsizei, 
                             border: GLint, imageSize: GLsizei, data: PGLvoid){.
    stdcall, importc, ogl.}
proc glCompressedTexSubImage3D*(target: GLenum, level: GLint, xoffset: GLint, 
                                yoffset: GLint, zoffset: GLint, width: GLsizei, 
                                height: GLsizei, depth: GLsizei, format: GLenum, 
                                imageSize: GLsizei, data: PGLvoid){.stdcall, importc, ogl.}
proc glCompressedTexSubImage2D*(target: GLenum, level: GLint, xoffset: GLint, 
                                yoffset: GLint, width: GLsizei, height: GLsizei, 
                                format: GLenum, imageSize: GLsizei, 
                                data: PGLvoid){.stdcall, importc, ogl.}
proc glCompressedTexSubImage1D*(target: GLenum, level: GLint, xoffset: GLint, 
                                width: GLsizei, format: GLenum, 
                                imageSize: GLsizei, data: PGLvoid){.stdcall, importc, ogl.}
proc glGetCompressedTexImage*(target: GLenum, level: GLint, img: PGLvoid){.
    stdcall, importc, ogl.}
proc glClientActiveTexture*(texture: GLenum){.stdcall, importc, ogl.}
proc glMultiTexCoord1d*(target: GLenum, s: GLdouble){.stdcall, importc, ogl.}
proc glMultiTexCoord1dv*(target: GLenum, v: PGLdouble){.stdcall, importc, ogl.}
proc glMultiTexCoord1f*(target: GLenum, s: GLfloat){.stdcall, importc, ogl.}
proc glMultiTexCoord1fv*(target: GLenum, v: PGLfloat){.stdcall, importc, ogl.}
proc glMultiTexCoord1i*(target: GLenum, s: GLint){.stdcall, importc, ogl.}
proc glMultiTexCoord1iv*(target: GLenum, v: PGLint){.stdcall, importc, ogl.}
proc glMultiTexCoord1s*(target: GLenum, s: GLshort){.stdcall, importc, ogl.}
proc glMultiTexCoord1sv*(target: GLenum, v: PGLshort){.stdcall, importc, ogl.}
proc glMultiTexCoord2d*(target: GLenum, s: GLdouble, t: GLdouble){.stdcall, importc, ogl.}
proc glMultiTexCoord2dv*(target: GLenum, v: PGLdouble){.stdcall, importc, ogl.}
proc glMultiTexCoord2f*(target: GLenum, s: GLfloat, t: GLfloat){.stdcall, importc, ogl.}
proc glMultiTexCoord2fv*(target: GLenum, v: PGLfloat){.stdcall, importc, ogl.}
proc glMultiTexCoord2i*(target: GLenum, s: GLint, t: GLint){.stdcall, importc, ogl.}
proc glMultiTexCoord2iv*(target: GLenum, v: PGLint){.stdcall, importc, ogl.}
proc glMultiTexCoord2s*(target: GLenum, s: GLshort, t: GLshort){.stdcall, importc, ogl.}
proc glMultiTexCoord2sv*(target: GLenum, v: PGLshort){.stdcall, importc, ogl.}
proc glMultiTexCoord3d*(target: GLenum, s: GLdouble, t: GLdouble, r: GLdouble){.
    stdcall, importc, ogl.}
proc glMultiTexCoord3dv*(target: GLenum, v: PGLdouble){.stdcall, importc, ogl.}
proc glMultiTexCoord3f*(target: GLenum, s: GLfloat, t: GLfloat, r: GLfloat){.
    stdcall, importc, ogl.}
proc glMultiTexCoord3fv*(target: GLenum, v: PGLfloat){.stdcall, importc, ogl.}
proc glMultiTexCoord3i*(target: GLenum, s: GLint, t: GLint, r: GLint){.stdcall, importc, ogl.}
proc glMultiTexCoord3iv*(target: GLenum, v: PGLint){.stdcall, importc, ogl.}
proc glMultiTexCoord3s*(target: GLenum, s: GLshort, t: GLshort, r: GLshort){.
    stdcall, importc, ogl.}
proc glMultiTexCoord3sv*(target: GLenum, v: PGLshort){.stdcall, importc, ogl.}
proc glMultiTexCoord4d*(target: GLenum, s: GLdouble, t: GLdouble, r: GLdouble, 
                        q: GLdouble){.stdcall, importc, ogl.}
proc glMultiTexCoord4dv*(target: GLenum, v: PGLdouble){.stdcall, importc, ogl.}
proc glMultiTexCoord4f*(target: GLenum, s: GLfloat, t: GLfloat, r: GLfloat, 
                        q: GLfloat){.stdcall, importc, ogl.}
proc glMultiTexCoord4fv*(target: GLenum, v: PGLfloat){.stdcall, importc, ogl.}
proc glMultiTexCoord4i*(target: GLenum, s: GLint, t: GLint, r: GLint, q: GLint){.
    stdcall, importc, ogl.}
proc glMultiTexCoord4iv*(target: GLenum, v: PGLint){.stdcall, importc, ogl.}
proc glMultiTexCoord4s*(target: GLenum, s: GLshort, t: GLshort, r: GLshort, 
                        q: GLshort){.stdcall, importc, ogl.}
proc glMultiTexCoord4sv*(target: GLenum, v: PGLshort){.stdcall, importc, ogl.}
proc glLoadTransposeMatrixf*(m: PGLfloat){.stdcall, importc, ogl.}
proc glLoadTransposeMatrixd*(m: PGLdouble){.stdcall, importc, ogl.}
proc glMultTransposeMatrixf*(m: PGLfloat){.stdcall, importc, ogl.}
proc glMultTransposeMatrixd*(m: PGLdouble){.stdcall, importc, ogl.}
  # GL_VERSION_1_4
proc glBlendFuncSeparate*(sfactorRGB: GLenum, dfactorRGB: GLenum, 
                          sfactorAlpha: GLenum, dfactorAlpha: GLenum){.stdcall, importc, ogl.}
proc glMultiDrawArrays*(mode: GLenum, first: PGLint, count: PGLsizei, 
                        primcount: GLsizei){.stdcall, importc, ogl.}
proc glMultiDrawElements*(mode: GLenum, count: PGLsizei, typ: GLenum, 
                          indices: PGLvoid, primcount: GLsizei){.stdcall, importc, ogl.}
proc glPointParameterf*(pname: GLenum, param: GLfloat){.stdcall, importc, ogl.}
proc glPointParameterfv*(pname: GLenum, params: PGLfloat){.stdcall, importc, ogl.}
proc glPointParameteri*(pname: GLenum, param: GLint){.stdcall, importc, ogl.}
proc glPointParameteriv*(pname: GLenum, params: PGLint){.stdcall, importc, ogl.}
proc glFogCoordf*(coord: GLfloat){.stdcall, importc, ogl.}
proc glFogCoordfv*(coord: PGLfloat){.stdcall, importc, ogl.}
proc glFogCoordd*(coord: GLdouble){.stdcall, importc, ogl.}
proc glFogCoorddv*(coord: PGLdouble){.stdcall, importc, ogl.}
proc glFogCoordPointer*(typ: GLenum, stride: GLsizei, pointer: PGLvoid){.stdcall, importc, ogl.}
proc glSecondaryColor3b*(red: GLbyte, green: GLbyte, blue: GLbyte){.stdcall, importc, ogl.}
proc glSecondaryColor3bv*(v: PGLbyte){.stdcall, importc, ogl.}
proc glSecondaryColor3d*(red: GLdouble, green: GLdouble, blue: GLdouble){.
    stdcall, importc, ogl.}
proc glSecondaryColor3dv*(v: PGLdouble){.stdcall, importc, ogl.}
proc glSecondaryColor3f*(red: GLfloat, green: GLfloat, blue: GLfloat){.stdcall, importc, ogl.}
proc glSecondaryColor3fv*(v: PGLfloat){.stdcall, importc, ogl.}
proc glSecondaryColor3i*(red: GLint, green: GLint, blue: GLint){.stdcall, importc, ogl.}
proc glSecondaryColor3iv*(v: PGLint){.stdcall, importc, ogl.}
proc glSecondaryColor3s*(red: GLshort, green: GLshort, blue: GLshort){.stdcall, importc, ogl.}
proc glSecondaryColor3sv*(v: PGLshort){.stdcall, importc, ogl.}
proc glSecondaryColor3ub*(red: GLubyte, green: GLubyte, blue: GLubyte){.stdcall, importc, ogl.}
proc glSecondaryColor3ubv*(v: PGLubyte){.stdcall, importc, ogl.}
proc glSecondaryColor3ui*(red: GLuint, green: GLuint, blue: GLuint){.stdcall, importc, ogl.}
proc glSecondaryColor3uiv*(v: PGLuint){.stdcall, importc, ogl.}
proc glSecondaryColor3us*(red: GLushort, green: GLushort, blue: GLushort){.
    stdcall, importc, ogl.}
proc glSecondaryColor3usv*(v: PGLushort){.stdcall, importc, ogl.}
proc glSecondaryColorPointer*(size: GLint, typ: GLenum, stride: GLsizei, 
                              pointer: PGLvoid){.stdcall, importc, ogl.}
proc glWindowPos2d*(x: GLdouble, y: GLdouble){.stdcall, importc, ogl.}
proc glWindowPos2dv*(v: PGLdouble){.stdcall, importc, ogl.}
proc glWindowPos2f*(x: GLfloat, y: GLfloat){.stdcall, importc, ogl.}
proc glWindowPos2fv*(v: PGLfloat){.stdcall, importc, ogl.}
proc glWindowPos2i*(x: GLint, y: GLint){.stdcall, importc, ogl.}
proc glWindowPos2iv*(v: PGLint){.stdcall, importc, ogl.}
proc glWindowPos2s*(x: GLshort, y: GLshort){.stdcall, importc, ogl.}
proc glWindowPos2sv*(v: PGLshort){.stdcall, importc, ogl.}
proc glWindowPos3d*(x: GLdouble, y: GLdouble, z: GLdouble){.stdcall, importc, ogl.}
proc glWindowPos3dv*(v: PGLdouble){.stdcall, importc, ogl.}
proc glWindowPos3f*(x: GLfloat, y: GLfloat, z: GLfloat){.stdcall, importc, ogl.}
proc glWindowPos3fv*(v: PGLfloat){.stdcall, importc, ogl.}
proc glWindowPos3i*(x: GLint, y: GLint, z: GLint){.stdcall, importc, ogl.}
proc glWindowPos3iv*(v: PGLint){.stdcall, importc, ogl.}
proc glWindowPos3s*(x: GLshort, y: GLshort, z: GLshort){.stdcall, importc, ogl.}
proc glWindowPos3sv*(v: PGLshort){.stdcall, importc, ogl.}
  # GL_VERSION_1_5
proc glGenQueries*(n: GLsizei, ids: PGLuint){.stdcall, importc, ogl.}
proc glDeleteQueries*(n: GLsizei, ids: PGLuint){.stdcall, importc, ogl.}
proc glIsQuery*(id: GLuint): Bool{.stdcall, importc, ogl.}
proc glBeginQuery*(target: GLenum, id: GLuint){.stdcall, importc, ogl.}
proc glEndQuery*(target: GLenum){.stdcall, importc, ogl.}
proc glGetQueryiv*(target, pname: GLenum, params: PGLint){.stdcall, importc, ogl.}
proc glGetQueryObjectiv*(id: GLuint, pname: GLenum, params: PGLint){.stdcall, importc, ogl.}
proc glGetQueryObjectuiv*(id: GLuint, pname: GLenum, params: PGLuint){.stdcall, importc, ogl.}
proc glBindBuffer*(target: GLenum, buffer: GLuint){.stdcall, importc, ogl.}
proc glDeleteBuffers*(n: GLsizei, buffers: PGLuint){.stdcall, importc, ogl.}
proc glGenBuffers*(n: GLsizei, buffers: PGLuint){.stdcall, importc, ogl.}
proc glIsBuffer*(buffer: GLuint): GLboolean{.stdcall, importc, ogl.}
proc glBufferData*(target: GLenum, size: GLsizeiptr, data: PGLvoid, 
                   usage: GLenum){.stdcall, importc, ogl.}
proc glBufferSubData*(target: GLenum, offset: GLintptr, size: GLsizeiptr, 
                      data: PGLvoid){.stdcall, importc, ogl.}
proc glGetBufferSubData*(target: GLenum, offset: GLintptr, size: GLsizeiptr, 
                         data: PGLvoid){.stdcall, importc, ogl.}
proc glMapBuffer*(target: GLenum, access: GLenum): PGLvoid{.stdcall, importc, ogl.}
proc glUnmapBuffer*(target: GLenum): GLboolean{.stdcall, importc, ogl.}
proc glGetBufferParameteriv*(target: GLenum, pname: GLenum, params: PGLint){.
    stdcall, importc, ogl.}
proc glGetBufferPointerv*(target: GLenum, pname: GLenum, params: PGLvoid){.
    stdcall, importc, ogl.}
  # GL_VERSION_2_0
proc glBlendEquationSeparate*(modeRGB: GLenum, modeAlpha: GLenum){.stdcall, importc, ogl.}
proc glDrawBuffers*(n: GLsizei, bufs: PGLenum){.stdcall, importc, ogl.}
proc glStencilOpSeparate*(face: GLenum, sfail: GLenum, dpfail: GLenum, 
                          dppass: GLenum){.stdcall, importc, ogl.}
proc glStencilFuncSeparate*(face: GLenum, func: GLenum, theRef: GLint, mask: GLuint){.
    stdcall, importc, ogl.}
proc glStencilMaskSeparate*(face: GLenum, mask: GLuint){.stdcall, importc, ogl.}
proc glAttachShader*(programObj, shaderObj: GLHandle){.stdcall, importc, ogl.}
proc glBindAttribLocation*(programObj: GLHandle, index: GLuint, name: PGLchar){.
    stdcall, importc, ogl.}
proc glCompileShader*(shaderObj: GLHandle){.stdcall, importc, ogl.}
proc glCreateProgram*(): GLHandle{.stdcall, importc, ogl.}
proc glCreateShader*(shaderType: GLenum): GLHandle{.stdcall, importc, ogl.}
proc glDeleteProgram*(programObj: GLHandle){.stdcall, importc, ogl.}
proc glDeleteShader*(shaderObj: GLHandle){.stdcall, importc, ogl.}
proc glDetachShader*(programObj, shaderObj: GLHandle){.stdcall, importc, ogl.}
proc glDisableVertexAttribArray*(index: GLuint){.stdcall, importc, ogl.}
proc glEnableVertexAttribArray*(index: GLuint){.stdcall, importc, ogl.}
proc glGetActiveAttrib*(programObj: GLHandle, index: GLuint, maxlength: GLsizei, 
                        len: var GLint, size: var GLint, typ: var GLenum, 
                        name: PGLchar){.stdcall, importc, ogl.}
proc glGetActiveUniform*(programObj: GLHandle, index: GLuint, 
                         maxLength: GLsizei, len: var GLsizei, size: var GLint, 
                         typ: var GLenum, name: PGLchar){.stdcall, importc, ogl.}
proc glGetAttachedShaders*(programObj: GLHandle, MaxCount: GLsizei, 
                           Count: var GLint, shaders: PGLuint){.stdcall, importc, ogl.}
proc glGetAttribLocation*(programObj: GLHandle, char: PGLchar): GLint{.stdcall, importc, ogl.}
proc glGetProgramiv*(programObj: GLHandle, pname: GLenum, params: PGLint){.
    stdcall, importc, ogl.}
proc glGetProgramInfoLog*(programObj: GLHandle, maxLength: GLsizei, 
                          len: var GLint, infoLog: PGLchar){.stdcall, importc, ogl.}
proc glGetShaderiv*(shaderObj: GLHandle, pname: GLenum, params: PGLint){.stdcall, importc, ogl.}
proc glGetShaderInfoLog*(shaderObj: GLHandle, maxLength: GLsizei, 
                         len: var GLint, infoLog: PGLchar){.stdcall, importc, ogl.}
proc glGetShaderSource*(shaderObj: GLHandle, maxlength: GLsizei, 
                        len: var GLsizei, source: PGLchar){.stdcall, importc, ogl.}
proc glGetUniformLocation*(programObj: GLHandle, char: PGLchar): GLint{.stdcall, importc, ogl.}
proc glGetUniformfv*(programObj: GLHandle, location: GLint, params: PGLfloat){.
    stdcall, importc, ogl.}
proc glGetUniformiv*(programObj: GLHandle, location: GLint, params: PGLint){.
    stdcall, importc, ogl.}
proc glGetVertexAttribfv*(index: GLuint, pname: GLenum, params: PGLfloat){.
    stdcall, importc, ogl.}
proc glGetVertexAttribiv*(index: GLuint, pname: GLenum, params: PGLint){.stdcall, importc, ogl.}
proc glGetVertexAttribPointerv*(index: GLuint, pname: GLenum, pointer: PGLvoid){.
    stdcall, importc, ogl.}
proc glIsProgram*(programObj: GLHandle): GLboolean{.stdcall, importc, ogl.}
proc glIsShader*(shaderObj: GLHandle): GLboolean{.stdcall, importc, ogl.}
proc glLinkProgram*(programObj: GLHandle){.stdcall, importc, ogl.}
proc glShaderSource*(shaderObj: GLHandle, count: GLsizei, string: CstringArray, 
                     lengths: PGLint){.stdcall, importc, ogl.}
proc glUseProgram*(programObj: GLHandle){.stdcall, importc, ogl.}
proc glUniform1f*(location: GLint, v0: GLfloat){.stdcall, importc, ogl.}
proc glUniform2f*(location: GLint, v0, v1: GLfloat){.stdcall, importc, ogl.}
proc glUniform3f*(location: GLint, v0, v1, v2: GLfloat){.stdcall, importc, ogl.}
proc glUniform4f*(location: GLint, v0, v1, v2, v3: GLfloat){.stdcall, importc, ogl.}
proc glUniform1i*(location: GLint, v0: GLint){.stdcall, importc, ogl.}
proc glUniform2i*(location: GLint, v0, v1: GLint){.stdcall, importc, ogl.}
proc glUniform3i*(location: GLint, v0, v1, v2: GLint){.stdcall, importc, ogl.}
proc glUniform4i*(location: GLint, v0, v1, v2, v3: GLint){.stdcall, importc, ogl.}
proc glUniform1fv*(location: GLint, count: GLsizei, value: PGLfloat){.stdcall, importc, ogl.}
proc glUniform2fv*(location: GLint, count: GLsizei, value: PGLfloat){.stdcall, importc, ogl.}
proc glUniform3fv*(location: GLint, count: GLsizei, value: PGLfloat){.stdcall, importc, ogl.}
proc glUniform4fv*(location: GLint, count: GLsizei, value: PGLfloat){.stdcall, importc, ogl.}
proc glUniform1iv*(location: GLint, count: GLsizei, value: PGLint){.stdcall, importc, ogl.}
proc glUniform2iv*(location: GLint, count: GLsizei, value: PGLint){.stdcall, importc, ogl.}
proc glUniform3iv*(location: GLint, count: GLsizei, value: PGLint){.stdcall, importc, ogl.}
proc glUniform4iv*(location: GLint, count: GLsizei, value: PGLint){.stdcall, importc, ogl.}
proc glUniformMatrix2fv*(location: GLint, count: GLsizei, transpose: GLboolean, 
                         value: PGLfloat){.stdcall, importc, ogl.}
proc glUniformMatrix3fv*(location: GLint, count: GLsizei, transpose: GLboolean, 
                         value: PGLfloat){.stdcall, importc, ogl.}
proc glUniformMatrix4fv*(location: GLint, count: GLsizei, transpose: GLboolean, 
                         value: PGLfloat){.stdcall, importc, ogl.}
proc glValidateProgram*(programObj: GLHandle){.stdcall, importc, ogl.}
proc glVertexAttrib1d*(index: GLuint, x: GLdouble){.stdcall, importc, ogl.}
proc glVertexAttrib1dv*(index: GLuint, v: PGLdouble){.stdcall, importc, ogl.}
proc glVertexAttrib1f*(index: GLuint, x: GLfloat){.stdcall, importc, ogl.}
proc glVertexAttrib1fv*(index: GLuint, v: PGLfloat){.stdcall, importc, ogl.}
proc glVertexAttrib1s*(index: GLuint, x: GLshort){.stdcall, importc, ogl.}
proc glVertexAttrib1sv*(index: GLuint, v: PGLshort){.stdcall, importc, ogl.}
proc glVertexAttrib2d*(index: GLuint, x: GLdouble, y: GLdouble){.stdcall, importc, ogl.}
proc glVertexAttrib2dv*(index: GLuint, v: PGLdouble){.stdcall, importc, ogl.}
proc glVertexAttrib2f*(index: GLuint, x: GLfloat, y: GLfloat){.stdcall, importc, ogl.}
proc glVertexAttrib2fv*(index: GLuint, v: PGLfloat){.stdcall, importc, ogl.}
proc glVertexAttrib2s*(index: GLuint, x: GLshort, y: GLshort){.stdcall, importc, ogl.}
proc glVertexAttrib2sv*(index: GLuint, v: PGLshort){.stdcall, importc, ogl.}
proc glVertexAttrib3d*(index: GLuint, x: GLdouble, y: GLdouble, z: GLdouble){.
    stdcall, importc, ogl.}
proc glVertexAttrib3dv*(index: GLuint, v: PGLdouble){.stdcall, importc, ogl.}
proc glVertexAttrib3f*(index: GLuint, x: GLfloat, y: GLfloat, z: GLfloat){.
    stdcall, importc, ogl.}
proc glVertexAttrib3fv*(index: GLuint, v: PGLfloat){.stdcall, importc, ogl.}
proc glVertexAttrib3s*(index: GLuint, x: GLshort, y: GLshort, z: GLshort){.
    stdcall, importc, ogl.}
proc glVertexAttrib3sv*(index: GLuint, v: PGLshort){.stdcall, importc, ogl.}
proc glVertexAttrib4Nbv*(index: GLuint, v: PGLbyte){.stdcall, importc, ogl.}
proc glVertexAttrib4Niv*(index: GLuint, v: PGLint){.stdcall, importc, ogl.}
proc glVertexAttrib4Nsv*(index: GLuint, v: PGLshort){.stdcall, importc, ogl.}
proc glVertexAttrib4Nub*(index: GLuint, x: GLubyte, y: GLubyte, z: GLubyte, 
                         w: GLubyte){.stdcall, importc, ogl.}
proc glVertexAttrib4Nubv*(index: GLuint, v: PGLubyte){.stdcall, importc, ogl.}
proc glVertexAttrib4Nuiv*(index: GLuint, v: PGLuint){.stdcall, importc, ogl.}
proc glVertexAttrib4Nusv*(index: GLuint, v: PGLushort){.stdcall, importc, ogl.}
proc glVertexAttrib4bv*(index: GLuint, v: PGLbyte){.stdcall, importc, ogl.}
proc glVertexAttrib4d*(index: GLuint, x: GLdouble, y: GLdouble, z: GLdouble, 
                       w: GLdouble){.stdcall, importc, ogl.}
proc glVertexAttrib4dv*(index: GLuint, v: PGLdouble){.stdcall, importc, ogl.}
proc glVertexAttrib4f*(index: GLuint, x: GLfloat, y: GLfloat, z: GLfloat, 
                       w: GLfloat){.stdcall, importc, ogl.}
proc glVertexAttrib4fv*(index: GLuint, v: PGLfloat){.stdcall, importc, ogl.}
proc glVertexAttrib4iv*(index: GLuint, v: PGLint){.stdcall, importc, ogl.}
proc glVertexAttrib4s*(index: GLuint, x: GLshort, y: GLshort, z: GLshort, 
                       w: GLshort){.stdcall, importc, ogl.}
proc glVertexAttrib4sv*(index: GLuint, v: PGLshort){.stdcall, importc, ogl.}
proc glVertexAttrib4ubv*(index: GLuint, v: PGLubyte){.stdcall, importc, ogl.}
proc glVertexAttrib4uiv*(index: GLuint, v: PGLuint){.stdcall, importc, ogl.}
proc glVertexAttrib4usv*(index: GLuint, v: PGLushort){.stdcall, importc, ogl.}
proc glVertexAttribPointer*(index: GLuint, size: GLint, typ: GLenum, 
                            normalized: GLboolean, stride: GLsizei, 
                            pointer: PGLvoid){.stdcall, importc, ogl.}
  # GL_VERSION_2_1
proc glUniformMatrix2x3fv*(location: GLint, count: GLsizei, 
                           transpose: GLboolean, value: PGLfloat){.stdcall, importc, ogl.}
proc glUniformMatrix3x2fv*(location: GLint, count: GLsizei, 
                           transpose: GLboolean, value: PGLfloat){.stdcall, importc, ogl.}
proc glUniformMatrix2x4fv*(location: GLint, count: GLsizei, 
                           transpose: GLboolean, value: PGLfloat){.stdcall, importc, ogl.}
proc glUniformMatrix4x2fv*(location: GLint, count: GLsizei, 
                           transpose: GLboolean, value: PGLfloat){.stdcall, importc, ogl.}
proc glUniformMatrix3x4fv*(location: GLint, count: GLsizei, 
                           transpose: GLboolean, value: PGLfloat){.stdcall, importc, ogl.}
proc glUniformMatrix4x3fv*(location: GLint, count: GLsizei, 
                           transpose: GLboolean, value: PGLfloat){.stdcall, importc, ogl.}
  # GL_VERSION_3_0
  # OpenGL 3.0 also reuses entry points from these extensions: 
  # ARB_framebuffer_object 
  # ARB_map_buffer_range 
  # ARB_vertex_array_object 
proc glColorMaski*(index: GLuint, r: GLboolean, g: GLboolean, b: GLboolean, 
                   a: GLboolean){.stdcall, importc, ogl.}
proc glGetBooleani_v*(target: GLenum, index: GLuint, data: PGLboolean){.stdcall, importc, ogl.}
proc glGetIntegeri_v*(target: GLenum, index: GLuint, data: PGLint){.stdcall, importc, ogl.}
proc glEnablei*(target: GLenum, index: GLuint){.stdcall, importc, ogl.}
proc glDisablei*(target: GLenum, index: GLuint){.stdcall, importc, ogl.}
proc glIsEnabledi*(target: GLenum, index: GLuint): GLboolean{.stdcall, importc, ogl.}
proc glBeginTransformFeedback*(primitiveMode: GLenum){.stdcall, importc, ogl.}
proc glEndTransformFeedback*(){.stdcall, importc, ogl.}
proc glBindBufferRange*(target: GLenum, index: GLuint, buffer: GLuint, 
                        offset: GLintptr, size: GLsizeiptr){.stdcall, importc, ogl.}
proc glBindBufferBase*(target: GLenum, index: GLuint, buffer: GLuint){.stdcall, importc, ogl.}
proc glTransformFeedbackVaryings*(prog: GLuint, count: GLsizei, 
                                  varyings: CstringArray, bufferMode: GLenum){.
    stdcall, importc, ogl.}
proc glGetTransformFeedbackVarying*(prog: GLuint, index: GLuint, 
                                    bufSize: GLsizei, len: PGLsizei, 
                                    size: PGLsizei, typ: PGLsizei, name: PGLchar){.
    stdcall, importc, ogl.}
proc glClampColor*(targe: GLenum, clamp: GLenum){.stdcall, importc, ogl.}
proc glBeginConditionalRender*(id: GLuint, mode: GLenum){.stdcall, importc, ogl.}
proc glEndConditionalRender*(){.stdcall, importc, ogl.}
proc glVertexAttribIPointer*(index: GLuint, size: GLint, typ: GLenum, 
                             stride: GLsizei, pointer: PGLvoid){.stdcall, importc, ogl.}
proc glGetVertexAttribIiv*(index: GLuint, pname: GLenum, params: PGLint){.
    stdcall, importc, ogl.}
proc glGetVertexAttribIuiv*(index: GLuint, pname: GLenum, params: PGLuint){.
    stdcall, importc, ogl.}
proc glVertexAttribI1i*(index: GLuint, x: GLint){.stdcall, importc, ogl.}
proc glVertexAttribI2i*(index: GLuint, x: GLint, y: GLint){.stdcall, importc, ogl.}
proc glVertexAttribI3i*(index: GLuint, x: GLint, y: GLint, z: GLint){.stdcall, importc, ogl.}
proc glVertexAttribI4i*(index: GLuint, x: GLint, y: GLint, z: GLint, w: GLint){.
    stdcall, importc, ogl.}
proc glVertexAttribI1ui*(index: GLuint, x: GLuint){.stdcall, importc, ogl.}
proc glVertexAttribI2ui*(index: GLuint, x: GLuint, y: GLuint){.stdcall, importc, ogl.}
proc glVertexAttribI3ui*(index: GLuint, x: GLuint, y: GLuint, z: GLuint){.
    stdcall, importc, ogl.}
proc glVertexAttribI4ui*(index: GLuint, x: GLuint, y: GLuint, z: GLuint, 
                         w: GLuint){.stdcall, importc, ogl.}
proc glVertexAttribI1iv*(index: GLuint, v: PGLint){.stdcall, importc, ogl.}
proc glVertexAttribI2iv*(index: GLuint, v: PGLint){.stdcall, importc, ogl.}
proc glVertexAttribI3iv*(index: GLuint, v: PGLint){.stdcall, importc, ogl.}
proc glVertexAttribI4iv*(index: GLuint, v: PGLint){.stdcall, importc, ogl.}
proc glVertexAttribI1uiv*(index: GLuint, v: PGLuint){.stdcall, importc, ogl.}
proc glVertexAttribI2uiv*(index: GLuint, v: PGLuint){.stdcall, importc, ogl.}
proc glVertexAttribI3uiv*(index: GLuint, v: PGLuint){.stdcall, importc, ogl.}
proc glVertexAttribI4uiv*(index: GLuint, v: PGLuint){.stdcall, importc, ogl.}
proc glVertexAttribI4bv*(index: GLuint, v: PGLbyte){.stdcall, importc, ogl.}
proc glVertexAttribI4sv*(index: GLuint, v: PGLshort){.stdcall, importc, ogl.}
proc glVertexAttribI4ubv*(index: GLuint, v: PGLubyte){.stdcall, importc, ogl.}
proc glVertexAttribI4usv*(index: GLuint, v: PGLushort){.stdcall, importc, ogl.}
proc glGetUniformuiv*(prog: GLuint, location: GLint, params: PGLuint){.stdcall, importc, ogl.}
proc glBindFragDataLocation*(prog: GLuint, color: GLuint, name: PGLchar){.
    stdcall, importc, ogl.}
proc glGetFragDataLocation*(prog: GLuint, name: PGLchar): GLint{.stdcall, importc, ogl.}
proc glUniform1ui*(location: GLint, v0: GLuint){.stdcall, importc, ogl.}
proc glUniform2ui*(location: GLint, v0: GLuint, v1: GLuint){.stdcall, importc, ogl.}
proc glUniform3ui*(location: GLint, v0: GLuint, v1: GLuint, v2: GLuint){.stdcall, importc, ogl.}
proc glUniform4ui*(location: GLint, v0: GLuint, v1: GLuint, v2: GLuint, 
                   v3: GLuint){.stdcall, importc, ogl.}
proc glUniform1uiv*(location: GLint, count: GLsizei, value: PGLuint){.stdcall, importc, ogl.}
proc glUniform2uiv*(location: GLint, count: GLsizei, value: PGLuint){.stdcall, importc, ogl.}
proc glUniform3uiv*(location: GLint, count: GLsizei, value: PGLuint){.stdcall, importc, ogl.}
proc glUniform4uiv*(location: GLint, count: GLsizei, value: PGLuint){.stdcall, importc, ogl.}
proc glTexParameterIiv*(target: GLenum, pname: GLenum, params: PGLint){.stdcall, importc, ogl.}
proc glTexParameterIuiv*(target: GLenum, pname: GLenum, params: PGLuint){.
    stdcall, importc, ogl.}
proc glGetTexParameterIiv*(target: GLenum, pname: GLenum, params: PGLint){.
    stdcall, importc, ogl.}
proc glGetTexParameterIuiv*(target: GLenum, pname: GLenum, params: PGLuint){.
    stdcall, importc, ogl.}
proc glClearBufferiv*(buffer: GLenum, drawbuffer: GLint, value: PGLint){.stdcall, importc, ogl.}
proc glClearBufferuiv*(buffer: GLenum, drawbuffer: GLint, value: PGLuint){.
    stdcall, importc, ogl.}
proc glClearBufferfv*(buffer: GLenum, drawbuffer: GLint, value: PGLfloat){.
    stdcall, importc, ogl.}
proc glClearBufferfi*(buffer: GLenum, drawbuffer: GLint, depth: GLfloat, 
                      stencil: GLint){.stdcall, importc, ogl.}
proc glGetStringi*(name: GLenum, index: GLuint): PGLubyte{.stdcall, importc, ogl.}
  # GL_VERSION_3_1
  # OpenGL 3.1 also reuses entry points from these extensions: 
  # ARB_copy_buffer 
  # ARB_uniform_buffer_object 
proc glDrawArraysInstanced*(mode: GLenum, first: GLint, count: GLsizei, 
                            primcount: GLsizei){.stdcall, importc, ogl.}
proc glDrawElementsInstanced*(mode: GLenum, count: GLsizei, typ: GLenum, 
                              indices: PGLvoid, primcount: GLsizei){.stdcall, importc, ogl.}
proc glTexBuffer*(target: GLenum, internalformat: GLenum, buffer: GLuint){.
    stdcall, importc, ogl.}
proc glPrimitiveRestartIndex*(index: GLuint){.stdcall, importc, ogl.}
  # GL_VERSION_3_2
  # OpenGL 3.2 also reuses entry points from these extensions: 
  # ARB_draw_elements_base_vertex 
  # ARB_provoking_vertex 
  # ARB_sync 
  # ARB_texture_multisample 
proc glGetInteger64i_v*(target: GLenum, index: GLuint, data: PGLint64){.stdcall, importc, ogl.}
proc glGetBufferParameteri64v*(target: GLenum, pname: GLenum, params: PGLint64){.
    stdcall, importc, ogl.}
proc glFramebufferTexture*(target: GLenum, attachment: GLenum, texture: GLuint, 
                           level: GLint){.stdcall, importc, ogl.}
  #procedure glFramebufferTextureFace(target: GLenum; attachment: GLenum; texture: GLuint; level: GLint; face: GLenum); stdcall, importc, ogl;
  # GL_VERSION_3_3
  # OpenGL 3.3 also reuses entry points from these extensions: 
  # ARB_blend_func_extended 
  # ARB_sampler_objects 
  # ARB_explicit_attrib_location, but it has none 
  # ARB_occlusion_query2 (no entry points) 
  # ARB_shader_bit_encoding (no entry points) 
  # ARB_texture_rgb10_a2ui (no entry points) 
  # ARB_texture_swizzle (no entry points) 
  # ARB_timer_query 
  # ARB_vertextyp_2_10_10_10_rev 
proc glVertexAttribDivisor*(index: GLuint, divisor: GLuint){.stdcall, importc, ogl.}
  # GL_VERSION_4_0
  # OpenGL 4.0 also reuses entry points from these extensions: 
  # ARB_texture_query_lod (no entry points) 
  # ARB_draw_indirect 
  # ARB_gpu_shader5 (no entry points) 
  # ARB_gpu_shader_fp64 
  # ARB_shader_subroutine 
  # ARB_tessellation_shader 
  # ARB_texture_buffer_object_rgb32 (no entry points) 
  # ARB_texture_cube_map_array (no entry points) 
  # ARB_texture_gather (no entry points) 
  # ARB_transform_feedback2 
  # ARB_transform_feedback3 
proc glMinSampleShading*(value: GLclampf){.stdcall, importc, ogl.}
proc glBlendEquationi*(buf: GLuint, mode: GLenum){.stdcall, importc, ogl.}
proc glBlendEquationSeparatei*(buf: GLuint, modeRGB: GLenum, modeAlpha: GLenum){.
    stdcall, importc, ogl.}
proc glBlendFunci*(buf: GLuint, src: GLenum, dst: GLenum){.stdcall, importc, ogl.}
proc glBlendFuncSeparatei*(buf: GLuint, srcRGB: GLenum, dstRGB: GLenum, 
                           srcAlpha: GLenum, dstAlpha: GLenum){.stdcall, importc, ogl.}
  # GL_VERSION_4_1
  # OpenGL 4.1 also reuses entry points from these extensions: 
  # ARB_ES2_compatibility 
  # ARB_get_program_binary 
  # ARB_separate_shader_objects 
  # ARB_shader_precision (no entry points) 
  # ARB_vertex_attrib_64bit 
  # ARB_viewport_array 
  # GL_3DFX_tbuffer
proc glTbufferMask3DFX*(mask: GLuint){.stdcall, importc, ogl.}
  # GL_APPLE_element_array
proc glElementPointerAPPLE*(typ: GLenum, pointer: PGLvoid){.stdcall, importc, ogl.}
proc glDrawElementArrayAPPLE*(mode: GLenum, first: GLint, count: GLsizei){.
    stdcall, importc, ogl.}
proc glDrawRangeElementArrayAPPLE*(mode: GLenum, start: GLuint, ending: GLuint, 
                                   first: GLint, count: GLsizei){.stdcall, importc, ogl.}
proc glMultiDrawElementArrayAPPLE*(mode: GLenum, first: PGLint, count: PGLsizei, 
                                   primcount: GLsizei){.stdcall, importc, ogl.}
proc glMultiDrawRangeElementArrayAPPLE*(mode: GLenum, start: GLuint, 
                                        ending: GLuint, first: PGLint, 
                                        count: PGLsizei, primcount: GLsizei){.
    stdcall, importc, ogl.}
  # GL_APPLE_fence
proc glGenFencesAPPLE*(n: GLsizei, fences: PGLuint){.stdcall, importc, ogl.}
proc glDeleteFencesAPPLE*(n: GLsizei, fences: PGLuint){.stdcall, importc, ogl.}
proc glSetFenceAPPLE*(fence: GLuint){.stdcall, importc, ogl.}
proc glIsFenceAPPLE*(fence: GLuint): GLboolean{.stdcall, importc, ogl.}
proc glTestFenceAPPLE*(fence: GLuint): GLboolean{.stdcall, importc, ogl.}
proc glFinishFenceAPPLE*(fence: GLuint){.stdcall, importc, ogl.}
proc glTestObjectAPPLE*(obj: GLenum, name: GLuint): GLboolean{.stdcall, importc, ogl.}
proc glFinishObjectAPPLE*(obj: GLenum, name: GLint){.stdcall, importc, ogl.}
  # GL_APPLE_vertex_array_object
proc glBindVertexArrayAPPLE*(arr: GLuint){.stdcall, importc, ogl.}
proc glDeleteVertexArraysAPPLE*(n: GLsizei, arrays: PGLuint){.stdcall, importc, ogl.}
proc glGenVertexArraysAPPLE*(n: GLsizei, arrays: PGLuint){.stdcall, importc, ogl.}
proc glIsVertexArrayAPPLE*(arr: GLuint): GLboolean{.stdcall, importc, ogl.}
  # GL_APPLE_vertex_array_range
proc glVertexArrayRangeAPPLE*(len: GLsizei, pointer: PGLvoid){.stdcall, importc, ogl.}
proc glFlushVertexArrayRangeAPPLE*(len: GLsizei, pointer: PGLvoid){.stdcall, importc, ogl.}
proc glVertexArrayParameteriAPPLE*(pname: GLenum, param: GLint){.stdcall, importc, ogl.}
  # GL_APPLE_texture_range
proc glTextureRangeAPPLE*(target: GLenum, len: GLsizei, Pointer: PGLvoid){.
    stdcall, importc, ogl.}
proc glGetTexParameterPointervAPPLE*(target: GLenum, pname: GLenum, 
                                     params: PPGLvoid){.stdcall, importc, ogl.}
  # GL_APPLE_vertex_program_evaluators
proc glEnableVertexAttribAPPLE*(index: GLuint, pname: GLenum){.stdcall, importc, ogl.}
proc glDisableVertexAttribAPPLE*(index: GLuint, pname: GLenum){.stdcall, importc, ogl.}
proc glIsVertexAttribEnabledAPPLE*(index: GLuint, pname: GLenum): GLboolean{.
    stdcall, importc, ogl.}
proc glMapVertexAttrib1dAPPLE*(index: GLuint, size: GLuint, u1: GLdouble, 
                               u2: GLdouble, stride: GLint, order: GLint, 
                               points: PGLdouble){.stdcall, importc, ogl.}
proc glMapVertexAttrib1fAPPLE*(index: GLuint, size: GLuint, u1: GLfloat, 
                               u2: GLfloat, stride: GLint, order: GLint, 
                               points: PGLfloat){.stdcall, importc, ogl.}
proc glMapVertexAttrib2dAPPLE*(index: GLuint, size: GLuint, u1: GLdouble, 
                               u2: GLdouble, ustride: GLint, uorder: GLint, 
                               v1: GLdouble, v2: GLdouble, vstride: GLint, 
                               vorder: GLint, points: PGLdouble){.stdcall, importc, ogl.}
proc glMapVertexAttrib2fAPPLE*(index: GLuint, size: GLuint, u1: GLfloat, 
                               u2: GLfloat, ustride: GLint, order: GLint, 
                               v1: GLfloat, v2: GLfloat, vstride: GLint, 
                               vorder: GLint, points: GLfloat){.stdcall, importc, ogl.}
  # GL_APPLE_object_purgeable
proc glObjectPurgeableAPPLE*(objectType: GLenum, name: GLuint, option: GLenum): GLenum{.
    stdcall, importc, ogl.}
proc glObjectUnpurgeableAPPLE*(objectType: GLenum, name: GLuint, option: GLenum): GLenum{.
    stdcall, importc, ogl.}
proc glGetObjectParameterivAPPLE*(objectType: GLenum, name: GLuint, 
                                  pname: GLenum, params: PGLint){.stdcall, importc, ogl.}
  # GL_ARB_matrix_palette
proc glCurrentPaletteMatrixARB*(index: GLint){.stdcall, importc, ogl.}
proc glMatrixIndexubvARB*(size: GLint, indices: PGLubyte){.stdcall, importc, ogl.}
proc glMatrixIndexusvARB*(size: GLint, indices: PGLushort){.stdcall, importc, ogl.}
proc glMatrixIndexuivARB*(size: GLint, indices: PGLuint){.stdcall, importc, ogl.}
proc glMatrixIndexPointerARB*(size: GLint, typ: GLenum, stride: GLsizei, 
                              pointer: PGLvoid){.stdcall, importc, ogl.}
  # GL_ARB_multisample
proc glSampleCoverageARB*(value: GLclampf, invert: GLboolean){.stdcall, importc, ogl.}
  # GL_ARB_multitexture
proc glActiveTextureARB*(texture: GLenum){.stdcall, importc, ogl.}
proc glClientActiveTextureARB*(texture: GLenum){.stdcall, importc, ogl.}
proc glMultiTexCoord1dARB*(target: GLenum, s: GLdouble){.stdcall, importc, ogl.}
proc glMultiTexCoord1dvARB*(target: GLenum, v: PGLdouble){.stdcall, importc, ogl.}
proc glMultiTexCoord1fARB*(target: GLenum, s: GLfloat){.stdcall, importc, ogl.}
proc glMultiTexCoord1fvARB*(target: GLenum, v: PGLfloat){.stdcall, importc, ogl.}
proc glMultiTexCoord1iARB*(target: GLenum, s: GLint){.stdcall, importc, ogl.}
proc glMultiTexCoord1ivARB*(target: GLenum, v: PGLint){.stdcall, importc, ogl.}
proc glMultiTexCoord1sARB*(target: GLenum, s: GLshort){.stdcall, importc, ogl.}
proc glMultiTexCoord1svARB*(target: GLenum, v: PGLshort){.stdcall, importc, ogl.}
proc glMultiTexCoord2dARB*(target: GLenum, s: GLdouble, t: GLdouble){.stdcall, importc, ogl.}
proc glMultiTexCoord2dvARB*(target: GLenum, v: PGLdouble){.stdcall, importc, ogl.}
proc glMultiTexCoord2fARB*(target: GLenum, s: GLfloat, t: GLfloat){.stdcall, importc, ogl.}
proc glMultiTexCoord2fvARB*(target: GLenum, v: PGLfloat){.stdcall, importc, ogl.}
proc glMultiTexCoord2iARB*(target: GLenum, s: GLint, t: GLint){.stdcall, importc, ogl.}
proc glMultiTexCoord2ivARB*(target: GLenum, v: PGLint){.stdcall, importc, ogl.}
proc glMultiTexCoord2sARB*(target: GLenum, s: GLshort, t: GLshort){.stdcall, importc, ogl.}
proc glMultiTexCoord2svARB*(target: GLenum, v: PGLshort){.stdcall, importc, ogl.}
proc glMultiTexCoord3dARB*(target: GLenum, s: GLdouble, t: GLdouble, r: GLdouble){.
    stdcall, importc, ogl.}
proc glMultiTexCoord3dvARB*(target: GLenum, v: PGLdouble){.stdcall, importc, ogl.}
proc glMultiTexCoord3fARB*(target: GLenum, s: GLfloat, t: GLfloat, r: GLfloat){.
    stdcall, importc, ogl.}
proc glMultiTexCoord3fvARB*(target: GLenum, v: PGLfloat){.stdcall, importc, ogl.}
proc glMultiTexCoord3iARB*(target: GLenum, s: GLint, t: GLint, r: GLint){.
    stdcall, importc, ogl.}
proc glMultiTexCoord3ivARB*(target: GLenum, v: PGLint){.stdcall, importc, ogl.}
proc glMultiTexCoord3sARB*(target: GLenum, s: GLshort, t: GLshort, r: GLshort){.
    stdcall, importc, ogl.}
proc glMultiTexCoord3svARB*(target: GLenum, v: PGLshort){.stdcall, importc, ogl.}
proc glMultiTexCoord4dARB*(target: GLenum, s: GLdouble, t: GLdouble, 
                           r: GLdouble, q: GLdouble){.stdcall, importc, ogl.}
proc glMultiTexCoord4dvARB*(target: GLenum, v: PGLdouble){.stdcall, importc, ogl.}
proc glMultiTexCoord4fARB*(target: GLenum, s: GLfloat, t: GLfloat, r: GLfloat, 
                           q: GLfloat){.stdcall, importc, ogl.}
proc glMultiTexCoord4fvARB*(target: GLenum, v: PGLfloat){.stdcall, importc, ogl.}
proc glMultiTexCoord4iARB*(target: GLenum, s: GLint, t: GLint, r: GLint, 
                           q: GLint){.stdcall, importc, ogl.}
proc glMultiTexCoord4ivARB*(target: GLenum, v: PGLint){.stdcall, importc, ogl.}
proc glMultiTexCoord4sARB*(target: GLenum, s: GLshort, t: GLshort, r: GLshort, 
                           q: GLshort){.stdcall, importc, ogl.}
proc glMultiTexCoord4svARB*(target: GLenum, v: PGLshort){.stdcall, importc, ogl.}
  # GL_ARB_point_parameters
proc glPointParameterfARB*(pname: GLenum, param: GLfloat){.stdcall, importc, ogl.}
proc glPointParameterfvARB*(pname: GLenum, params: PGLfloat){.stdcall, importc, ogl.}
  # GL_ARB_texture_compression
proc glCompressedTexImage3DARB*(target: GLenum, level: GLint, 
                                internalformat: GLenum, width: GLsizei, 
                                height: GLsizei, depth: GLsizei, border: GLint, 
                                imageSize: GLsizei, data: PGLvoid){.stdcall, importc, ogl.}
proc glCompressedTexImage2DARB*(target: GLenum, level: GLint, 
                                internalformat: GLenum, width: GLsizei, 
                                height: GLsizei, border: GLint, 
                                imageSize: GLsizei, data: PGLvoid){.stdcall, importc, ogl.}
proc glCompressedTexImage1DARB*(target: GLenum, level: GLint, 
                                internalformat: GLenum, width: GLsizei, 
                                border: GLint, imageSize: GLsizei, data: PGLvoid){.
    stdcall, importc, ogl.}
proc glCompressedTexSubImage3DARB*(target: GLenum, level: GLint, xoffset: GLint, 
                                   yoffset: GLint, zoffset: GLint, 
                                   width: GLsizei, height: GLsizei, 
                                   depth: GLsizei, format: GLenum, 
                                   imageSize: GLsizei, data: PGLvoid){.stdcall, importc, ogl.}
proc glCompressedTexSubImage2DARB*(target: GLenum, level: GLint, xoffset: GLint, 
                                   yoffset: GLint, width: GLsizei, 
                                   height: GLsizei, format: GLenum, 
                                   imageSize: GLsizei, data: PGLvoid){.stdcall, importc, ogl.}
proc glCompressedTexSubImage1DARB*(target: GLenum, level: GLint, xoffset: GLint, 
                                   width: GLsizei, format: GLenum, 
                                   imageSize: GLsizei, data: PGLvoid){.stdcall, importc, ogl.}
proc glGetCompressedTexImageARB*(target: GLenum, level: GLint, img: PGLvoid){.
    stdcall, importc, ogl.}
  # GL_ARB_transpose_matrix
proc glLoadTransposeMatrixfARB*(m: PGLfloat){.stdcall, importc, ogl.}
proc glLoadTransposeMatrixdARB*(m: PGLdouble){.stdcall, importc, ogl.}
proc glMultTransposeMatrixfARB*(m: PGLfloat){.stdcall, importc, ogl.}
proc glMultTransposeMatrixdARB*(m: PGLdouble){.stdcall, importc, ogl.}
  # GL_ARB_vertex_blend
proc glWeightbvARB*(size: GLint, weights: PGLbyte){.stdcall, importc, ogl.}
proc glWeightsvARB*(size: GLint, weights: PGLshort){.stdcall, importc, ogl.}
proc glWeightivARB*(size: GLint, weights: PGLint){.stdcall, importc, ogl.}
proc glWeightfvARB*(size: GLint, weights: PGLfloat){.stdcall, importc, ogl.}
proc glWeightdvARB*(size: GLint, weights: PGLdouble){.stdcall, importc, ogl.}
proc glWeightubvARB*(size: GLint, weights: PGLubyte){.stdcall, importc, ogl.}
proc glWeightusvARB*(size: GLint, weights: PGLushort){.stdcall, importc, ogl.}
proc glWeightuivARB*(size: GLint, weights: PGLuint){.stdcall, importc, ogl.}
proc glWeightPointerARB*(size: GLint, typ: GLenum, stride: GLsizei, 
                         pointer: PGLvoid){.stdcall, importc, ogl.}
proc glVertexBlendARB*(count: GLint){.stdcall, importc, ogl.}
  # GL_ARB_vertex_buffer_object
proc glBindBufferARB*(target: GLenum, buffer: GLuint){.stdcall, importc, ogl.}
proc glDeleteBuffersARB*(n: GLsizei, buffers: PGLuint){.stdcall, importc, ogl.}
proc glGenBuffersARB*(n: GLsizei, buffers: PGLuint){.stdcall, importc, ogl.}
proc glIsBufferARB*(buffer: GLuint): GLboolean{.stdcall, importc, ogl.}
proc glBufferDataARB*(target: GLenum, size: GLsizeiptrARB, data: PGLvoid, 
                      usage: GLenum){.stdcall, importc, ogl.}
proc glBufferSubDataARB*(target: GLenum, offset: GLintptrARB, 
                         size: GLsizeiptrARB, data: PGLvoid){.stdcall, importc, ogl.}
proc glGetBufferSubDataARB*(target: GLenum, offset: GLintptrARB, 
                            size: GLsizeiptrARB, data: PGLvoid){.stdcall, importc, ogl.}
proc glMapBufferARB*(target: GLenum, access: GLenum): PGLvoid{.stdcall, importc, ogl.}
proc glUnmapBufferARB*(target: GLenum): GLboolean{.stdcall, importc, ogl.}
proc glGetBufferParameterivARB*(target: GLenum, pname: GLenum, params: PGLint){.
    stdcall, importc, ogl.}
proc glGetBufferPointervARB*(target: GLenum, pname: GLenum, params: PGLvoid){.
    stdcall, importc, ogl.}
  # GL_ARB_vertex_program
proc glVertexAttrib1dARB*(index: GLuint, x: GLdouble){.stdcall, importc, ogl.}
proc glVertexAttrib1dvARB*(index: GLuint, v: PGLdouble){.stdcall, importc, ogl.}
proc glVertexAttrib1fARB*(index: GLuint, x: GLfloat){.stdcall, importc, ogl.}
proc glVertexAttrib1fvARB*(index: GLuint, v: PGLfloat){.stdcall, importc, ogl.}
proc glVertexAttrib1sARB*(index: GLuint, x: GLshort){.stdcall, importc, ogl.}
proc glVertexAttrib1svARB*(index: GLuint, v: PGLshort){.stdcall, importc, ogl.}
proc glVertexAttrib2dARB*(index: GLuint, x: GLdouble, y: GLdouble){.stdcall, importc, ogl.}
proc glVertexAttrib2dvARB*(index: GLuint, v: PGLdouble){.stdcall, importc, ogl.}
proc glVertexAttrib2fARB*(index: GLuint, x: GLfloat, y: GLfloat){.stdcall, importc, ogl.}
proc glVertexAttrib2fvARB*(index: GLuint, v: PGLfloat){.stdcall, importc, ogl.}
proc glVertexAttrib2sARB*(index: GLuint, x: GLshort, y: GLshort){.stdcall, importc, ogl.}
proc glVertexAttrib2svARB*(index: GLuint, v: PGLshort){.stdcall, importc, ogl.}
proc glVertexAttrib3dARB*(index: GLuint, x: GLdouble, y: GLdouble, z: GLdouble){.
    stdcall, importc, ogl.}
proc glVertexAttrib3dvARB*(index: GLuint, v: PGLdouble){.stdcall, importc, ogl.}
proc glVertexAttrib3fARB*(index: GLuint, x: GLfloat, y: GLfloat, z: GLfloat){.
    stdcall, importc, ogl.}
proc glVertexAttrib3fvARB*(index: GLuint, v: PGLfloat){.stdcall, importc, ogl.}
proc glVertexAttrib3sARB*(index: GLuint, x: GLshort, y: GLshort, z: GLshort){.
    stdcall, importc, ogl.}
proc glVertexAttrib3svARB*(index: GLuint, v: PGLshort){.stdcall, importc, ogl.}
proc glVertexAttrib4NbvARB*(index: GLuint, v: PGLbyte){.stdcall, importc, ogl.}
proc glVertexAttrib4NivARB*(index: GLuint, v: PGLint){.stdcall, importc, ogl.}
proc glVertexAttrib4NsvARB*(index: GLuint, v: PGLshort){.stdcall, importc, ogl.}
proc glVertexAttrib4NubARB*(index: GLuint, x: GLubyte, y: GLubyte, z: GLubyte, 
                            w: GLubyte){.stdcall, importc, ogl.}
proc glVertexAttrib4NubvARB*(index: GLuint, v: PGLubyte){.stdcall, importc, ogl.}
proc glVertexAttrib4NuivARB*(index: GLuint, v: PGLuint){.stdcall, importc, ogl.}
proc glVertexAttrib4NusvARB*(index: GLuint, v: PGLushort){.stdcall, importc, ogl.}
proc glVertexAttrib4bvARB*(index: GLuint, v: PGLbyte){.stdcall, importc, ogl.}
proc glVertexAttrib4dARB*(index: GLuint, x: GLdouble, y: GLdouble, z: GLdouble, 
                          w: GLdouble){.stdcall, importc, ogl.}
proc glVertexAttrib4dvARB*(index: GLuint, v: PGLdouble){.stdcall, importc, ogl.}
proc glVertexAttrib4fARB*(index: GLuint, x: GLfloat, y: GLfloat, z: GLfloat, 
                          w: GLfloat){.stdcall, importc, ogl.}
proc glVertexAttrib4fvARB*(index: GLuint, v: PGLfloat){.stdcall, importc, ogl.}
proc glVertexAttrib4ivARB*(index: GLuint, v: PGLint){.stdcall, importc, ogl.}
proc glVertexAttrib4sARB*(index: GLuint, x: GLshort, y: GLshort, z: GLshort, 
                          w: GLshort){.stdcall, importc, ogl.}
proc glVertexAttrib4svARB*(index: GLuint, v: PGLshort){.stdcall, importc, ogl.}
proc glVertexAttrib4ubvARB*(index: GLuint, v: PGLubyte){.stdcall, importc, ogl.}
proc glVertexAttrib4uivARB*(index: GLuint, v: PGLuint){.stdcall, importc, ogl.}
proc glVertexAttrib4usvARB*(index: GLuint, v: PGLushort){.stdcall, importc, ogl.}
proc glVertexAttribPointerARB*(index: GLuint, size: GLint, typ: GLenum, 
                               normalized: GLboolean, stride: GLsizei, 
                               pointer: PGLvoid){.stdcall, importc, ogl.}
proc glEnableVertexAttribArrayARB*(index: GLuint){.stdcall, importc, ogl.}
proc glDisableVertexAttribArrayARB*(index: GLuint){.stdcall, importc, ogl.}
proc glProgramStringARB*(target: GLenum, format: GLenum, length: GLsizei, 
                         string: PGLvoid){.stdcall, importc, ogl.}
proc glBindProgramARB*(target: GLenum, prog: GLuint){.stdcall, importc, ogl.}
proc glDeleteProgramsARB*(n: GLsizei, programs: PGLuint){.stdcall, importc, ogl.}
proc glGenProgramsARB*(n: GLsizei, programs: PGLuint){.stdcall, importc, ogl.}
proc glProgramEnvParameter4dARB*(target: GLenum, index: GLuint, x: GLdouble, 
                                 y: GLdouble, z: GLdouble, w: GLdouble){.stdcall, importc, ogl.}
proc glProgramEnvParameter4dvARB*(target: GLenum, index: GLuint, 
                                  params: PGLdouble){.stdcall, importc, ogl.}
proc glProgramEnvParameter4fARB*(target: GLenum, index: GLuint, x: GLfloat, 
                                 y: GLfloat, z: GLfloat, w: GLfloat){.stdcall, importc, ogl.}
proc glProgramEnvParameter4fvARB*(target: GLenum, index: GLuint, 
                                  params: PGLfloat){.stdcall, importc, ogl.}
proc glProgramLocalParameter4dARB*(target: GLenum, index: GLuint, x: GLdouble, 
                                   y: GLdouble, z: GLdouble, w: GLdouble){.
    stdcall, importc, ogl.}
proc glProgramLocalParameter4dvARB*(target: GLenum, index: GLuint, 
                                    params: PGLdouble){.stdcall, importc, ogl.}
proc glProgramLocalParameter4fARB*(target: GLenum, index: GLuint, x: GLfloat, 
                                   y: GLfloat, z: GLfloat, w: GLfloat){.stdcall, importc, ogl.}
proc glProgramLocalParameter4fvARB*(target: GLenum, index: GLuint, 
                                    params: PGLfloat){.stdcall, importc, ogl.}
proc glGetProgramEnvParameterdvARB*(target: GLenum, index: GLuint, 
                                    params: PGLdouble){.stdcall, importc, ogl.}
proc glGetProgramEnvParameterfvARB*(target: GLenum, index: GLuint, 
                                    params: PGLfloat){.stdcall, importc, ogl.}
proc glGetProgramLocalParameterdvARB*(target: GLenum, index: GLuint, 
                                      params: PGLdouble){.stdcall, importc, ogl.}
proc glGetProgramLocalParameterfvARB*(target: GLenum, index: GLuint, 
                                      params: PGLfloat){.stdcall, importc, ogl.}
proc glGetProgramivARB*(target: GLenum, pname: GLenum, params: PGLint){.stdcall, importc, ogl.}
proc glGetProgramStringARB*(target: GLenum, pname: GLenum, string: PGLvoid){.
    stdcall, importc, ogl.}
proc glGetVertexAttribdvARB*(index: GLuint, pname: GLenum, params: PGLdouble){.
    stdcall, importc, ogl.}
proc glGetVertexAttribfvARB*(index: GLuint, pname: GLenum, params: PGLfloat){.
    stdcall, importc, ogl.}
proc glGetVertexAttribivARB*(index: GLuint, pname: GLenum, params: PGLint){.
    stdcall, importc, ogl.}
proc glGetVertexAttribPointervARB*(index: GLuint, pname: GLenum, 
                                   pointer: PGLvoid){.stdcall, importc, ogl.}
proc glIsProgramARB*(prog: GLuint): GLboolean{.stdcall, importc, ogl.}
  # GL_ARB_window_pos
proc glWindowPos2dARB*(x: GLdouble, y: GLdouble){.stdcall, importc, ogl.}
proc glWindowPos2dvARB*(v: PGLdouble){.stdcall, importc, ogl.}
proc glWindowPos2fARB*(x: GLfloat, y: GLfloat){.stdcall, importc, ogl.}
proc glWindowPos2fvARB*(v: PGLfloat){.stdcall, importc, ogl.}
proc glWindowPos2iARB*(x: GLint, y: GLint){.stdcall, importc, ogl.}
proc glWindowPos2ivARB*(v: PGLint){.stdcall, importc, ogl.}
proc glWindowPos2sARB*(x: GLshort, y: GLshort){.stdcall, importc, ogl.}
proc glWindowPos2svARB*(v: PGLshort){.stdcall, importc, ogl.}
proc glWindowPos3dARB*(x: GLdouble, y: GLdouble, z: GLdouble){.stdcall, importc, ogl.}
proc glWindowPos3dvARB*(v: PGLdouble){.stdcall, importc, ogl.}
proc glWindowPos3fARB*(x: GLfloat, y: GLfloat, z: GLfloat){.stdcall, importc, ogl.}
proc glWindowPos3fvARB*(v: PGLfloat){.stdcall, importc, ogl.}
proc glWindowPos3iARB*(x: GLint, y: GLint, z: GLint){.stdcall, importc, ogl.}
proc glWindowPos3ivARB*(v: PGLint){.stdcall, importc, ogl.}
proc glWindowPos3sARB*(x: GLshort, y: GLshort, z: GLshort){.stdcall, importc, ogl.}
proc glWindowPos3svARB*(v: PGLshort){.stdcall, importc, ogl.}
  # GL_ARB_draw_buffers
proc glDrawBuffersARB*(n: GLsizei, bufs: PGLenum){.stdcall, importc, ogl.}
  # GL_ARB_color_buffer_float
proc glClampColorARB*(target: GLenum, clamp: GLenum){.stdcall, importc, ogl.}
  # GL_ARB_vertex_shader
proc glGetActiveAttribARB*(programobj: GLHandleARB, index: GLuint, 
                           maxLength: GLsizei, len: var GLsizei, 
                           size: var GLint, typ: var GLenum, name: PGLcharARB){.
    stdcall, importc, ogl.}
proc glGetAttribLocationARB*(programObj: GLHandleARB, char: PGLcharARB): GLint{.
    stdcall, importc, ogl.}
proc glBindAttribLocationARB*(programObj: GLHandleARB, index: GLuint, 
                              name: PGLcharARB){.stdcall, importc, ogl.}
  # GL_ARB_shader_objects
proc glDeleteObjectARB*(Obj: GLHandleARB){.stdcall, importc, ogl.}
proc glGetHandleARB*(pname: GLenum): GLHandleARB{.stdcall, importc, ogl.}
proc glDetachObjectARB*(container, attached: GLHandleARB){.stdcall, importc, ogl.}
proc glCreateShaderObjectARB*(shaderType: GLenum): GLHandleARB{.stdcall, importc, ogl.}
proc glShaderSourceARB*(shaderObj: GLHandleARB, count: GLsizei, 
                        string: CstringArray, lengths: PGLint){.stdcall, importc, ogl.}
proc glCompileShaderARB*(shaderObj: GLHandleARB){.stdcall, importc, ogl.}
proc glCreateProgramObjectARB*(): GLHandleARB{.stdcall, importc, ogl.}
proc glAttachObjectARB*(programObj, shaderObj: GLHandleARB){.stdcall, importc, ogl.}
proc glLinkProgramARB*(programObj: GLHandleARB){.stdcall, importc, ogl.}
proc glUseProgramObjectARB*(programObj: GLHandleARB){.stdcall, importc, ogl.}
proc glValidateProgramARB*(programObj: GLHandleARB){.stdcall, importc, ogl.}
proc glUniform1fARB*(location: GLint, v0: GLfloat){.stdcall, importc, ogl.}
proc glUniform2fARB*(location: GLint, v0, v1: GLfloat){.stdcall, importc, ogl.}
proc glUniform3fARB*(location: GLint, v0, v1, v2: GLfloat){.stdcall, importc, ogl.}
proc glUniform4fARB*(location: GLint, v0, v1, v2, v3: GLfloat){.stdcall, importc, ogl.}
proc glUniform1iARB*(location: GLint, v0: GLint){.stdcall, importc, ogl.}
proc glUniform2iARB*(location: GLint, v0, v1: GLint){.stdcall, importc, ogl.}
proc glUniform3iARB*(location: GLint, v0, v1, v2: GLint){.stdcall, importc, ogl.}
proc glUniform4iARB*(location: GLint, v0, v1, v2, v3: GLint){.stdcall, importc, ogl.}
proc glUniform1fvARB*(location: GLint, count: GLsizei, value: PGLfloat){.stdcall, importc, ogl.}
proc glUniform2fvARB*(location: GLint, count: GLsizei, value: PGLfloat){.stdcall, importc, ogl.}
proc glUniform3fvARB*(location: GLint, count: GLsizei, value: PGLfloat){.stdcall, importc, ogl.}
proc glUniform4fvARB*(location: GLint, count: GLsizei, value: PGLfloat){.stdcall, importc, ogl.}
proc glUniform1ivARB*(location: GLint, count: GLsizei, value: PGLint){.stdcall, importc, ogl.}
proc glUniform2ivARB*(location: GLint, count: GLsizei, value: PGLint){.stdcall, importc, ogl.}
proc glUniform3ivARB*(location: GLint, count: GLsizei, value: PGLint){.stdcall, importc, ogl.}
proc glUniform4ivARB*(location: GLint, count: GLsizei, value: PGLint){.stdcall, importc, ogl.}
proc glUniformMatrix2fvARB*(location: GLint, count: GLsizei, 
                            transpose: GLboolean, value: PGLfloat){.stdcall, importc, ogl.}
proc glUniformMatrix3fvARB*(location: GLint, count: GLsizei, 
                            transpose: GLboolean, value: PGLfloat){.stdcall, importc, ogl.}
proc glUniformMatrix4fvARB*(location: GLint, count: GLsizei, 
                            transpose: GLboolean, value: PGLfloat){.stdcall, importc, ogl.}
proc glGetObjectParameterfvARB*(Obj: GLHandleARB, pname: GLenum, 
                                params: PGLfloat){.stdcall, importc, ogl.}
proc glGetObjectParameterivARB*(Obj: GLHandleARB, pname: GLenum, params: PGLint){.
    stdcall, importc, ogl.}
proc glGetInfoLogARB*(shaderObj: GLHandleARB, maxLength: GLsizei, 
                      len: var GLint, infoLog: PGLcharARB){.stdcall, importc, ogl.}
proc glGetAttachedObjectsARB*(programobj: GLHandleARB, maxCount: GLsizei, 
                              count: var GLsizei, objects: PGLHandleARB){.
    stdcall, importc, ogl.}
proc glGetUniformLocationARB*(programObj: GLHandleARB, char: PGLcharARB): GLint{.
    stdcall, importc, ogl.}
proc glGetActiveUniformARB*(programobj: GLHandleARB, index: GLuint, 
                            maxLength: GLsizei, len: var GLsizei, 
                            size: var GLint, typ: var GLenum, name: PGLcharARB){.
    stdcall, importc, ogl.}
proc glGetUniformfvARB*(programObj: GLHandleARB, location: GLint, 
                        params: PGLfloat){.stdcall, importc, ogl.}
proc glGetUniformivARB*(programObj: GLHandleARB, location: GLint, params: PGLint){.
    stdcall, importc, ogl.}
proc glGetShaderSourceARB*(shader: GLHandleARB, maxLength: GLsizei, 
                           len: var GLsizei, source: PGLcharARB){.stdcall, importc, ogl.}
  # GL_ARB_Occlusion_Query
proc glGenQueriesARB*(n: GLsizei, ids: PGLuint){.stdcall, importc, ogl.}
proc glDeleteQueriesARB*(n: GLsizei, ids: PGLuint){.stdcall, importc, ogl.}
proc glIsQueryARB*(id: GLuint): Bool{.stdcall, importc, ogl.}
proc glBeginQueryARB*(target: GLenum, id: GLuint){.stdcall, importc, ogl.}
proc glEndQueryARB*(target: GLenum){.stdcall, importc, ogl.}
proc glGetQueryivARB*(target, pname: GLenum, params: PGLint){.stdcall, importc, ogl.}
proc glGetQueryObjectivARB*(id: GLuint, pname: GLenum, params: PGLint){.stdcall, importc, ogl.}
proc glGetQueryObjectuivARB*(id: GLuint, pname: GLenum, params: PGLuint){.
    stdcall, importc, ogl.}
  # GL_ARB_draw_instanced
proc glDrawArraysInstancedARB*(mode: GLenum, first: GLint, count: GLsizei, 
                               primcount: GLsizei){.stdcall, importc, ogl.}
proc glDrawElementsInstancedARB*(mode: GLenum, count: GLsizei, typ: GLenum, 
                                 indices: PGLvoid, primcount: GLsizei){.stdcall, importc, ogl.}
  # GL_ARB_framebuffer_object
proc glIsRenderbuffer*(renderbuffer: GLuint): GLboolean{.stdcall, importc, ogl.}
proc glBindRenderbuffer*(target: GLenum, renderbuffer: GLuint){.stdcall, importc, ogl.}
proc glDeleteRenderbuffers*(n: GLsizei, renderbuffers: PGLuint){.stdcall, importc, ogl.}
proc glGenRenderbuffers*(n: GLsizei, renderbuffers: PGLuint){.stdcall, importc, ogl.}
proc glRenderbufferStorage*(target: GLenum, internalformat: GLenum, 
                            width: GLsizei, height: GLsizei){.stdcall, importc, ogl.}
proc glGetRenderbufferParameteriv*(target: GLenum, pname: GLenum, params: PGLint){.
    stdcall, importc, ogl.}
proc glIsFramebuffer*(framebuffer: GLuint): GLboolean{.stdcall, importc, ogl.}
proc glBindFramebuffer*(target: GLenum, framebuffer: GLuint){.stdcall, importc, ogl.}
proc glDeleteFramebuffers*(n: GLsizei, framebuffers: PGLuint){.stdcall, importc, ogl.}
proc glGenFramebuffers*(n: GLsizei, framebuffers: PGLuint){.stdcall, importc, ogl.}
proc glCheckFramebufferStatus*(target: GLenum): GLenum{.stdcall, importc, ogl.}
proc glFramebufferTexture1D*(target: GLenum, attachment: GLenum, 
                             textarget: GLenum, texture: GLuint, level: GLint){.
    stdcall, importc, ogl.}
proc glFramebufferTexture2D*(target: GLenum, attachment: GLenum, 
                             textarget: GLenum, texture: GLuint, level: GLint){.
    stdcall, importc, ogl.}
proc glFramebufferTexture3D*(target: GLenum, attachment: GLenum, 
                             textarget: GLenum, texture: GLuint, level: GLint, 
                             zoffset: GLint){.stdcall, importc, ogl.}
proc glFramebufferRenderbuffer*(target: GLenum, attachment: GLenum, 
                                renderbuffertarget: GLenum, renderbuffer: GLuint){.
    stdcall, importc, ogl.}
proc glGetFramebufferAttachmentParameteriv*(target: GLenum, attachment: GLenum, 
    pname: GLenum, params: PGLint){.stdcall, importc, ogl.}
proc glGenerateMipmap*(target: GLenum){.stdcall, importc, ogl.}
proc glBlitFramebuffer*(srcX0: GLint, srcY0: GLint, srcX1: GLint, srcY1: GLint, 
                        dstX0: GLint, dstY0: GLint, dstX1: GLint, dstY1: GLint, 
                        mask: GLbitfield, filter: GLenum){.stdcall, importc, ogl.}
proc glRenderbufferStorageMultisample*(target: GLenum, samples: GLsizei, 
                                       internalformat: GLenum, width: GLsizei, 
                                       height: GLsizei){.stdcall, importc, ogl.}
proc glFramebufferTextureLayer*(target: GLenum, attachment: GLenum, 
                                texture: GLuint, level: GLint, layer: GLint){.
    stdcall, importc, ogl.}
  # GL_ARB_geometry_shader4
proc glProgramParameteriARB*(prog: GLuint, pname: GLenum, value: GLint){.stdcall, importc, ogl.}
proc glFramebufferTextureARB*(target: GLenum, attachment: GLenum, 
                              texture: GLuint, level: GLint){.stdcall, importc, ogl.}
proc glFramebufferTextureLayerARB*(target: GLenum, attachment: GLenum, 
                                   texture: GLuint, level: GLint, layer: GLint){.
    stdcall, importc, ogl.}
proc glFramebufferTextureFaceARB*(target: GLenum, attachment: GLenum, 
                                  texture: GLuint, level: GLint, face: GLenum){.
    stdcall, importc, ogl.}
  # GL_ARB_instanced_arrays
proc glVertexAttribDivisorARB*(index: GLuint, divisor: GLuint){.stdcall, importc, ogl.}
  # GL_ARB_map_buffer_range
proc glMapBufferRange*(target: GLenum, offset: GLintptr, len: GLsizeiptr, 
                       access: GLbitfield): PGLvoid{.stdcall, importc, ogl.}
proc glFlushMappedBufferRange*(target: GLenum, offset: GLintptr, len: GLsizeiptr){.
    stdcall, importc, ogl.}
  # GL_ARB_texture_buffer_object
proc glTexBufferARB*(target: GLenum, internalformat: GLenum, buffer: GLuint){.
    stdcall, importc, ogl.}
  # GL_ARB_vertex_array_object
proc glBindVertexArray*(arr: GLuint){.stdcall, importc, ogl.}
proc glDeleteVertexArrays*(n: GLsizei, arrays: PGLuint){.stdcall, importc, ogl.}
proc glGenVertexArrays*(n: GLsizei, arrays: PGLuint){.stdcall, importc, ogl.}
proc glIsVertexArray*(arr: GLuint): GLboolean{.stdcall, importc, ogl.}
  # GL_ARB_uniform_buffer_object
proc glGetUniformIndices*(prog: GLuint, uniformCount: GLsizei, 
                          uniformNames: CstringArray, uniformIndices: PGLuint){.
    stdcall, importc, ogl.}
proc glGetActiveUniformsiv*(prog: GLuint, uniformCount: GLsizei, 
                            uniformIndices: PGLuint, pname: GLenum, 
                            params: PGLint){.stdcall, importc, ogl.}
proc glGetActiveUniformName*(prog: GLuint, uniformIndex: GLuint, 
                             bufSize: GLsizei, len: PGLsizei, 
                             uniformName: PGLchar){.stdcall, importc, ogl.}
proc glGetUniformBlockIndex*(prog: GLuint, uniformBlockName: PGLchar): GLuint{.
    stdcall, importc, ogl.}
proc glGetActiveUniformBlockiv*(prog: GLuint, uniformBlockIndex: GLuint, 
                                pname: GLenum, params: PGLint){.stdcall, importc, ogl.}
proc glGetActiveUniformBlockName*(prog: GLuint, uniformBlockIndex: GLuint, 
                                  bufSize: GLsizei, len: PGLsizei, 
                                  uniformBlockName: PGLchar){.stdcall, importc, ogl.}
proc glUniformBlockBinding*(prog: GLuint, uniformBlockIndex: GLuint, 
                            uniformBlockBinding: GLuint){.stdcall, importc, ogl.}
  # GL_ARB_copy_buffer
proc glCopyBufferSubData*(readTarget: GLenum, writeTarget: GLenum, 
                          readOffset: GLintptr, writeOffset: GLintptr, 
                          size: GLsizeiptr){.stdcall, importc, ogl.}
  # GL_ARB_draw_elements_base_vertex
proc glDrawElementsBaseVertex*(mode: GLenum, count: GLsizei, typ: GLenum, 
                               indices: PGLvoid, basevertex: GLint){.stdcall, importc, ogl.}
proc glDrawRangeElementsBaseVertex*(mode: GLenum, start: GLuint, ending: GLuint, 
                                    count: GLsizei, typ: GLenum, 
                                    indices: PGLvoid, basevertex: GLint){.
    stdcall, importc, ogl.}
proc glDrawElementsInstancedBaseVertex*(mode: GLenum, count: GLsizei, 
                                        typ: GLenum, indices: PGLvoid, 
                                        primcount: GLsizei, basevertex: GLint){.
    stdcall, importc, ogl.}
proc glMultiDrawElementsBaseVertex*(mode: GLenum, count: PGLsizei, typ: GLenum, 
                                    indices: PPGLvoid, primcount: GLsizei, 
                                    basevertex: PGLint){.stdcall, importc, ogl.}
  # GL_ARB_provoking_vertex
proc glProvokingVertex*(mode: GLenum){.stdcall, importc, ogl.}
  # GL_ARB_sync
proc glFenceSync*(condition: GLenum, flags: GLbitfield): GLsync{.stdcall, importc, ogl.}
proc glIsSync*(sync: GLsync): GLboolean{.stdcall, importc, ogl.}
proc glDeleteSync*(sync: GLsync){.stdcall, importc, ogl.}
proc glClientWaitSync*(sync: GLsync, flags: GLbitfield, timeout: GLuint64): GLenum{.
    stdcall, importc, ogl.}
proc glWaitSync*(sync: GLsync, flags: GLbitfield, timeout: GLuint64){.stdcall, importc, ogl.}
proc glGetInteger64v*(pname: GLenum, params: PGLint64){.stdcall, importc, ogl.}
proc glGetSynciv*(sync: GLsync, pname: GLenum, butSize: GLsizei, len: PGLsizei, 
                  values: PGLint){.stdcall, importc, ogl.}
  # GL_ARB_texture_multisample
proc glTexImage2DMultisample*(target: GLenum, samples: GLsizei, 
                              internalformat: GLint, width: GLsizei, 
                              height: GLsizei, fixedsamplelocations: GLboolean){.
    stdcall, importc, ogl.}
proc glTexImage3DMultisample*(target: GLenum, samples: GLsizei, 
                              internalformat: GLint, width: GLsizei, 
                              height: GLsizei, depth: GLsizei, 
                              fixedsamplelocations: GLboolean){.stdcall, importc, ogl.}
proc glGetMultisamplefv*(pname: GLenum, index: GLuint, val: PGLfloat){.stdcall, importc, ogl.}
proc glSampleMaski*(index: GLuint, mask: GLbitfield){.stdcall, importc, ogl.}
  # GL_ARB_draw_buffers_blend
proc glBlendEquationiARB*(buf: GLuint, mode: GLenum){.stdcall, importc, ogl.}
proc glBlendEquationSeparateiARB*(buf: GLuint, modeRGB: GLenum, 
                                  modeAlpha: GLenum){.stdcall, importc, ogl.}
proc glBlendFunciARB*(buf: GLuint, src: GLenum, dst: GLenum){.stdcall, importc, ogl.}
proc glBlendFuncSeparateiARB*(buf: GLuint, srcRGB: GLenum, dstRGB: GLenum, 
                              srcAlpha: GLenum, dstAlpha: GLenum){.stdcall, importc, ogl.}
  # GL_ARB_sample_shading
proc glMinSampleShadingARB*(value: GLclampf){.stdcall, importc, ogl.}
  # GL_ARB_shading_language_include
proc glNamedStringARB*(typ: GLenum, namelen: GLint, name: PGLchar, 
                       stringlen: GLint, string: PGLchar){.stdcall, importc, ogl.}
proc glDeleteNamedStringARB*(namelen: GLint, name: PGLchar){.stdcall, importc, ogl.}
proc glCompileShaderIncludeARB*(shader: GLuint, count: GLsizei, path: PPGLchar, 
                                len: PGLint){.stdcall, importc, ogl.}
proc glIsNamedStringARB*(namelen: GLint, name: PGLchar): GLboolean{.stdcall, importc, ogl.}
proc glGetNamedStringARB*(namelen: GLint, name: PGLchar, bufSize: GLsizei, 
                          stringlen: GLint, string: PGLchar){.stdcall, importc, ogl.}
proc glGetNamedStringivARB*(namelen: GLint, name: PGLchar, pname: GLenum, 
                            params: PGLint){.stdcall, importc, ogl.}
  # GL_ARB_blend_func_extended
proc glBindFragDataLocationIndexed*(prog: GLuint, colorNumber: GLuint, 
                                    index: GLuint, name: PGLchar){.stdcall, importc, ogl.}
proc glGetFragDataIndex*(prog: GLuint, name: PGLchar): GLint{.stdcall, importc, ogl.}
  # GL_ARB_sampler_objects
proc glGenSamplers*(count: GLsizei, samplers: PGLuint){.stdcall, importc, ogl.}
proc glDeleteSamplers*(count: GLsizei, samplers: PGLuint){.stdcall, importc, ogl.}
proc glIsSampler*(sampler: GLuint): GLboolean{.stdcall, importc, ogl.}
proc glBindSampler*(theUnit: GLuint, sampler: GLuint){.stdcall, importc, ogl.}
proc glSamplerParameteri*(sampler: GLuint, pname: GLenum, param: GLint){.stdcall, importc, ogl.}
proc glSamplerParameteriv*(sampler: GLuint, pname: GLenum, param: PGLint){.
    stdcall, importc, ogl.}
proc glSamplerParameterf*(sampler: GLuint, pname: GLenum, param: GLfloat){.
    stdcall, importc, ogl.}
proc glSamplerParameterfv*(sampler: GLuint, pname: GLenum, param: PGLfloat){.
    stdcall, importc, ogl.}
proc glSamplerParameterIiv*(sampler: GLuint, pname: GLenum, param: PGLint){.
    stdcall, importc, ogl.}
proc glSamplerParameterIuiv*(sampler: GLuint, pname: GLenum, param: PGLuint){.
    stdcall, importc, ogl.}
proc glGetSamplerParameteriv*(sampler: GLuint, pname: GLenum, params: PGLint){.
    stdcall, importc, ogl.}
proc glGetSamplerParameterIiv*(sampler: GLuint, pname: GLenum, params: PGLint){.
    stdcall, importc, ogl.}
proc glGetSamplerParameterfv*(sampler: GLuint, pname: GLenum, params: PGLfloat){.
    stdcall, importc, ogl.}
proc glGetSamplerParameterIuiv*(sampler: GLuint, pname: GLenum, params: PGLuint){.
    stdcall, importc, ogl.}
  # GL_ARB_timer_query
proc glQueryCounter*(id: GLuint, target: GLenum){.stdcall, importc, ogl.}
proc glGetQueryObjecti64v*(id: GLuint, pname: GLenum, params: PGLint64){.stdcall, importc, ogl.}
proc glGetQueryObjectui64v*(id: GLuint, pname: GLenum, params: PGLuint64){.
    stdcall, importc, ogl.}
  # GL_ARB_vertextyp_2_10_10_10_rev
proc glVertexP2ui*(typ: GLenum, value: GLuint){.stdcall, importc, ogl.}
proc glVertexP2uiv*(typ: GLenum, value: PGLuint){.stdcall, importc, ogl.}
proc glVertexP3ui*(typ: GLenum, value: GLuint){.stdcall, importc, ogl.}
proc glVertexP3uiv*(typ: GLenum, value: PGLuint){.stdcall, importc, ogl.}
proc glVertexP4ui*(typ: GLenum, value: GLuint){.stdcall, importc, ogl.}
proc glVertexP4uiv*(typ: GLenum, value: PGLuint){.stdcall, importc, ogl.}
proc glTexCoordP1ui*(typ: GLenum, coords: GLuint){.stdcall, importc, ogl.}
proc glTexCoordP1uiv*(typ: GLenum, coords: PGLuint){.stdcall, importc, ogl.}
proc glTexCoordP2ui*(typ: GLenum, coords: GLuint){.stdcall, importc, ogl.}
proc glTexCoordP2uiv*(typ: GLenum, coords: PGLuint){.stdcall, importc, ogl.}
proc glTexCoordP3ui*(typ: GLenum, coords: GLuint){.stdcall, importc, ogl.}
proc glTexCoordP3uiv*(typ: GLenum, coords: PGLuint){.stdcall, importc, ogl.}
proc glTexCoordP4ui*(typ: GLenum, coords: GLuint){.stdcall, importc, ogl.}
proc glTexCoordP4uiv*(typ: GLenum, coords: PGLuint){.stdcall, importc, ogl.}
proc glMultiTexCoordP1ui*(texture: GLenum, typ: GLenum, coords: GLuint){.stdcall, importc, ogl.}
proc glMultiTexCoordP1uiv*(texture: GLenum, typ: GLenum, coords: GLuint){.
    stdcall, importc, ogl.}
proc glMultiTexCoordP2ui*(texture: GLenum, typ: GLenum, coords: GLuint){.stdcall, importc, ogl.}
proc glMultiTexCoordP2uiv*(texture: GLenum, typ: GLenum, coords: PGLuint){.
    stdcall, importc, ogl.}
proc glMultiTexCoordP3ui*(texture: GLenum, typ: GLenum, coords: GLuint){.stdcall, importc, ogl.}
proc glMultiTexCoordP3uiv*(texture: GLenum, typ: GLenum, coords: PGLuint){.
    stdcall, importc, ogl.}
proc glMultiTexCoordP4ui*(texture: GLenum, typ: GLenum, coords: GLuint){.stdcall, importc, ogl.}
proc glMultiTexCoordP4uiv*(texture: GLenum, typ: GLenum, coords: PGLuint){.
    stdcall, importc, ogl.}
proc glNormalP3ui*(typ: GLenum, coords: GLuint){.stdcall, importc, ogl.}
proc glNormalP3uiv*(typ: GLenum, coords: PGLuint){.stdcall, importc, ogl.}
proc glColorP3ui*(typ: GLenum, color: GLuint){.stdcall, importc, ogl.}
proc glColorP3uiv*(typ: GLenum, color: PGLuint){.stdcall, importc, ogl.}
proc glColorP4ui*(typ: GLenum, color: GLuint){.stdcall, importc, ogl.}
proc glColorP4uiv*(typ: GLenum, color: GLuint){.stdcall, importc, ogl.}
proc glSecondaryColorP3ui*(typ: GLenum, color: GLuint){.stdcall, importc, ogl.}
proc glSecondaryColorP3uiv*(typ: GLenum, color: PGLuint){.stdcall, importc, ogl.}
proc glVertexAttribP1ui*(index: GLuint, typ: GLenum, normalized: GLboolean, 
                         value: GLuint){.stdcall, importc, ogl.}
proc glVertexAttribP1uiv*(index: GLuint, typ: GLenum, normalized: GLboolean, 
                          value: PGLuint){.stdcall, importc, ogl.}
proc glVertexAttribP2ui*(index: GLuint, typ: GLenum, normalized: GLboolean, 
                         value: GLuint){.stdcall, importc, ogl.}
proc glVertexAttribP2uiv*(index: GLuint, typ: GLenum, normalized: GLboolean, 
                          value: PGLuint){.stdcall, importc, ogl.}
proc glVertexAttribP3ui*(index: GLuint, typ: GLenum, normalized: GLboolean, 
                         value: GLuint){.stdcall, importc, ogl.}
proc glVertexAttribP3uiv*(index: GLuint, typ: GLenum, normalized: GLboolean, 
                          value: PGLuint){.stdcall, importc, ogl.}
proc glVertexAttribP4ui*(index: GLuint, typ: GLenum, normalized: GLboolean, 
                         value: GLuint){.stdcall, importc, ogl.}
proc glVertexAttribP4uiv*(index: GLuint, typ: GLenum, normalized: GLboolean, 
                          value: PGLuint){.stdcall, importc, ogl.}
  # GL_ARB_draw_indirect
proc glDrawArraysIndirect*(mode: GLenum, indirect: PGLvoid){.stdcall, importc, ogl.}
proc glDrawElementsIndirect*(mode: GLenum, typ: GLenum, indirect: PGLvoid){.
    stdcall, importc, ogl.}
  # GL_ARB_gpu_shader_fp64
proc glUniform1d*(location: GLint, x: GLdouble){.stdcall, importc, ogl.}
proc glUniform2d*(location: GLint, x: GLdouble, y: GLdouble){.stdcall, importc, ogl.}
proc glUniform3d*(location: GLint, x: GLdouble, y: GLdouble, z: GLdouble){.
    stdcall, importc, ogl.}
proc glUniform4d*(location: GLint, x: GLdouble, y: GLdouble, z: GLdouble, 
                  w: GLdouble){.stdcall, importc, ogl.}
proc glUniform1dv*(location: GLint, count: GLsizei, value: PGLdouble){.stdcall, importc, ogl.}
proc glUniform2dv*(location: GLint, count: GLsizei, value: PGLdouble){.stdcall, importc, ogl.}
proc glUniform3dv*(location: GLint, count: GLsizei, value: PGLdouble){.stdcall, importc, ogl.}
proc glUniform4dv*(location: GLint, count: GLsizei, value: PGLdouble){.stdcall, importc, ogl.}
proc glUniformMatrix2dv*(location: GLint, count: GLsizei, transpose: GLboolean, 
                         value: PGLdouble){.stdcall, importc, ogl.}
proc glUniformMatrix3dv*(location: GLint, count: GLsizei, transpose: GLboolean, 
                         value: PGLdouble){.stdcall, importc, ogl.}
proc glUniformMatrix4dv*(location: GLint, count: GLsizei, transpose: GLboolean, 
                         value: PGLdouble){.stdcall, importc, ogl.}
proc glUniformMatrix2x3dv*(location: GLint, count: GLsizei, 
                           transpose: GLboolean, value: PGLdouble){.stdcall, importc, ogl.}
proc glUniformMatrix2x4dv*(location: GLint, count: GLsizei, 
                           transpose: GLboolean, value: PGLdouble){.stdcall, importc, ogl.}
proc glUniformMatrix3x2dv*(location: GLint, count: GLsizei, 
                           transpose: GLboolean, value: PGLdouble){.stdcall, importc, ogl.}
proc glUniformMatrix3x4dv*(location: GLint, count: GLsizei, 
                           transpose: GLboolean, value: PGLdouble){.stdcall, importc, ogl.}
proc glUniformMatrix4x2dv*(location: GLint, count: GLsizei, 
                           transpose: GLboolean, value: PGLdouble){.stdcall, importc, ogl.}
proc glUniformMatrix4x3dv*(location: GLint, count: GLsizei, 
                           transpose: GLboolean, value: PGLdouble){.stdcall, importc, ogl.}
proc glGetUniformdv*(prog: GLuint, location: GLint, params: PGLdouble){.stdcall, importc, ogl.}
  # GL_ARB_shader_subroutine
proc glGetSubroutineUniformLocation*(prog: GLuint, shadertype: GLenum, 
                                     name: PGLchar): GLint{.stdcall, importc, ogl.}
proc glGetSubroutineIndex*(prog: GLuint, shadertype: GLenum, name: PGLchar): GLuint{.
    stdcall, importc, ogl.}
proc glGetActiveSubroutineUniformiv*(prog: GLuint, shadertype: GLenum, 
                                     index: GLuint, pname: GLenum, 
                                     values: PGLint){.stdcall, importc, ogl.}
proc glGetActiveSubroutineUniformName*(prog: GLuint, shadertype: GLenum, 
                                       index: GLuint, bufsize: GLsizei, 
                                       len: PGLsizei, name: PGLchar){.stdcall, importc, ogl.}
proc glGetActiveSubroutineName*(prog: GLuint, shadertype: GLenum, index: GLuint, 
                                bufsize: GLsizei, len: PGLsizei, name: PGLchar){.
    stdcall, importc, ogl.}
proc glUniformSubroutinesuiv*(shadertype: GLenum, count: GLsizei, 
                              indices: PGLuint){.stdcall, importc, ogl.}
proc glGetUniformSubroutineuiv*(shadertype: GLenum, location: GLint, 
                                params: PGLuint){.stdcall, importc, ogl.}
proc glGetProgramStageiv*(prog: GLuint, shadertype: GLenum, pname: GLenum, 
                          values: PGLint){.stdcall, importc, ogl.}
  # GL_ARB_tessellation_shader
proc glPatchParameteri*(pname: GLenum, value: GLint){.stdcall, importc, ogl.}
proc glPatchParameterfv*(pname: GLenum, values: PGLfloat){.stdcall, importc, ogl.}
  # GL_ARB_transform_feedback2
proc glBindTransformFeedback*(target: GLenum, id: GLuint){.stdcall, importc, ogl.}
proc glDeleteTransformFeedbacks*(n: GLsizei, ids: PGLuint){.stdcall, importc, ogl.}
proc glGenTransformFeedbacks*(n: GLsizei, ids: PGLuint){.stdcall, importc, ogl.}
proc glIsTransformFeedback*(id: GLuint): GLboolean{.stdcall, importc, ogl.}
proc glPauseTransformFeedback*(){.stdcall, importc, ogl.}
proc glResumeTransformFeedback*(){.stdcall, importc, ogl.}
proc glDrawTransformFeedback*(mode: GLenum, id: GLuint){.stdcall, importc, ogl.}
  # GL_ARB_transform_feedback3
proc glDrawTransformFeedbackStream*(mode: GLenum, id: GLuint, stream: GLuint){.
    stdcall, importc, ogl.}
proc glBeginQueryIndexed*(target: GLenum, index: GLuint, id: GLuint){.stdcall, importc, ogl.}
proc glEndQueryIndexed*(target: GLenum, index: GLuint){.stdcall, importc, ogl.}
proc glGetQueryIndexediv*(target: GLenum, index: GLuint, pname: GLenum, 
                          params: PGLint){.stdcall, importc, ogl.}
  # GL_ARB_ES2_compatibility
proc glReleaseShaderCompiler*(){.stdcall, importc, ogl.}
proc glShaderBinary*(count: GLsizei, shaders: PGLuint, binaryformat: GLenum, 
                     binary: PGLvoid, len: GLsizei){.stdcall, importc, ogl.}
proc glGetShaderPrecisionFormat*(shadertype: GLenum, precisiontype: GLenum, 
                                 range: PGLint, precision: PGLint){.stdcall, importc, ogl.}
proc glDepthRangef*(n: GLclampf, f: GLclampf){.stdcall, importc, ogl.}
proc glClearDepthf*(d: GLclampf){.stdcall, importc, ogl.}
  # GL_ARB_get_prog_binary
proc glGetProgramBinary*(prog: GLuint, bufSize: GLsizei, len: PGLsizei, 
                         binaryFormat: PGLenum, binary: PGLvoid){.stdcall, importc, ogl.}
proc glProgramBinary*(prog: GLuint, binaryFormat: GLenum, binary: PGLvoid, 
                      len: GLsizei){.stdcall, importc, ogl.}
proc glProgramParameteri*(prog: GLuint, pname: GLenum, value: GLint){.stdcall, importc, ogl.}
  # GL_ARB_separate_shader_objects
proc glUseProgramStages*(pipeline: GLuint, stages: GLbitfield, prog: GLuint){.
    stdcall, importc, ogl.}
proc glActiveShaderProgram*(pipeline: GLuint, prog: GLuint){.stdcall, importc, ogl.}
proc glCreateShaderProgramv*(typ: GLenum, count: GLsizei, strings: CstringArray): GLuint{.
    stdcall, importc, ogl.}
proc glBindProgramPipeline*(pipeline: GLuint){.stdcall, importc, ogl.}
proc glDeleteProgramPipelines*(n: GLsizei, pipelines: PGLuint){.stdcall, importc, ogl.}
proc glGenProgramPipelines*(n: GLsizei, pipelines: PGLuint){.stdcall, importc, ogl.}
proc glIsProgramPipeline*(pipeline: GLuint): GLboolean{.stdcall, importc, ogl.}
proc glGetProgramPipelineiv*(pipeline: GLuint, pname: GLenum, params: PGLint){.
    stdcall, importc, ogl.}
proc glProgramUniform1i*(prog: GLuint, location: GLint, v0: GLint){.stdcall, importc, ogl.}
proc glProgramUniform1iv*(prog: GLuint, location: GLint, count: GLsizei, 
                          value: PGLint){.stdcall, importc, ogl.}
proc glProgramUniform1f*(prog: GLuint, location: GLint, v0: GLfloat){.stdcall, importc, ogl.}
proc glProgramUniform1fv*(prog: GLuint, location: GLint, count: GLsizei, 
                          value: PGLfloat){.stdcall, importc, ogl.}
proc glProgramUniform1d*(prog: GLuint, location: GLint, v0: GLdouble){.stdcall, importc, ogl.}
proc glProgramUniform1dv*(prog: GLuint, location: GLint, count: GLsizei, 
                          value: PGLdouble){.stdcall, importc, ogl.}
proc glProgramUniform1ui*(prog: GLuint, location: GLint, v0: GLuint){.stdcall, importc, ogl.}
proc glProgramUniform1uiv*(prog: GLuint, location: GLint, count: GLsizei, 
                           value: PGLuint){.stdcall, importc, ogl.}
proc glProgramUniform2i*(prog: GLuint, location: GLint, v0: GLint, v1: GLint){.
    stdcall, importc, ogl.}
proc glProgramUniform2iv*(prog: GLuint, location: GLint, count: GLsizei, 
                          value: PGLint){.stdcall, importc, ogl.}
proc glProgramUniform2f*(prog: GLuint, location: GLint, v0: GLfloat, v1: GLfloat){.
    stdcall, importc, ogl.}
proc glProgramUniform2fv*(prog: GLuint, location: GLint, count: GLsizei, 
                          value: PGLfloat){.stdcall, importc, ogl.}
proc glProgramUniform2d*(prog: GLuint, location: GLint, v0: GLdouble, 
                         v1: GLdouble){.stdcall, importc, ogl.}
proc glProgramUniform2dv*(prog: GLuint, location: GLint, count: GLsizei, 
                          value: PGLdouble){.stdcall, importc, ogl.}
proc glProgramUniform2ui*(prog: GLuint, location: GLint, v0: GLuint, v1: GLuint){.
    stdcall, importc, ogl.}
proc glProgramUniform2uiv*(prog: GLuint, location: GLint, count: GLsizei, 
                           value: PGLuint){.stdcall, importc, ogl.}
proc glProgramUniform3i*(prog: GLuint, location: GLint, v0: GLint, v1: GLint, 
                         v2: GLint){.stdcall, importc, ogl.}
proc glProgramUniform3iv*(prog: GLuint, location: GLint, count: GLsizei, 
                          value: PGLint){.stdcall, importc, ogl.}
proc glProgramUniform3f*(prog: GLuint, location: GLint, v0: GLfloat, 
                         v1: GLfloat, v2: GLfloat){.stdcall, importc, ogl.}
proc glProgramUniform3fv*(prog: GLuint, location: GLint, count: GLsizei, 
                          value: PGLfloat){.stdcall, importc, ogl.}
proc glProgramUniform3d*(prog: GLuint, location: GLint, v0: GLdouble, 
                         v1: GLdouble, v2: GLdouble){.stdcall, importc, ogl.}
proc glProgramUniform3dv*(prog: GLuint, location: GLint, count: GLsizei, 
                          value: PGLdouble){.stdcall, importc, ogl.}
proc glProgramUniform3ui*(prog: GLuint, location: GLint, v0: GLuint, v1: GLuint, 
                          v2: GLuint){.stdcall, importc, ogl.}
proc glProgramUniform3uiv*(prog: GLuint, location: GLint, count: GLsizei, 
                           value: PGLuint){.stdcall, importc, ogl.}
proc glProgramUniform4i*(prog: GLuint, location: GLint, v0: GLint, v1: GLint, 
                         v2: GLint, v3: GLint){.stdcall, importc, ogl.}
proc glProgramUniform4iv*(prog: GLuint, location: GLint, count: GLsizei, 
                          value: PGLint){.stdcall, importc, ogl.}
proc glProgramUniform4f*(prog: GLuint, location: GLint, v0: GLfloat, 
                         v1: GLfloat, v2: GLfloat, v3: GLfloat){.stdcall, importc, ogl.}
proc glProgramUniform4fv*(prog: GLuint, location: GLint, count: GLsizei, 
                          value: PGLfloat){.stdcall, importc, ogl.}
proc glProgramUniform4d*(prog: GLuint, location: GLint, v0: GLdouble, 
                         v1: GLdouble, v2: GLdouble, v3: GLdouble){.stdcall, importc, ogl.}
proc glProgramUniform4dv*(prog: GLuint, location: GLint, count: GLsizei, 
                          value: PGLdouble){.stdcall, importc, ogl.}
proc glProgramUniform4ui*(prog: GLuint, location: GLint, v0: GLuint, v1: GLuint, 
                          v2: GLuint, v3: GLuint){.stdcall, importc, ogl.}
proc glProgramUniform4uiv*(prog: GLuint, location: GLint, count: GLsizei, 
                           value: PGLuint){.stdcall, importc, ogl.}
proc glProgramUniformMatrix2fv*(prog: GLuint, location: GLint, count: GLsizei, 
                                transpose: GLboolean, value: PGLfloat){.stdcall, importc, ogl.}
proc glProgramUniformMatrix3fv*(prog: GLuint, location: GLint, count: GLsizei, 
                                transpose: GLboolean, value: PGLfloat){.stdcall, importc, ogl.}
proc glProgramUniformMatrix4fv*(prog: GLuint, location: GLint, count: GLsizei, 
                                transpose: GLboolean, value: PGLfloat){.stdcall, importc, ogl.}
proc glProgramUniformMatrix2dv*(prog: GLuint, location: GLint, count: GLsizei, 
                                transpose: GLboolean, value: PGLdouble){.stdcall, importc, ogl.}
proc glProgramUniformMatrix3dv*(prog: GLuint, location: GLint, count: GLsizei, 
                                transpose: GLboolean, value: PGLdouble){.stdcall, importc, ogl.}
proc glProgramUniformMatrix4dv*(prog: GLuint, location: GLint, count: GLsizei, 
                                transpose: GLboolean, value: PGLdouble){.stdcall, importc, ogl.}
proc glProgramUniformMatrix2x3fv*(prog: GLuint, location: GLint, count: GLsizei, 
                                  transpose: GLboolean, value: PGLfloat){.
    stdcall, importc, ogl.}
proc glProgramUniformMatrix3x2fv*(prog: GLuint, location: GLint, count: GLsizei, 
                                  transpose: GLboolean, value: PGLfloat){.
    stdcall, importc, ogl.}
proc glProgramUniformMatrix2x4fv*(prog: GLuint, location: GLint, count: GLsizei, 
                                  transpose: GLboolean, value: PGLfloat){.
    stdcall, importc, ogl.}
proc glProgramUniformMatrix4x2fv*(prog: GLuint, location: GLint, count: GLsizei, 
                                  transpose: GLboolean, value: PGLfloat){.
    stdcall, importc, ogl.}
proc glProgramUniformMatrix3x4fv*(prog: GLuint, location: GLint, count: GLsizei, 
                                  transpose: GLboolean, value: PGLfloat){.
    stdcall, importc, ogl.}
proc glProgramUniformMatrix4x3fv*(prog: GLuint, location: GLint, count: GLsizei, 
                                  transpose: GLboolean, value: PGLfloat){.
    stdcall, importc, ogl.}
proc glProgramUniformMatrix2x3dv*(prog: GLuint, location: GLint, count: GLsizei, 
                                  transpose: GLboolean, value: PGLdouble){.
    stdcall, importc, ogl.}
proc glProgramUniformMatrix3x2dv*(prog: GLuint, location: GLint, count: GLsizei, 
                                  transpose: GLboolean, value: PGLdouble){.
    stdcall, importc, ogl.}
proc glProgramUniformMatrix2x4dv*(prog: GLuint, location: GLint, count: GLsizei, 
                                  transpose: GLboolean, value: PGLdouble){.
    stdcall, importc, ogl.}
proc glProgramUniformMatrix4x2dv*(prog: GLuint, location: GLint, count: GLsizei, 
                                  transpose: GLboolean, value: PGLdouble){.
    stdcall, importc, ogl.}
proc glProgramUniformMatrix3x4dv*(prog: GLuint, location: GLint, count: GLsizei, 
                                  transpose: GLboolean, value: PGLdouble){.
    stdcall, importc, ogl.}
proc glProgramUniformMatrix4x3dv*(prog: GLuint, location: GLint, count: GLsizei, 
                                  transpose: GLboolean, value: PGLdouble){.
    stdcall, importc, ogl.}
proc glValidateProgramPipeline*(pipeline: GLuint){.stdcall, importc, ogl.}
proc glGetProgramPipelineInfoLog*(pipeline: GLuint, bufSize: GLsizei, 
                                  len: PGLsizei, infoLog: PGLchar){.stdcall, importc, ogl.}
  # GL_ARB_vertex_attrib_64bit
proc glVertexAttribL1d*(index: GLuint, x: GLdouble){.stdcall, importc, ogl.}
proc glVertexAttribL2d*(index: GLuint, x: GLdouble, y: GLdouble){.stdcall, importc, ogl.}
proc glVertexAttribL3d*(index: GLuint, x: GLdouble, y: GLdouble, z: GLdouble){.
    stdcall, importc, ogl.}
proc glVertexAttribL4d*(index: GLuint, x: GLdouble, y: GLdouble, z: GLdouble, 
                        w: GLdouble){.stdcall, importc, ogl.}
proc glVertexAttribL1dv*(index: GLuint, v: PGLdouble){.stdcall, importc, ogl.}
proc glVertexAttribL2dv*(index: GLuint, v: PGLdouble){.stdcall, importc, ogl.}
proc glVertexAttribL3dv*(index: GLuint, v: PGLdouble){.stdcall, importc, ogl.}
proc glVertexAttribL4dv*(index: GLuint, v: PGLdouble){.stdcall, importc, ogl.}
proc glVertexAttribLPointer*(index: GLuint, size: GLint, typ: GLenum, 
                             stride: GLsizei, pointer: PGLvoid){.stdcall, importc, ogl.}
proc glGetVertexAttribLdv*(index: GLuint, pname: GLenum, params: PGLdouble){.
    stdcall, importc, ogl.}
  # GL_ARB_viewport_array
proc glViewportArrayv*(first: GLuint, count: GLsizei, v: PGLfloat){.stdcall, importc, ogl.}
proc glViewportIndexedf*(index: GLuint, x: GLfloat, y: GLfloat, w: GLfloat, 
                         h: GLfloat){.stdcall, importc, ogl.}
proc glViewportIndexedfv*(index: GLuint, v: PGLfloat){.stdcall, importc, ogl.}
proc glScissorArrayv*(first: GLuint, count: GLsizei, v: PGLint){.stdcall, importc, ogl.}
proc glScissorIndexed*(index: GLuint, left: GLint, bottom: GLint, 
                       width: GLsizei, height: GLsizei){.stdcall, importc, ogl.}
proc glScissorIndexedv*(index: GLuint, v: PGLint){.stdcall, importc, ogl.}
proc glDepthRangeArrayv*(first: GLuint, count: GLsizei, v: PGLclampd){.stdcall, importc, ogl.}
proc glDepthRangeIndexed*(index: GLuint, n: GLclampd, f: GLclampd){.stdcall, importc, ogl.}
proc glGetFloati_v*(target: GLenum, index: GLuint, data: PGLfloat){.stdcall, importc, ogl.}
proc glGetDoublei_v*(target: GLenum, index: GLuint, data: PGLdouble){.stdcall, importc, ogl.}
  # GL 4.2
  # GL_ARB_base_instance
proc glDrawArraysInstancedBaseInstance*(mode: GLenum, first: GLint, 
                                        count: GLsizei, primcount: GLsizei, 
                                        baseinstance: GLuint){.stdcall, importc, ogl.}
proc glDrawElementsInstancedBaseInstance*(mode: GLenum, count: GLsizei, 
    typ: GLenum, indices: PGLvoid, primcount: GLsizei, baseinstance: GLuint){.
    stdcall, importc, ogl.}
proc glDrawElementsInstancedBaseVertexBaseInstance*(mode: GLenum, 
    count: GLsizei, typ: GLenum, indices: PGLvoid, primcount: GLsizei, 
    basevertex: GLint, baseinstance: GLuint){.stdcall, importc, ogl.}
  # GL_ARB_transform_feedback_instanced
proc glDrawTransformFeedbackInstanced*(mode: GLenum, id: GLuint, 
                                       primcount: GLsizei){.stdcall, importc, ogl.}
proc glDrawTransformFeedbackStreamInstanced*(mode: GLenum, id: GLuint, 
    stream: GLuint, primcount: GLsizei){.stdcall, importc, ogl.}
  # GL_ARB_internalformat_query
proc glGetInternalformativ*(target: GLenum, internalformat: GLenum, 
                            pname: GLenum, bufSize: GLsizei, params: PGLint){.
    stdcall, importc, ogl.}
  # GL_ARB_shader_atomic_counters
proc glGetActiveAtomicCounterBufferiv*(prog: GLuint, bufferIndex: GLuint, 
                                       pname: GLenum, params: PGLint){.stdcall, importc, ogl.}
  #/ GL_ARB_shader_image_load_store
proc glBindImageTexture*(theUnit: GLuint, texture: GLuint, level: GLint, 
                         layered: GLboolean, layer: GLint, access: GLenum, 
                         format: GLenum){.stdcall, importc, ogl.}
proc glMemoryBarrier*(barriers: GLbitfield){.stdcall, importc, ogl.}
  # GL_ARB_texture_storage
proc glTexStorage1D*(target: GLenum, levels: GLsizei, internalformat: GLenum, 
                     width: GLsizei){.stdcall, importc, ogl.}
proc glTexStorage2D*(target: GLenum, levels: GLsizei, internalformat: GLenum, 
                     width: GLsizei, height: GLsizei){.stdcall, importc, ogl.}
proc glTexStorage3D*(target: GLenum, levels: GLsizei, internalformat: GLenum, 
                     width: GLsizei, height: GLsizei, depth: GLsizei){.stdcall, importc, ogl.}
proc glTextureStorage1DEXT*(texture: GLuint, target: GLenum, levels: GLsizei, 
                            internalformat: GLenum, width: GLsizei){.stdcall, importc, ogl.}
proc glTextureStorage2DEXT*(texture: GLuint, target: GLenum, levels: GLsizei, 
                            internalformat: GLenum, width: GLsizei, 
                            height: GLsizei){.stdcall, importc, ogl.}
proc glTextureStorage3DEXT*(texture: GLuint, target: GLenum, levels: GLsizei, 
                            internalformat: GLenum, width: GLsizei, 
                            height: GLsizei, depth: GLsizei){.stdcall, importc, ogl.}
  #
  # GL_ARB_cl_event
proc glCreateSyncFromCLeventARB*(context: PClContext, event: PClEvent, 
                                 flags: GLbitfield): GLsync{.stdcall, importc, ogl.}
  # GL_ARB_debug_output
proc glDebugMessageControlARB*(source: GLenum, typ: GLenum, severity: GLenum, 
                               count: GLsizei, ids: PGLuint, enabled: GLboolean){.
    stdcall, importc, ogl.}
proc glDebugMessageInsertARB*(source: GLenum, typ: GLenum, id: GLuint, 
                              severity: GLenum, len: GLsizei, buf: PGLchar){.
    stdcall, importc, ogl.}
proc glDebugMessageCallbackARB*(callback: TglDebugProcARB, userParam: PGLvoid){.
    stdcall, importc, ogl.}
proc glGetDebugMessageLogARB*(count: GLuint, bufsize: GLsizei, sources: PGLenum, 
                              types: PGLenum, ids: PGLuint, severities: PGLenum, 
                              lengths: PGLsizei, messageLog: PGLchar): GLuint{.
    stdcall, importc, ogl.}
  # GL_ARB_robustness
proc glGetGraphicsResetStatusARB*(): GLenum{.stdcall, importc, ogl.}
proc glGetnMapdvARB*(target: GLenum, query: GLenum, bufSize: GLsizei, 
                     v: PGLdouble){.stdcall, importc, ogl.}
proc glGetnMapfvARB*(target: GLenum, query: GLenum, bufSize: GLsizei, 
                     v: PGLfloat){.stdcall, importc, ogl.}
proc glGetnMapivARB*(target: GLenum, query: GLenum, bufSize: GLsizei, v: PGLint){.
    stdcall, importc, ogl.}
proc glGetnPixelMapfvARB*(map: GLenum, bufSize: GLsizei, values: PGLfloat){.
    stdcall, importc, ogl.}
proc glGetnPixelMapuivARB*(map: GLenum, bufSize: GLsizei, values: PGLuint){.
    stdcall, importc, ogl.}
proc glGetnPixelMapusvARB*(map: GLenum, bufSize: GLsizei, values: PGLushort){.
    stdcall, importc, ogl.}
proc glGetnPolygonStippleARB*(bufSize: GLsizei, pattern: PGLubyte){.stdcall, importc, ogl.}
proc glGetnColorTableARB*(target: GLenum, format: GLenum, typ: GLenum, 
                          bufSize: GLsizei, table: PGLvoid){.stdcall, importc, ogl.}
proc glGetnConvolutionFilterARB*(target: GLenum, format: GLenum, typ: GLenum, 
                                 bufSize: GLsizei, image: PGLvoid){.stdcall, importc, ogl.}
proc glGetnSeparableFilterARB*(target: GLenum, format: GLenum, typ: GLenum, 
                               rowBufSize: GLsizei, row: PGLvoid, 
                               columnBufSize: GLsizei, column: PGLvoid, 
                               span: PGLvoid){.stdcall, importc, ogl.}
proc glGetnHistogramARB*(target: GLenum, reset: GLboolean, format: GLenum, 
                         typ: GLenum, bufSize: GLsizei, values: PGLvoid){.
    stdcall, importc, ogl.}
proc glGetnMinmaxARB*(target: GLenum, reset: GLboolean, format: GLenum, 
                      typ: GLenum, bufSize: GLsizei, values: PGLvoid){.stdcall, importc, ogl.}
proc glGetnTexImageARB*(target: GLenum, level: GLint, format: GLenum, 
                        typ: GLenum, bufSize: GLsizei, img: PGLvoid){.stdcall, importc, ogl.}
proc glReadnPixelsARB*(x: GLint, y: GLint, width: GLsizei, height: GLsizei, 
                       format: GLenum, typ: GLenum, bufSize: GLsizei, 
                       data: PGLvoid){.stdcall, importc, ogl.}
proc glGetnCompressedTexImageARB*(target: GLenum, lod: GLint, bufSize: GLsizei, 
                                  img: PGLvoid){.stdcall, importc, ogl.}
proc glGetnUniformfvARB*(prog: GLuint, location: GLint, bufSize: GLsizei, 
                         params: PGLfloat){.stdcall, importc, ogl.}
proc glGetnUniformivARB*(prog: GLuint, location: GLint, bufSize: GLsizei, 
                         params: PGLint){.stdcall, importc, ogl.}
proc glGetnUniformuivARB*(prog: GLuint, location: GLint, bufSize: GLsizei, 
                          params: PGLuint){.stdcall, importc, ogl.}
proc glGetnUniformdvARB*(prog: GLuint, location: GLint, bufSize: GLsizei, 
                         params: PGLdouble){.stdcall, importc, ogl.}
  # GL_ATI_draw_buffers
proc glDrawBuffersATI*(n: GLsizei, bufs: PGLenum){.stdcall, importc, ogl.}
  # GL_ATI_element_array
proc glElementPointerATI*(typ: GLenum, pointer: PGLvoid){.stdcall, importc, ogl.}
proc glDrawElementArrayATI*(mode: GLenum, count: GLsizei){.stdcall, importc, ogl.}
proc glDrawRangeElementArrayATI*(mode: GLenum, start: GLuint, ending: GLuint, 
                                 count: GLsizei){.stdcall, importc, ogl.}
  # GL_ATI_envmap_bumpmap
proc glTexBumpParameterivATI*(pname: GLenum, param: PGLint){.stdcall, importc, ogl.}
proc glTexBumpParameterfvATI*(pname: GLenum, param: PGLfloat){.stdcall, importc, ogl.}
proc glGetTexBumpParameterivATI*(pname: GLenum, param: PGLint){.stdcall, importc, ogl.}
proc glGetTexBumpParameterfvATI*(pname: GLenum, param: PGLfloat){.stdcall, importc, ogl.}
  # GL_ATI_fragment_shader
proc glGenFragmentShadersATI*(range: GLuint): GLuint{.stdcall, importc, ogl.}
proc glBindFragmentShaderATI*(id: GLuint){.stdcall, importc, ogl.}
proc glDeleteFragmentShaderATI*(id: GLuint){.stdcall, importc, ogl.}
proc glBeginFragmentShaderATI*(){.stdcall, importc, ogl.}
proc glEndFragmentShaderATI*(){.stdcall, importc, ogl.}
proc glPassTexCoordATI*(dst: GLuint, coord: GLuint, swizzle: GLenum){.stdcall, importc, ogl.}
proc glSampleMapATI*(dst: GLuint, interp: GLuint, swizzle: GLenum){.stdcall, importc, ogl.}
proc glColorFragmentOp1ATI*(op: GLenum, dst: GLuint, dstMask: GLuint, 
                            dstMod: GLuint, arg1: GLuint, arg1Rep: GLuint, 
                            arg1Mod: GLuint){.stdcall, importc, ogl.}
proc glColorFragmentOp2ATI*(op: GLenum, dst: GLuint, dstMask: GLuint, 
                            dstMod: GLuint, arg1: GLuint, arg1Rep: GLuint, 
                            arg1Mod: GLuint, arg2: GLuint, arg2Rep: GLuint, 
                            arg2Mod: GLuint){.stdcall, importc, ogl.}
proc glColorFragmentOp3ATI*(op: GLenum, dst: GLuint, dstMask: GLuint, 
                            dstMod: GLuint, arg1: GLuint, arg1Rep: GLuint, 
                            arg1Mod: GLuint, arg2: GLuint, arg2Rep: GLuint, 
                            arg2Mod: GLuint, arg3: GLuint, arg3Rep: GLuint, 
                            arg3Mod: GLuint){.stdcall, importc, ogl.}
proc glAlphaFragmentOp1ATI*(op: GLenum, dst: GLuint, dstMod: GLuint, 
                            arg1: GLuint, arg1Rep: GLuint, arg1Mod: GLuint){.
    stdcall, importc, ogl.}
proc glAlphaFragmentOp2ATI*(op: GLenum, dst: GLuint, dstMod: GLuint, 
                            arg1: GLuint, arg1Rep: GLuint, arg1Mod: GLuint, 
                            arg2: GLuint, arg2Rep: GLuint, arg2Mod: GLuint){.
    stdcall, importc, ogl.}
proc glAlphaFragmentOp3ATI*(op: GLenum, dst: GLuint, dstMod: GLuint, 
                            arg1: GLuint, arg1Rep: GLuint, arg1Mod: GLuint, 
                            arg2: GLuint, arg2Rep: GLuint, arg2Mod: GLuint, 
                            arg3: GLuint, arg3Rep: GLuint, arg3Mod: GLuint){.
    stdcall, importc, ogl.}
proc glSetFragmentShaderConstantATI*(dst: GLuint, value: PGLfloat){.stdcall, importc, ogl.}
  # GL_ATI_map_object_buffer
proc glMapObjectBufferATI*(buffer: GLuint): PGLvoid{.stdcall, importc, ogl.}
proc glUnmapObjectBufferATI*(buffer: GLuint){.stdcall, importc, ogl.}
  # GL_ATI_pn_triangles
proc glPNTrianglesiATI*(pname: GLenum, param: GLint){.stdcall, importc, ogl.}
proc glPNTrianglesfATI*(pname: GLenum, param: GLfloat){.stdcall, importc, ogl.}
  # GL_ATI_separate_stencil
proc glStencilOpSeparateATI*(face: GLenum, sfail: GLenum, dpfail: GLenum, 
                             dppass: GLenum){.stdcall, importc, ogl.}
proc glStencilFuncSeparateATI*(frontfunc: GLenum, backfunc: GLenum, theRef: GLint, 
                               mask: GLuint){.stdcall, importc, ogl.}
  # GL_ATI_vertex_array_object
proc glNewObjectBufferATI*(size: GLsizei, pointer: PGLvoid, usage: GLenum): GLuint{.
    stdcall, importc, ogl.}
proc glIsObjectBufferATI*(buffer: GLuint): GLboolean{.stdcall, importc, ogl.}
proc glUpdateObjectBufferATI*(buffer: GLuint, offset: GLuint, size: GLsizei, 
                              pointer: PGLvoid, preserve: GLenum){.stdcall, importc, ogl.}
proc glGetObjectBufferfvATI*(buffer: GLuint, pname: GLenum, params: PGLfloat){.
    stdcall, importc, ogl.}
proc glGetObjectBufferivATI*(buffer: GLuint, pname: GLenum, params: PGLint){.
    stdcall, importc, ogl.}
proc glFreeObjectBufferATI*(buffer: GLuint){.stdcall, importc, ogl.}
proc glArrayObjectATI*(arr: GLenum, size: GLint, typ: GLenum, stride: GLsizei, 
                       buffer: GLuint, offset: GLuint){.stdcall, importc, ogl.}
proc glGetArrayObjectfvATI*(arr: GLenum, pname: GLenum, params: PGLfloat){.
    stdcall, importc, ogl.}
proc glGetArrayObjectivATI*(arr: GLenum, pname: GLenum, params: PGLint){.stdcall, importc, ogl.}
proc glVariantArrayObjectATI*(id: GLuint, typ: GLenum, stride: GLsizei, 
                              buffer: GLuint, offset: GLuint){.stdcall, importc, ogl.}
proc glGetVariantArrayObjectfvATI*(id: GLuint, pname: GLenum, params: PGLfloat){.
    stdcall, importc, ogl.}
proc glGetVariantArrayObjectivATI*(id: GLuint, pname: GLenum, params: PGLint){.
    stdcall, importc, ogl.}
  # GL_ATI_vertex_attrib_array_object
proc glVertexAttribArrayObjectATI*(index: GLuint, size: GLint, typ: GLenum, 
                                   normalized: GLboolean, stride: GLsizei, 
                                   buffer: GLuint, offset: GLuint){.stdcall, importc, ogl.}
proc glGetVertexAttribArrayObjectfvATI*(index: GLuint, pname: GLenum, 
                                        params: PGLfloat){.stdcall, importc, ogl.}
proc glGetVertexAttribArrayObjectivATI*(index: GLuint, pname: GLenum, 
                                        params: PGLint){.stdcall, importc, ogl.}
  # GL_ATI_vertex_streams
proc glVertexStream1sATI*(stream: GLenum, x: GLshort){.stdcall, importc, ogl.}
proc glVertexStream1svATI*(stream: GLenum, coords: PGLshort){.stdcall, importc, ogl.}
proc glVertexStream1iATI*(stream: GLenum, x: GLint){.stdcall, importc, ogl.}
proc glVertexStream1ivATI*(stream: GLenum, coords: PGLint){.stdcall, importc, ogl.}
proc glVertexStream1fATI*(stream: GLenum, x: GLfloat){.stdcall, importc, ogl.}
proc glVertexStream1fvATI*(stream: GLenum, coords: PGLfloat){.stdcall, importc, ogl.}
proc glVertexStream1dATI*(stream: GLenum, x: GLdouble){.stdcall, importc, ogl.}
proc glVertexStream1dvATI*(stream: GLenum, coords: PGLdouble){.stdcall, importc, ogl.}
proc glVertexStream2sATI*(stream: GLenum, x: GLshort, y: GLshort){.stdcall, importc, ogl.}
proc glVertexStream2svATI*(stream: GLenum, coords: PGLshort){.stdcall, importc, ogl.}
proc glVertexStream2iATI*(stream: GLenum, x: GLint, y: GLint){.stdcall, importc, ogl.}
proc glVertexStream2ivATI*(stream: GLenum, coords: PGLint){.stdcall, importc, ogl.}
proc glVertexStream2fATI*(stream: GLenum, x: GLfloat, y: GLfloat){.stdcall, importc, ogl.}
proc glVertexStream2fvATI*(stream: GLenum, coords: PGLfloat){.stdcall, importc, ogl.}
proc glVertexStream2dATI*(stream: GLenum, x: GLdouble, y: GLdouble){.stdcall, importc, ogl.}
proc glVertexStream2dvATI*(stream: GLenum, coords: PGLdouble){.stdcall, importc, ogl.}
proc glVertexStream3sATI*(stream: GLenum, x: GLshort, y: GLshort, z: GLshort){.
    stdcall, importc, ogl.}
proc glVertexStream3svATI*(stream: GLenum, coords: PGLshort){.stdcall, importc, ogl.}
proc glVertexStream3iATI*(stream: GLenum, x: GLint, y: GLint, z: GLint){.stdcall, importc, ogl.}
proc glVertexStream3ivATI*(stream: GLenum, coords: PGLint){.stdcall, importc, ogl.}
proc glVertexStream3fATI*(stream: GLenum, x: GLfloat, y: GLfloat, z: GLfloat){.
    stdcall, importc, ogl.}
proc glVertexStream3fvATI*(stream: GLenum, coords: PGLfloat){.stdcall, importc, ogl.}
proc glVertexStream3dATI*(stream: GLenum, x: GLdouble, y: GLdouble, z: GLdouble){.
    stdcall, importc, ogl.}
proc glVertexStream3dvATI*(stream: GLenum, coords: PGLdouble){.stdcall, importc, ogl.}
proc glVertexStream4sATI*(stream: GLenum, x: GLshort, y: GLshort, z: GLshort, 
                          w: GLshort){.stdcall, importc, ogl.}
proc glVertexStream4svATI*(stream: GLenum, coords: PGLshort){.stdcall, importc, ogl.}
proc glVertexStream4iATI*(stream: GLenum, x: GLint, y: GLint, z: GLint, w: GLint){.
    stdcall, importc, ogl.}
proc glVertexStream4ivATI*(stream: GLenum, coords: PGLint){.stdcall, importc, ogl.}
proc glVertexStream4fATI*(stream: GLenum, x: GLfloat, y: GLfloat, z: GLfloat, 
                          w: GLfloat){.stdcall, importc, ogl.}
proc glVertexStream4fvATI*(stream: GLenum, coords: PGLfloat){.stdcall, importc, ogl.}
proc glVertexStream4dATI*(stream: GLenum, x: GLdouble, y: GLdouble, z: GLdouble, 
                          w: GLdouble){.stdcall, importc, ogl.}
proc glVertexStream4dvATI*(stream: GLenum, coords: PGLdouble){.stdcall, importc, ogl.}
proc glNormalStream3bATI*(stream: GLenum, nx: GLbyte, ny: GLbyte, nz: GLbyte){.
    stdcall, importc, ogl.}
proc glNormalStream3bvATI*(stream: GLenum, coords: PGLbyte){.stdcall, importc, ogl.}
proc glNormalStream3sATI*(stream: GLenum, nx: GLshort, ny: GLshort, nz: GLshort){.
    stdcall, importc, ogl.}
proc glNormalStream3svATI*(stream: GLenum, coords: PGLshort){.stdcall, importc, ogl.}
proc glNormalStream3iATI*(stream: GLenum, nx: GLint, ny: GLint, nz: GLint){.
    stdcall, importc, ogl.}
proc glNormalStream3ivATI*(stream: GLenum, coords: PGLint){.stdcall, importc, ogl.}
proc glNormalStream3fATI*(stream: GLenum, nx: GLfloat, ny: GLfloat, nz: GLfloat){.
    stdcall, importc, ogl.}
proc glNormalStream3fvATI*(stream: GLenum, coords: PGLfloat){.stdcall, importc, ogl.}
proc glNormalStream3dATI*(stream: GLenum, nx: GLdouble, ny: GLdouble, 
                          nz: GLdouble){.stdcall, importc, ogl.}
proc glNormalStream3dvATI*(stream: GLenum, coords: PGLdouble){.stdcall, importc, ogl.}
proc glClientActiveVertexStreamATI*(stream: GLenum){.stdcall, importc, ogl.}
proc glVertexBlendEnviATI*(pname: GLenum, param: GLint){.stdcall, importc, ogl.}
proc glVertexBlendEnvfATI*(pname: GLenum, param: GLfloat){.stdcall, importc, ogl.}
  # GL_AMD_performance_monitor
proc glGetPerfMonitorGroupsAMD*(numGroups: PGLint, groupsSize: GLsizei, 
                                groups: PGLuint){.stdcall, importc, ogl.}
proc glGetPerfMonitorCountersAMD*(group: GLuint, numCounters: PGLint, 
                                  maxActiveCouters: PGLint, 
                                  counterSize: GLsizei, counters: PGLuint){.
    stdcall, importc, ogl.}
proc glGetPerfMonitorGroupStringAMD*(group: GLuint, bufSize: GLsizei, 
                                     len: PGLsizei, groupString: PGLchar){.
    stdcall, importc, ogl.}
proc glGetPerfMonitorCounterStringAMD*(group: GLuint, counter: GLuint, 
                                       bufSize: GLsizei, len: PGLsizei, 
                                       counterString: PGLchar){.stdcall, importc, ogl.}
proc glGetPerfMonitorCounterInfoAMD*(group: GLuint, counter: GLuint, 
                                     pname: GLenum, data: PGLvoid){.stdcall, importc, ogl.}
proc glGenPerfMonitorsAMD*(n: GLsizei, monitors: PGLuint){.stdcall, importc, ogl.}
proc glDeletePerfMonitorsAMD*(n: GLsizei, monitors: PGLuint){.stdcall, importc, ogl.}
proc glSelectPerfMonitorCountersAMD*(monitor: GLuint, enable: GLboolean, 
                                     group: GLuint, numCounters: GLint, 
                                     counterList: PGLuint){.stdcall, importc, ogl.}
proc glBeginPerfMonitorAMD*(monitor: GLuint){.stdcall, importc, ogl.}
proc glEndPerfMonitorAMD*(monitor: GLuint){.stdcall, importc, ogl.}
proc glGetPerfMonitorCounterDataAMD*(monitor: GLuint, pname: GLenum, 
                                     dataSize: GLsizei, data: PGLuint, 
                                     bytesWritten: PGLint){.stdcall, importc, ogl.}
  # GL_AMD_vertex_shader_tesselator
proc glTessellationFactorAMD*(factor: GLfloat){.stdcall, importc, ogl.}
proc glTessellationModeAMD*(mode: GLenum){.stdcall, importc, ogl.}
  # GL_AMD_draw_buffers_blend
proc glBlendFuncIndexedAMD*(buf: GLuint, src: GLenum, dst: GLenum){.stdcall, importc, ogl.}
proc glBlendFuncSeparateIndexedAMD*(buf: GLuint, srcRGB: GLenum, dstRGB: GLenum, 
                                    srcAlpha: GLenum, dstAlpha: GLenum){.stdcall, importc, ogl.}
proc glBlendEquationIndexedAMD*(buf: GLuint, mode: GLenum){.stdcall, importc, ogl.}
proc glBlendEquationSeparateIndexedAMD*(buf: GLuint, modeRGB: GLenum, 
                                        modeAlpha: GLenum){.stdcall, importc, ogl.}
  # GL_AMD_name_gen_delete
proc glGenNamesAMD*(identifier: GLenum, num: GLuint, names: PGLuint){.stdcall, importc, ogl.}
proc glDeleteNamesAMD*(identifier: GLenum, num: GLuint, names: PGLuint){.stdcall, importc, ogl.}
proc glIsNameAMD*(identifier: GLenum, name: GLuint): GLboolean{.stdcall, importc, ogl.}
  # GL_AMD_debug_output
proc glDebugMessageEnableAMD*(category: GLenum, severity: GLenum, 
                              count: GLsizei, ids: PGLuint, enabled: GLboolean){.
    stdcall, importc, ogl.}
proc glDebugMessageInsertAMD*(category: GLenum, severity: GLenum, id: GLuint, 
                              len: GLsizei, buf: PGLchar){.stdcall, importc, ogl.}
proc glDebugMessageCallbackAMD*(callback: TglDebugProcAMD, userParam: PGLvoid){.
    stdcall, importc, ogl.}
proc glGetDebugMessageLogAMD*(count: GLuint, bufsize: GLsizei, 
                              categories: PGLenum, severities: PGLuint, 
                              ids: PGLuint, lengths: PGLsizei, message: PGLchar): GLuint{.
    stdcall, importc, ogl.}
  # GL_EXT_blend_color
proc glBlendColorEXT*(red: GLclampf, green: GLclampf, blue: GLclampf, 
                      alpha: GLclampf){.stdcall, importc, ogl.}
  # GL_EXT_blend_func_separate
proc glBlendFuncSeparateEXT*(sfactorRGB: GLenum, dfactorRGB: GLenum, 
                             sfactorAlpha: GLenum, dfactorAlpha: GLenum){.
    stdcall, importc, ogl.}
  # GL_EXT_blend_minmax
proc glBlendEquationEXT*(mode: GLenum){.stdcall, importc, ogl.}
  # GL_EXT_color_subtable
proc glColorSubTableEXT*(target: GLenum, start: GLsizei, count: GLsizei, 
                         format: GLenum, typ: GLenum, data: PGLvoid){.stdcall, importc, ogl.}
proc glCopyColorSubTableEXT*(target: GLenum, start: GLsizei, x: GLint, y: GLint, 
                             width: GLsizei){.stdcall, importc, ogl.}
  # GL_EXT_compiled_vertex_array
proc glLockArraysEXT*(first: GLint, count: GLsizei){.stdcall, importc, ogl.}
proc glUnlockArraysEXT*(){.stdcall, importc, ogl.}
  # GL_EXT_convolution
proc glConvolutionFilter1DEXT*(target: GLenum, internalformat: GLenum, 
                               width: GLsizei, format: GLenum, typ: GLenum, 
                               image: PGLvoid){.stdcall, importc, ogl.}
proc glConvolutionFilter2DEXT*(target: GLenum, internalformat: GLenum, 
                               width: GLsizei, height: GLsizei, format: GLenum, 
                               typ: GLenum, image: PGLvoid){.stdcall, importc, ogl.}
proc glConvolutionParameterfEXT*(target: GLenum, pname: GLenum, params: GLfloat){.
    stdcall, importc, ogl.}
proc glConvolutionParameterfvEXT*(target: GLenum, pname: GLenum, 
                                  params: PGLfloat){.stdcall, importc, ogl.}
proc glConvolutionParameteriEXT*(target: GLenum, pname: GLenum, params: GLint){.
    stdcall, importc, ogl.}
proc glConvolutionParameterivEXT*(target: GLenum, pname: GLenum, params: PGLint){.
    stdcall, importc, ogl.}
proc glCopyConvolutionFilter1DEXT*(target: GLenum, internalformat: GLenum, 
                                   x: GLint, y: GLint, width: GLsizei){.stdcall, importc, ogl.}
proc glCopyConvolutionFilter2DEXT*(target: GLenum, internalformat: GLenum, 
                                   x: GLint, y: GLint, width: GLsizei, 
                                   height: GLsizei){.stdcall, importc, ogl.}
proc glGetConvolutionFilterEXT*(target: GLenum, format: GLenum, typ: GLenum, 
                                image: PGLvoid){.stdcall, importc, ogl.}
proc glGetConvolutionParameterfvEXT*(target: GLenum, pname: GLenum, 
                                     params: PGLfloat){.stdcall, importc, ogl.}
proc glGetConvolutionParameterivEXT*(target: GLenum, pname: GLenum, 
                                     params: PGLint){.stdcall, importc, ogl.}
proc glGetSeparableFilterEXT*(target: GLenum, format: GLenum, typ: GLenum, 
                              row: PGLvoid, column: PGLvoid, span: PGLvoid){.
    stdcall, importc, ogl.}
proc glSeparableFilter2DEXT*(target: GLenum, internalformat: GLenum, 
                             width: GLsizei, height: GLsizei, format: GLenum, 
                             typ: GLenum, row: PGLvoid, column: PGLvoid){.
    stdcall, importc, ogl.}
  # GL_EXT_coordinate_frame
proc glTangent3bEXT*(tx: GLbyte, ty: GLbyte, tz: GLbyte){.stdcall, importc, ogl.}
proc glTangent3bvEXT*(v: PGLbyte){.stdcall, importc, ogl.}
proc glTangent3dEXT*(tx: GLdouble, ty: GLdouble, tz: GLdouble){.stdcall, importc, ogl.}
proc glTangent3dvEXT*(v: PGLdouble){.stdcall, importc, ogl.}
proc glTangent3fEXT*(tx: GLfloat, ty: GLfloat, tz: GLfloat){.stdcall, importc, ogl.}
proc glTangent3fvEXT*(v: PGLfloat){.stdcall, importc, ogl.}
proc glTangent3iEXT*(tx: GLint, ty: GLint, tz: GLint){.stdcall, importc, ogl.}
proc glTangent3ivEXT*(v: PGLint){.stdcall, importc, ogl.}
proc glTangent3sEXT*(tx: GLshort, ty: GLshort, tz: GLshort){.stdcall, importc, ogl.}
proc glTangent3svEXT*(v: PGLshort){.stdcall, importc, ogl.}
proc glBinormal3bEXT*(bx: GLbyte, by: GLbyte, bz: GLbyte){.stdcall, importc, ogl.}
proc glBinormal3bvEXT*(v: PGLbyte){.stdcall, importc, ogl.}
proc glBinormal3dEXT*(bx: GLdouble, by: GLdouble, bz: GLdouble){.stdcall, importc, ogl.}
proc glBinormal3dvEXT*(v: PGLdouble){.stdcall, importc, ogl.}
proc glBinormal3fEXT*(bx: GLfloat, by: GLfloat, bz: GLfloat){.stdcall, importc, ogl.}
proc glBinormal3fvEXT*(v: PGLfloat){.stdcall, importc, ogl.}
proc glBinormal3iEXT*(bx: GLint, by: GLint, bz: GLint){.stdcall, importc, ogl.}
proc glBinormal3ivEXT*(v: PGLint){.stdcall, importc, ogl.}
proc glBinormal3sEXT*(bx: GLshort, by: GLshort, bz: GLshort){.stdcall, importc, ogl.}
proc glBinormal3svEXT*(v: PGLshort){.stdcall, importc, ogl.}
proc glTangentPointerEXT*(typ: GLenum, stride: GLsizei, pointer: PGLvoid){.
    stdcall, importc, ogl.}
proc glBinormalPointerEXT*(typ: GLenum, stride: GLsizei, pointer: PGLvoid){.
    stdcall, importc, ogl.}
  # GL_EXT_copy_texture
proc glCopyTexImage1DEXT*(target: GLenum, level: GLint, internalformat: GLenum, 
                          x: GLint, y: GLint, width: GLsizei, border: GLint){.
    stdcall, importc, ogl.}
proc glCopyTexImage2DEXT*(target: GLenum, level: GLint, internalformat: GLenum, 
                          x: GLint, y: GLint, width: GLsizei, height: GLsizei, 
                          border: GLint){.stdcall, importc, ogl.}
proc glCopyTexSubImage1DEXT*(target: GLenum, level: GLint, xoffset: GLint, 
                             x: GLint, y: GLint, width: GLsizei){.stdcall, importc, ogl.}
proc glCopyTexSubImage2DEXT*(target: GLenum, level: GLint, xoffset: GLint, 
                             yoffset: GLint, x: GLint, y: GLint, width: GLsizei, 
                             height: GLsizei){.stdcall, importc, ogl.}
proc glCopyTexSubImage3DEXT*(target: GLenum, level: GLint, xoffset: GLint, 
                             yoffset: GLint, zoffset: GLint, x: GLint, y: GLint, 
                             width: GLsizei, height: GLsizei){.stdcall, importc, ogl.}
  # GL_EXT_cull_vertex
proc glCullParameterdvEXT*(pname: GLenum, params: PGLdouble){.stdcall, importc, ogl.}
proc glCullParameterfvEXT*(pname: GLenum, params: PGLfloat){.stdcall, importc, ogl.}
  # GL_EXT_draw_range_elements
proc glDrawRangeElementsEXT*(mode: GLenum, start: GLuint, ending: GLuint, 
                             count: GLsizei, typ: GLenum, indices: PGLvoid){.
    stdcall, importc, ogl.}
  # GL_EXT_fog_coord
proc glFogCoordfEXT*(coord: GLfloat){.stdcall, importc, ogl.}
proc glFogCoordfvEXT*(coord: PGLfloat){.stdcall, importc, ogl.}
proc glFogCoorddEXT*(coord: GLdouble){.stdcall, importc, ogl.}
proc glFogCoorddvEXT*(coord: PGLdouble){.stdcall, importc, ogl.}
proc glFogCoordPointerEXT*(typ: GLenum, stride: GLsizei, pointer: PGLvoid){.
    stdcall, importc, ogl.}
  # GL_EXT_framebuffer_object
proc glIsRenderbufferEXT*(renderbuffer: GLuint): Bool{.stdcall, importc, ogl.}
proc glBindRenderbufferEXT*(target: GLenum, renderbuffer: GLuint){.stdcall, importc, ogl.}
proc glDeleteRenderbuffersEXT*(n: GLsizei, renderbuffers: PGLuint){.stdcall, importc, ogl.}
proc glGenRenderbuffersEXT*(n: GLsizei, renderbuffers: PGLuint){.stdcall, importc, ogl.}
proc glRenderbufferStorageEXT*(target: GLenum, internalformat: GLenum, 
                               width: GLsizei, height: GLsizei){.stdcall, importc, ogl.}
proc glGetRenderbufferParameterivEXT*(target: GLenum, pname: GLenum, 
                                      params: PGLint){.stdcall, importc, ogl.}
proc glIsFramebufferEXT*(framebuffer: GLuint): Bool{.stdcall, importc, ogl.}
proc glBindFramebufferEXT*(target: GLenum, framebuffer: GLuint){.stdcall, importc, ogl.}
proc glDeleteFramebuffersEXT*(n: GLsizei, framebuffers: PGLuint){.stdcall, importc, ogl.}
proc glGenFramebuffersEXT*(n: GLsizei, framebuffers: PGLuint){.stdcall, importc, ogl.}
proc glCheckFramebufferStatusEXT*(target: GLenum): GLenum{.stdcall, importc, ogl.}
proc glFramebufferTexture1DEXT*(target: GLenum, attachment: GLenum, 
                                textarget: GLenum, texture: GLuint, level: GLint){.
    stdcall, importc, ogl.}
proc glFramebufferTexture2DEXT*(target: GLenum, attachment: GLenum, 
                                textarget: GLenum, texture: GLuint, level: GLint){.
    stdcall, importc, ogl.}
proc glFramebufferTexture3DEXT*(target: GLenum, attachment: GLenum, 
                                textarget: GLenum, texture: GLuint, 
                                level: GLint, zoffset: GLint){.stdcall, importc, ogl.}
proc glFramebufferRenderbufferEXT*(target: GLenum, attachment: GLenum, 
                                   renderbuffertarget: GLenum, 
                                   renderbuffer: GLuint){.stdcall, importc, ogl.}
proc glGetFramebufferAttachmentParameterivEXT*(target: GLenum, 
    attachment: GLenum, pname: GLenum, params: PGLint){.stdcall, importc, ogl.}
proc glGenerateMipmapEXT*(target: GLenum){.stdcall, importc, ogl.}
  # GL_EXT_histogram
proc glGetHistogramEXT*(target: GLenum, reset: GLboolean, format: GLenum, 
                        typ: GLenum, values: PGLvoid){.stdcall, importc, ogl.}
proc glGetHistogramParameterfvEXT*(target: GLenum, pname: GLenum, 
                                   params: PGLfloat){.stdcall, importc, ogl.}
proc glGetHistogramParameterivEXT*(target: GLenum, pname: GLenum, params: PGLint){.
    stdcall, importc, ogl.}
proc glGetMinmaxEXT*(target: GLenum, reset: GLboolean, format: GLenum, 
                     typ: GLenum, values: PGLvoid){.stdcall, importc, ogl.}
proc glGetMinmaxParameterfvEXT*(target: GLenum, pname: GLenum, params: PGLfloat){.
    stdcall, importc, ogl.}
proc glGetMinmaxParameterivEXT*(target: GLenum, pname: GLenum, params: PGLint){.
    stdcall, importc, ogl.}
proc glHistogramEXT*(target: GLenum, width: GLsizei, internalformat: GLenum, 
                     sink: GLboolean){.stdcall, importc, ogl.}
proc glMinmaxEXT*(target: GLenum, internalformat: GLenum, sink: GLboolean){.
    stdcall, importc, ogl.}
proc glResetHistogramEXT*(target: GLenum){.stdcall, importc, ogl.}
proc glResetMinmaxEXT*(target: GLenum){.stdcall, importc, ogl.}
  # GL_EXT_index_func
proc glIndexFuncEXT*(func: GLenum, theRef: GLclampf){.stdcall, importc, ogl.}
  # GL_EXT_index_material
proc glIndexMaterialEXT*(face: GLenum, mode: GLenum){.stdcall, importc, ogl.}
  # GL_EXT_light_texture
proc glApplyTextureEXT*(mode: GLenum){.stdcall, importc, ogl.}
proc glTextureLightEXT*(pname: GLenum){.stdcall, importc, ogl.}
proc glTextureMaterialEXT*(face: GLenum, mode: GLenum){.stdcall, importc, ogl.}
  # GL_EXT_multi_draw_arrays
proc glMultiDrawArraysEXT*(mode: GLenum, first: PGLint, count: PGLsizei, 
                           primcount: GLsizei){.stdcall, importc, ogl.}
proc glMultiDrawElementsEXT*(mode: GLenum, count: PGLsizei, typ: GLenum, 
                             indices: PGLvoid, primcount: GLsizei){.stdcall, importc, ogl.}
  # GL_EXT_multisample
proc glSampleMaskEXT*(value: GLclampf, invert: GLboolean){.stdcall, importc, ogl.}
proc glSamplePatternEXT*(pattern: GLenum){.stdcall, importc, ogl.}
  # GL_EXT_paletted_texture
proc glColorTableEXT*(target: GLenum, internalFormat: GLenum, width: GLsizei, 
                      format: GLenum, typ: GLenum, table: PGLvoid){.stdcall, importc, ogl.}
proc glGetColorTableEXT*(target: GLenum, format: GLenum, typ: GLenum, 
                         data: PGLvoid){.stdcall, importc, ogl.}
proc glGetColorTableParameterivEXT*(target: GLenum, pname: GLenum, 
                                    params: PGLint){.stdcall, importc, ogl.}
proc glGetColorTableParameterfvEXT*(target: GLenum, pname: GLenum, 
                                    params: PGLfloat){.stdcall, importc, ogl.}
  # GL_EXT_pixel_transform
proc glPixelTransformParameteriEXT*(target: GLenum, pname: GLenum, param: GLint){.
    stdcall, importc, ogl.}
proc glPixelTransformParameterfEXT*(target: GLenum, pname: GLenum, 
                                    param: GLfloat){.stdcall, importc, ogl.}
proc glPixelTransformParameterivEXT*(target: GLenum, pname: GLenum, 
                                     params: PGLint){.stdcall, importc, ogl.}
proc glPixelTransformParameterfvEXT*(target: GLenum, pname: GLenum, 
                                     params: PGLfloat){.stdcall, importc, ogl.}
  # GL_EXT_point_parameters
proc glPointParameterfEXT*(pname: GLenum, param: GLfloat){.stdcall, importc, ogl.}
proc glPointParameterfvEXT*(pname: GLenum, params: PGLfloat){.stdcall, importc, ogl.}
  # GL_EXT_polygon_offset
proc glPolygonOffsetEXT*(factor: GLfloat, bias: GLfloat){.stdcall, importc, ogl.}
  # GL_EXT_secondary_color
proc glSecondaryColor3bEXT*(red: GLbyte, green: GLbyte, blue: GLbyte){.stdcall, importc, ogl.}
proc glSecondaryColor3bvEXT*(v: PGLbyte){.stdcall, importc, ogl.}
proc glSecondaryColor3dEXT*(red: GLdouble, green: GLdouble, blue: GLdouble){.
    stdcall, importc, ogl.}
proc glSecondaryColor3dvEXT*(v: PGLdouble){.stdcall, importc, ogl.}
proc glSecondaryColor3fEXT*(red: GLfloat, green: GLfloat, blue: GLfloat){.
    stdcall, importc, ogl.}
proc glSecondaryColor3fvEXT*(v: PGLfloat){.stdcall, importc, ogl.}
proc glSecondaryColor3iEXT*(red: GLint, green: GLint, blue: GLint){.stdcall, importc, ogl.}
proc glSecondaryColor3ivEXT*(v: PGLint){.stdcall, importc, ogl.}
proc glSecondaryColor3sEXT*(red: GLshort, green: GLshort, blue: GLshort){.
    stdcall, importc, ogl.}
proc glSecondaryColor3svEXT*(v: PGLshort){.stdcall, importc, ogl.}
proc glSecondaryColor3ubEXT*(red: GLubyte, green: GLubyte, blue: GLubyte){.
    stdcall, importc, ogl.}
proc glSecondaryColor3ubvEXT*(v: PGLubyte){.stdcall, importc, ogl.}
proc glSecondaryColor3uiEXT*(red: GLuint, green: GLuint, blue: GLuint){.stdcall, importc, ogl.}
proc glSecondaryColor3uivEXT*(v: PGLuint){.stdcall, importc, ogl.}
proc glSecondaryColor3usEXT*(red: GLushort, green: GLushort, blue: GLushort){.
    stdcall, importc, ogl.}
proc glSecondaryColor3usvEXT*(v: PGLushort){.stdcall, importc, ogl.}
proc glSecondaryColorPointerEXT*(size: GLint, typ: GLenum, stride: GLsizei, 
                                 pointer: PGLvoid){.stdcall, importc, ogl.}
  # GL_EXT_stencil_two_side
proc glActiveStencilFaceEXT*(face: GLenum){.stdcall, importc, ogl.}
  # GL_EXT_subtexture
proc glTexSubImage1DEXT*(target: GLenum, level: GLint, xoffset: GLint, 
                         width: GLsizei, format: GLenum, typ: GLenum, 
                         pixels: PGLvoid){.stdcall, importc, ogl.}
proc glTexSubImage2DEXT*(target: GLenum, level: GLint, xoffset: GLint, 
                         yoffset: GLint, width: GLsizei, height: GLsizei, 
                         format: GLenum, typ: GLenum, pixels: PGLvoid){.stdcall, importc, ogl.}
  # GL_EXT_texture3D
proc glTexImage3DEXT*(target: GLenum, level: GLint, internalformat: GLenum, 
                      width: GLsizei, height: GLsizei, depth: GLsizei, 
                      border: GLint, format: GLenum, typ: GLenum, 
                      pixels: PGLvoid){.stdcall, importc, ogl.}
proc glTexSubImage3DEXT*(target: GLenum, level: GLint, xoffset: GLint, 
                         yoffset: GLint, zoffset: GLint, width: GLsizei, 
                         height: GLsizei, depth: GLsizei, format: GLenum, 
                         typ: GLenum, pixels: PGLvoid){.stdcall, importc, ogl.}
  # GL_EXT_texture_object
proc glAreTexturesResidentEXT*(n: GLsizei, textures: PGLuint, 
                               residences: PGLboolean): GLboolean{.stdcall, importc, ogl.}
proc glBindTextureEXT*(target: GLenum, texture: GLuint){.stdcall, importc, ogl.}
proc glDeleteTexturesEXT*(n: GLsizei, textures: PGLuint){.stdcall, importc, ogl.}
proc glGenTexturesEXT*(n: GLsizei, textures: PGLuint){.stdcall, importc, ogl.}
proc glIsTextureEXT*(texture: GLuint): GLboolean{.stdcall, importc, ogl.}
proc glPrioritizeTexturesEXT*(n: GLsizei, textures: PGLuint, 
                              priorities: PGLclampf){.stdcall, importc, ogl.}
  # GL_EXT_texture_perturb_normal
proc glTextureNormalEXT*(mode: GLenum){.stdcall, importc, ogl.}
  # GL_EXT_vertex_array
proc glArrayElementEXT*(i: GLint){.stdcall, importc, ogl.}
proc glColorPointerEXT*(size: GLint, typ: GLenum, stride: GLsizei, 
                        count: GLsizei, pointer: PGLvoid){.stdcall, importc, ogl.}
proc glDrawArraysEXT*(mode: GLenum, first: GLint, count: GLsizei){.stdcall, importc, ogl.}
proc glEdgeFlagPointerEXT*(stride: GLsizei, count: GLsizei, pointer: PGLboolean){.
    stdcall, importc, ogl.}
proc glGetPointervEXT*(pname: GLenum, params: PGLvoid){.stdcall, importc, ogl.}
proc glIndexPointerEXT*(typ: GLenum, stride: GLsizei, count: GLsizei, 
                        pointer: PGLvoid){.stdcall, importc, ogl.}
proc glNormalPointerEXT*(typ: GLenum, stride: GLsizei, count: GLsizei, 
                         pointer: PGLvoid){.stdcall, importc, ogl.}
proc glTexCoordPointerEXT*(size: GLint, typ: GLenum, stride: GLsizei, 
                           count: GLsizei, pointer: PGLvoid){.stdcall, importc, ogl.}
proc glVertexPointerEXT*(size: GLint, typ: GLenum, stride: GLsizei, 
                         count: GLsizei, pointer: PGLvoid){.stdcall, importc, ogl.}
  # GL_EXT_vertex_shader
proc glBeginVertexShaderEXT*(){.stdcall, importc, ogl.}
proc glEndVertexShaderEXT*(){.stdcall, importc, ogl.}
proc glBindVertexShaderEXT*(id: GLuint){.stdcall, importc, ogl.}
proc glGenVertexShadersEXT*(range: GLuint): GLuint{.stdcall, importc, ogl.}
proc glDeleteVertexShaderEXT*(id: GLuint){.stdcall, importc, ogl.}
proc glShaderOp1EXT*(op: GLenum, res: GLuint, arg1: GLuint){.stdcall, importc, ogl.}
proc glShaderOp2EXT*(op: GLenum, res: GLuint, arg1: GLuint, arg2: GLuint){.
    stdcall, importc, ogl.}
proc glShaderOp3EXT*(op: GLenum, res: GLuint, arg1: GLuint, arg2: GLuint, 
                     arg3: GLuint){.stdcall, importc, ogl.}
proc glSwizzleEXT*(res: GLuint, ain: GLuint, outX: GLenum, outY: GLenum, 
                   outZ: GLenum, outW: GLenum){.stdcall, importc, ogl.}
proc glWriteMaskEXT*(res: GLuint, ain: GLuint, outX: GLenum, outY: GLenum, 
                     outZ: GLenum, outW: GLenum){.stdcall, importc, ogl.}
proc glInsertComponentEXT*(res: GLuint, src: GLuint, num: GLuint){.stdcall, importc, ogl.}
proc glExtractComponentEXT*(res: GLuint, src: GLuint, num: GLuint){.stdcall, importc, ogl.}
proc glGenSymbolsEXT*(datatype: GLenum, storagetype: GLenum, range: GLenum, 
                      components: GLuint): GLuint{.stdcall, importc, ogl.}
proc glSetInvariantEXT*(id: GLuint, typ: GLenum, theAddr: PGLvoid){.stdcall, importc, ogl.}
proc glSetLocalConstantEXT*(id: GLuint, typ: GLenum, theAddr: PGLvoid){.stdcall, importc, ogl.}
proc glVariantbvEXT*(id: GLuint, theAddr: PGLbyte){.stdcall, importc, ogl.}
proc glVariantsvEXT*(id: GLuint, theAddr: PGLshort){.stdcall, importc, ogl.}
proc glVariantivEXT*(id: GLuint, theAddr: PGLint){.stdcall, importc, ogl.}
proc glVariantfvEXT*(id: GLuint, theAddr: PGLfloat){.stdcall, importc, ogl.}
proc glVariantdvEXT*(id: GLuint, theAddr: PGLdouble){.stdcall, importc, ogl.}
proc glVariantubvEXT*(id: GLuint, theAddr: PGLubyte){.stdcall, importc, ogl.}
proc glVariantusvEXT*(id: GLuint, theAddr: PGLushort){.stdcall, importc, ogl.}
proc glVariantuivEXT*(id: GLuint, theAddr: PGLuint){.stdcall, importc, ogl.}
proc glVariantPointerEXT*(id: GLuint, typ: GLenum, stride: GLuint, theAddr: PGLvoid){.
    stdcall, importc, ogl.}
proc glEnableVariantClientStateEXT*(id: GLuint){.stdcall, importc, ogl.}
proc glDisableVariantClientStateEXT*(id: GLuint){.stdcall, importc, ogl.}
proc glBindLightParameterEXT*(light: GLenum, value: GLenum): GLuint{.stdcall, importc, ogl.}
proc glBindMaterialParameterEXT*(face: GLenum, value: GLenum): GLuint{.stdcall, importc, ogl.}
proc glBindTexGenParameterEXT*(theUnit: GLenum, coord: GLenum, value: GLenum): GLuint{.
    stdcall, importc, ogl.}
proc glBindTextureUnitParameterEXT*(theUnit: GLenum, value: GLenum): GLuint{.
    stdcall, importc, ogl.}
proc glBindParameterEXT*(value: GLenum): GLuint{.stdcall, importc, ogl.}
proc glIsVariantEnabledEXT*(id: GLuint, cap: GLenum): GLboolean{.stdcall, importc, ogl.}
proc glGetVariantBooleanvEXT*(id: GLuint, value: GLenum, data: PGLboolean){.
    stdcall, importc, ogl.}
proc glGetVariantIntegervEXT*(id: GLuint, value: GLenum, data: PGLint){.stdcall, importc, ogl.}
proc glGetVariantFloatvEXT*(id: GLuint, value: GLenum, data: PGLfloat){.stdcall, importc, ogl.}
proc glGetVariantPointervEXT*(id: GLuint, value: GLenum, data: PGLvoid){.stdcall, importc, ogl.}
proc glGetInvariantBooleanvEXT*(id: GLuint, value: GLenum, data: PGLboolean){.
    stdcall, importc, ogl.}
proc glGetInvariantIntegervEXT*(id: GLuint, value: GLenum, data: PGLint){.
    stdcall, importc, ogl.}
proc glGetInvariantFloatvEXT*(id: GLuint, value: GLenum, data: PGLfloat){.
    stdcall, importc, ogl.}
proc glGetLocalConstantBooleanvEXT*(id: GLuint, value: GLenum, data: PGLboolean){.
    stdcall, importc, ogl.}
proc glGetLocalConstantIntegervEXT*(id: GLuint, value: GLenum, data: PGLint){.
    stdcall, importc, ogl.}
proc glGetLocalConstantFloatvEXT*(id: GLuint, value: GLenum, data: PGLfloat){.
    stdcall, importc, ogl.}
  # GL_EXT_vertex_weighting
proc glVertexWeightfEXT*(weight: GLfloat){.stdcall, importc, ogl.}
proc glVertexWeightfvEXT*(weight: PGLfloat){.stdcall, importc, ogl.}
proc glVertexWeightPointerEXT*(size: GLsizei, typ: GLenum, stride: GLsizei, 
                               pointer: PGLvoid){.stdcall, importc, ogl.}
  # GL_EXT_stencil_clear_tag
proc glStencilClearTagEXT*(stencilTagBits: GLsizei, stencilClearTag: GLuint){.
    stdcall, importc, ogl.}
  # GL_EXT_framebuffer_blit
proc glBlitFramebufferEXT*(srcX0: GLint, srcY0: GLint, srcX1: GLint, 
                           srcY1: GLint, dstX0: GLint, dstY0: GLint, 
                           dstX1: GLint, dstY1: GLint, mask: GLbitfield, 
                           filter: GLenum){.stdcall, importc, ogl.}
  # GL_EXT_framebuffer_multisample
proc glRenderbufferStorageMultisampleEXT*(target: GLenum, samples: GLsizei, 
    internalformat: GLenum, width: GLsizei, height: GLsizei){.stdcall, importc, ogl.}
  # GL_EXT_timer_query
proc glGetQueryObjecti64vEXT*(id: GLuint, pname: GLenum, params: PGLint64EXT){.
    stdcall, importc, ogl.}
proc glGetQueryObjectui64vEXT*(id: GLuint, pname: GLenum, params: PGLuint64EXT){.
    stdcall, importc, ogl.}
  # GL_EXT_gpu_program_parameters
proc glProgramEnvParameters4fvEXT*(target: GLenum, index: GLuint, 
                                   count: GLsizei, params: PGLfloat){.stdcall, importc, ogl.}
proc glProgramLocalParameters4fvEXT*(target: GLenum, index: GLuint, 
                                     count: GLsizei, params: PGLfloat){.stdcall, importc, ogl.}
  # GL_EXT_bindable_uniform
proc glUniformBufferEXT*(prog: GLuint, location: GLint, buffer: GLuint){.stdcall, importc, ogl.}
proc glGetUniformBufferSizeEXT*(prog: GLuint, location: GLint): GLint{.stdcall, importc, ogl.}
proc glGetUniformOffsetEXT*(prog: GLuint, location: GLint): GLintptr{.stdcall, importc, ogl.}
  # GL_EXT_draw_buffers2
proc glColorMaskIndexedEXT*(buf: GLuint, r: GLboolean, g: GLboolean, 
                            b: GLboolean, a: GLboolean){.stdcall, importc, ogl.}
proc glGetBooleanIndexedvEXT*(value: GLenum, index: GLuint, data: PGLboolean){.
    stdcall, importc, ogl.}
proc glGetIntegerIndexedvEXT*(value: GLenum, index: GLuint, data: PGLint){.
    stdcall, importc, ogl.}
proc glEnableIndexedEXT*(target: GLenum, index: GLuint){.stdcall, importc, ogl.}
proc glDisableIndexedEXT*(target: GLenum, index: GLuint){.stdcall, importc, ogl.}
proc glIsEnabledIndexedEXT*(target: GLenum, index: GLuint): GLboolean{.stdcall, importc, ogl.}
  # GL_EXT_draw_instanced
proc glDrawArraysInstancedEXT*(mode: GLenum, first: GLint, count: GLsizei, 
                               primcount: GLsizei){.stdcall, importc, ogl.}
proc glDrawElementsInstancedEXT*(mode: GLenum, count: GLsizei, typ: GLenum, 
                                 indices: Pointer, primcount: GLsizei){.stdcall, importc, ogl.}
  # GL_EXT_geometry_shader4
proc glProgramParameteriEXT*(prog: GLuint, pname: GLenum, value: GLint){.stdcall, importc, ogl.}
proc glFramebufferTextureEXT*(target: GLenum, attachment: GLenum, 
                              texture: GLuint, level: GLint){.stdcall, importc, ogl.}
  #procedure glFramebufferTextureLayerEXT(target: GLenum; attachment: GLenum; texture: GLuint; level: GLint; layer: GLint); stdcall, importc, ogl;
proc glFramebufferTextureFaceEXT*(target: GLenum, attachment: GLenum, 
                                  texture: GLuint, level: GLint, face: GLenum){.
    stdcall, importc, ogl.}
  # GL_EXT_gpu_shader4
proc glVertexAttribI1iEXT*(index: GLuint, x: GLint){.stdcall, importc, ogl.}
proc glVertexAttribI2iEXT*(index: GLuint, x: GLint, y: GLint){.stdcall, importc, ogl.}
proc glVertexAttribI3iEXT*(index: GLuint, x: GLint, y: GLint, z: GLint){.stdcall, importc, ogl.}
proc glVertexAttribI4iEXT*(index: GLuint, x: GLint, y: GLint, z: GLint, w: GLint){.
    stdcall, importc, ogl.}
proc glVertexAttribI1uiEXT*(index: GLuint, x: GLuint){.stdcall, importc, ogl.}
proc glVertexAttribI2uiEXT*(index: GLuint, x: GLuint, y: GLuint){.stdcall, importc, ogl.}
proc glVertexAttribI3uiEXT*(index: GLuint, x: GLuint, y: GLuint, z: GLuint){.
    stdcall, importc, ogl.}
proc glVertexAttribI4uiEXT*(index: GLuint, x: GLuint, y: GLuint, z: GLuint, 
                            w: GLuint){.stdcall, importc, ogl.}
proc glVertexAttribI1ivEXT*(index: GLuint, v: PGLint){.stdcall, importc, ogl.}
proc glVertexAttribI2ivEXT*(index: GLuint, v: PGLint){.stdcall, importc, ogl.}
proc glVertexAttribI3ivEXT*(index: GLuint, v: PGLint){.stdcall, importc, ogl.}
proc glVertexAttribI4ivEXT*(index: GLuint, v: PGLint){.stdcall, importc, ogl.}
proc glVertexAttribI1uivEXT*(index: GLuint, v: PGLuint){.stdcall, importc, ogl.}
proc glVertexAttribI2uivEXT*(index: GLuint, v: PGLuint){.stdcall, importc, ogl.}
proc glVertexAttribI3uivEXT*(index: GLuint, v: PGLuint){.stdcall, importc, ogl.}
proc glVertexAttribI4uivEXT*(index: GLuint, v: PGLuint){.stdcall, importc, ogl.}
proc glVertexAttribI4bvEXT*(index: GLuint, v: PGLbyte){.stdcall, importc, ogl.}
proc glVertexAttribI4svEXT*(index: GLuint, v: PGLshort){.stdcall, importc, ogl.}
proc glVertexAttribI4ubvEXT*(index: GLuint, v: PGLubyte){.stdcall, importc, ogl.}
proc glVertexAttribI4usvEXT*(index: GLuint, v: PGLushort){.stdcall, importc, ogl.}
proc glVertexAttribIPointerEXT*(index: GLuint, size: GLint, typ: GLenum, 
                                stride: GLsizei, pointer: Pointer){.stdcall, importc, ogl.}
proc glGetVertexAttribIivEXT*(index: GLuint, pname: GLenum, params: PGLint){.
    stdcall, importc, ogl.}
proc glGetVertexAttribIuivEXT*(index: GLuint, pname: GLenum, params: PGLuint){.
    stdcall, importc, ogl.}
proc glUniform1uiEXT*(location: GLint, v0: GLuint){.stdcall, importc, ogl.}
proc glUniform2uiEXT*(location: GLint, v0: GLuint, v1: GLuint){.stdcall, importc, ogl.}
proc glUniform3uiEXT*(location: GLint, v0: GLuint, v1: GLuint, v2: GLuint){.
    stdcall, importc, ogl.}
proc glUniform4uiEXT*(location: GLint, v0: GLuint, v1: GLuint, v2: GLuint, 
                      v3: GLuint){.stdcall, importc, ogl.}
proc glUniform1uivEXT*(location: GLint, count: GLsizei, value: PGLuint){.stdcall, importc, ogl.}
proc glUniform2uivEXT*(location: GLint, count: GLsizei, value: PGLuint){.stdcall, importc, ogl.}
proc glUniform3uivEXT*(location: GLint, count: GLsizei, value: PGLuint){.stdcall, importc, ogl.}
proc glUniform4uivEXT*(location: GLint, count: GLsizei, value: PGLuint){.stdcall, importc, ogl.}
proc glGetUniformuivEXT*(prog: GLuint, location: GLint, params: PGLuint){.
    stdcall, importc, ogl.}
proc glBindFragDataLocationEXT*(prog: GLuint, colorNumber: GLuint, name: PGLchar){.
    stdcall, importc, ogl.}
proc glGetFragDataLocationEXT*(prog: GLuint, name: PGLchar): GLint{.stdcall, importc, ogl.}
  # GL_EXT_texture_array
proc glFramebufferTextureLayerEXT*(target: GLenum, attachment: GLenum, 
                                   texture: GLuint, level: GLint, layer: GLint){.
    stdcall, importc, ogl.}
  # GL_EXT_texture_buffer_object
proc glTexBufferEXT*(target: GLenum, internalformat: GLenum, buffer: GLuint){.
    stdcall, importc, ogl.}
  # GL_EXT_texture_integer
proc glClearColorIiEXT*(r: GLint, g: GLint, b: GLint, a: GLint){.stdcall, importc, ogl.}
proc glClearColorIuiEXT*(r: GLuint, g: GLuint, b: GLuint, a: GLuint){.stdcall, importc, ogl.}
proc glTexParameterIivEXT*(target: GLenum, pname: GLenum, params: PGLint){.
    stdcall, importc, ogl.}
proc glTexParameterIuivEXT*(target: GLenum, pname: GLenum, params: PGLuint){.
    stdcall, importc, ogl.}
proc glGetTexParameterIivEXT*(target: GLenum, pname: GLenum, params: PGLint){.
    stdcall, importc, ogl.}
proc glGetTexParameterIiuvEXT*(target: GLenum, pname: GLenum, params: PGLuint){.
    stdcall, importc, ogl.}
  # GL_HP_image_transform
proc glImageTransformParameteriHP*(target: GLenum, pname: GLenum, param: GLint){.
    stdcall, importc, ogl.}
proc glImageTransformParameterfHP*(target: GLenum, pname: GLenum, param: GLfloat){.
    stdcall, importc, ogl.}
proc glImageTransformParameterivHP*(target: GLenum, pname: GLenum, 
                                    params: PGLint){.stdcall, importc, ogl.}
proc glImageTransformParameterfvHP*(target: GLenum, pname: GLenum, 
                                    params: PGLfloat){.stdcall, importc, ogl.}
proc glGetImageTransformParameterivHP*(target: GLenum, pname: GLenum, 
                                       params: PGLint){.stdcall, importc, ogl.}
proc glGetImageTransformParameterfvHP*(target: GLenum, pname: GLenum, 
                                       params: PGLfloat){.stdcall, importc, ogl.}
  # GL_EXT_depth_bounds_test
proc glDepthBoundsEXT*(zmin: GLclampd, zmax: GLclampd){.stdcall, importc, ogl.}
  # GL_EXT_blend_equation_separate
proc glBlendEquationSeparateEXT*(modeRGB: GLenum, modeAlpha: GLenum){.stdcall, importc, ogl.}
  # GL_EXT_transform_feedback
proc glBeginTransformFeedbackEXT*(primitiveMode: GLenum){.stdcall, importc, ogl.}
proc glEndTransformFeedbackEXT*(){.stdcall, importc, ogl.}
proc glBindBufferRangeEXT*(target: GLenum, index: GLuint, buffer: GLuint, 
                           offset: GLintptr, size: GLsizeiptr){.stdcall, importc, ogl.}
proc glBindBufferOffsetEXT*(target: GLenum, index: GLuint, buffer: GLuint, 
                            offset: GLintptr){.stdcall, importc, ogl.}
proc glBindBufferBaseEXT*(target: GLenum, index: GLuint, buffer: GLuint){.
    stdcall, importc, ogl.}
proc glTransformFeedbackVaryingsEXT*(prog: GLuint, count: GLsizei, 
                                     locations: PGLint, bufferMode: GLenum){.
    stdcall, importc, ogl.}
proc glGetTransformFeedbackVaryingEXT*(prog: GLuint, index: GLuint, 
                                       location: PGLint){.stdcall, importc, ogl.}
  # GL_EXT_direct_state_access
proc glClientAttribDefaultEXT*(mask: GLbitfield){.stdcall, importc, ogl.}
proc glPushClientAttribDefaultEXT*(mask: GLbitfield){.stdcall, importc, ogl.}
proc glMatrixLoadfEXT*(mode: GLenum, m: PGLfloat){.stdcall, importc, ogl.}
proc glMatrixLoaddEXT*(mode: GLenum, m: PGLdouble){.stdcall, importc, ogl.}
proc glMatrixMultfEXT*(mode: GLenum, m: PGLfloat){.stdcall, importc, ogl.}
proc glMatrixMultdEXT*(mode: GLenum, m: PGLdouble){.stdcall, importc, ogl.}
proc glMatrixLoadIdentityEXT*(mode: GLenum){.stdcall, importc, ogl.}
proc glMatrixRotatefEXT*(mode: GLenum, angle: GLfloat, x: GLfloat, y: GLfloat, 
                         z: GLfloat){.stdcall, importc, ogl.}
proc glMatrixRotatedEXT*(mode: GLenum, angle: GLdouble, x: GLdouble, 
                         y: GLdouble, z: GLdouble){.stdcall, importc, ogl.}
proc glMatrixScalefEXT*(mode: GLenum, x: GLfloat, y: GLfloat, z: GLfloat){.
    stdcall, importc, ogl.}
proc glMatrixScaledEXT*(mode: GLenum, x: GLdouble, y: GLdouble, z: GLdouble){.
    stdcall, importc, ogl.}
proc glMatrixTranslatefEXT*(mode: GLenum, x: GLfloat, y: GLfloat, z: GLfloat){.
    stdcall, importc, ogl.}
proc glMatrixTranslatedEXT*(mode: GLenum, x: GLdouble, y: GLdouble, z: GLdouble){.
    stdcall, importc, ogl.}
proc glMatrixFrustumEXT*(mode: GLenum, left: GLdouble, right: GLdouble, 
                         bottom: GLdouble, top: GLdouble, zNear: GLdouble, 
                         zFar: GLdouble){.stdcall, importc, ogl.}
proc glMatrixOrthoEXT*(mode: GLenum, left: GLdouble, right: GLdouble, 
                       bottom: GLdouble, top: GLdouble, zNear: GLdouble, 
                       zFar: GLdouble){.stdcall, importc, ogl.}
proc glMatrixPopEXT*(mode: GLenum){.stdcall, importc, ogl.}
proc glMatrixPushEXT*(mode: GLenum){.stdcall, importc, ogl.}
proc glMatrixLoadTransposefEXT*(mode: GLenum, m: PGLfloat){.stdcall, importc, ogl.}
proc glMatrixLoadTransposedEXT*(mode: GLenum, m: PGLdouble){.stdcall, importc, ogl.}
proc glMatrixMultTransposefEXT*(mode: GLenum, m: PGLfloat){.stdcall, importc, ogl.}
proc glMatrixMultTransposedEXT*(mode: GLenum, m: PGLdouble){.stdcall, importc, ogl.}
proc glTextureParameterfEXT*(texture: GLuint, target: GLenum, pname: GLenum, 
                             param: GLfloat){.stdcall, importc, ogl.}
proc glTextureParameterfvEXT*(texture: GLuint, target: GLenum, pname: GLenum, 
                              params: PGLfloat){.stdcall, importc, ogl.}
proc glTextureParameteriEXT*(texture: GLuint, target: GLenum, pname: GLenum, 
                             param: GLint){.stdcall, importc, ogl.}
proc glTextureParameterivEXT*(texture: GLuint, target: GLenum, pname: GLenum, 
                              params: PGLint){.stdcall, importc, ogl.}
proc glTextureImage1DEXT*(texture: GLuint, target: GLenum, level: GLint, 
                          internalformat: GLenum, width: GLsizei, border: GLint, 
                          format: GLenum, typ: GLenum, pixels: PGLvoid){.stdcall, importc, ogl.}
proc glTextureImage2DEXT*(texture: GLuint, target: GLenum, level: GLint, 
                          internalformat: GLenum, width: GLsizei, 
                          height: GLsizei, border: GLint, format: GLenum, 
                          typ: GLenum, pixels: PGLvoid){.stdcall, importc, ogl.}
proc glTextureSubImage1DEXT*(texture: GLuint, target: GLenum, level: GLint, 
                             xoffset: GLint, width: GLsizei, format: GLenum, 
                             typ: GLenum, pixels: PGLvoid){.stdcall, importc, ogl.}
proc glTextureSubImage2DEXT*(texture: GLuint, target: GLenum, level: GLint, 
                             xoffset: GLint, yoffset: GLint, width: GLsizei, 
                             height: GLsizei, format: GLenum, typ: GLenum, 
                             pixels: PGLvoid){.stdcall, importc, ogl.}
proc glCopyTextureImage1DEXT*(texture: GLuint, target: GLenum, level: GLint, 
                              internalformat: GLenum, x: GLint, y: GLint, 
                              width: GLsizei, border: GLint){.stdcall, importc, ogl.}
proc glCopyTextureImage2DEXT*(texture: GLuint, target: GLenum, level: GLint, 
                              internalformat: GLenum, x: GLint, y: GLint, 
                              width: GLsizei, height: GLsizei, border: GLint){.
    stdcall, importc, ogl.}
proc glCopyTextureSubImage1DEXT*(texture: GLuint, target: GLenum, level: GLint, 
                                 xoffset: GLint, x: GLint, y: GLint, 
                                 width: GLsizei){.stdcall, importc, ogl.}
proc glCopyTextureSubImage2DEXT*(texture: GLuint, target: GLenum, level: GLint, 
                                 xoffset: GLint, yoffset: GLint, x: GLint, 
                                 y: GLint, width: GLsizei, height: GLsizei){.
    stdcall, importc, ogl.}
proc glGetTextureImageEXT*(texture: GLuint, target: GLenum, level: GLint, 
                           format: GLenum, typ: GLenum, pixels: PGLvoid){.
    stdcall, importc, ogl.}
proc glGetTextureParameterfvEXT*(texture: GLuint, target: GLenum, pname: GLenum, 
                                 params: PGLfloat){.stdcall, importc, ogl.}
proc glGetTextureParameterivEXT*(texture: GLuint, target: GLenum, pname: GLenum, 
                                 params: PGLint){.stdcall, importc, ogl.}
proc glGetTextureLevelParameterfvEXT*(texture: GLuint, target: GLenum, 
                                      level: GLint, pname: GLenum, 
                                      params: PGLfloat){.stdcall, importc, ogl.}
proc glGetTextureLevelParameterivEXT*(texture: GLuint, target: GLenum, 
                                      level: GLint, pname: GLenum, params: GLint){.
    stdcall, importc, ogl.}
proc glTextureImage3DEXT*(texture: GLuint, target: GLenum, level: GLint, 
                          internalformat: GLenum, width: GLsizei, 
                          height: GLsizei, depth: GLsizei, border: GLint, 
                          format: GLenum, typ: GLenum, pixels: PGLvoid){.stdcall, importc, ogl.}
proc glTextureSubImage3DEXT*(texture: GLuint, target: GLenum, level: GLint, 
                             xoffset: GLint, yoffset: GLint, zoffset: GLint, 
                             width: GLsizei, height: GLsizei, depth: GLsizei, 
                             format: GLenum, typ: GLenum, pixels: PGLvoid){.
    stdcall, importc, ogl.}
proc glCopyTextureSubImage3DEXT*(texture: GLuint, target: GLenum, level: GLint, 
                                 xoffset: GLint, yoffset: GLint, zoffset: GLint, 
                                 x: GLint, y: GLint, width: GLsizei, 
                                 height: GLsizei){.stdcall, importc, ogl.}
proc glMultiTexParameterfEXT*(texunit: GLenum, target: GLenum, pname: GLenum, 
                              param: GLfloat){.stdcall, importc, ogl.}
proc glMultiTexParameterfvEXT*(texunit: GLenum, target: GLenum, pname: GLenum, 
                               params: PGLfloat){.stdcall, importc, ogl.}
proc glMultiTexParameteriEXT*(texunit: GLenum, target: GLenum, pname: GLenum, 
                              param: GLint){.stdcall, importc, ogl.}
proc glMultiTexParameterivEXT*(texunit: GLenum, target: GLenum, pname: GLenum, 
                               params: PGLint){.stdcall, importc, ogl.}
proc glMultiTexImage1DEXT*(texunit: GLenum, target: GLenum, level: GLint, 
                           internalformat: GLenum, width: GLsizei, 
                           border: GLint, format: GLenum, typ: GLenum, 
                           pixels: PGLvoid){.stdcall, importc, ogl.}
proc glMultiTexImage2DEXT*(texunit: GLenum, target: GLenum, level: GLint, 
                           internalformat: GLenum, width: GLsizei, 
                           height: GLsizei, border: GLint, format: GLenum, 
                           typ: GLenum, pixels: PGLvoid){.stdcall, importc, ogl.}
proc glMultiTexSubImage1DEXT*(texunit: GLenum, target: GLenum, level: GLint, 
                              xoffset: GLint, width: GLsizei, format: GLenum, 
                              typ: GLenum, pixels: PGLvoid){.stdcall, importc, ogl.}
proc glMultiTexSubImage2DEXT*(texunit: GLenum, target: GLenum, level: GLint, 
                              xoffset: GLint, yoffset: GLint, width: GLsizei, 
                              height: GLsizei, format: GLenum, typ: GLenum, 
                              pixels: PGLvoid){.stdcall, importc, ogl.}
proc glCopyMultiTexImage1DEXT*(texunit: GLenum, target: GLenum, level: GLint, 
                               internalformat: GLenum, x: GLint, y: GLint, 
                               width: GLsizei, border: GLint){.stdcall, importc, ogl.}
proc glCopyMultiTexImage2DEXT*(texunit: GLenum, target: GLenum, level: GLint, 
                               internalformat: GLenum, x: GLint, y: GLint, 
                               width: GLsizei, height: GLsizei, border: GLint){.
    stdcall, importc, ogl.}
proc glCopyMultiTexSubImage1DEXT*(texunit: GLenum, target: GLenum, level: GLint, 
                                  xoffset: GLint, x: GLint, y: GLint, 
                                  width: GLsizei){.stdcall, importc, ogl.}
proc glCopyMultiTexSubImage2DEXT*(texunit: GLenum, target: GLenum, level: GLint, 
                                  xoffset: GLint, yoffset: GLint, x: GLint, 
                                  y: GLint, width: GLsizei, height: GLsizei){.
    stdcall, importc, ogl.}
proc glGetMultiTexImageEXT*(texunit: GLenum, target: GLenum, level: GLint, 
                            format: GLenum, typ: GLenum, pixels: PGLvoid){.
    stdcall, importc, ogl.}
proc glGetMultiTexParameterfvEXT*(texunit: GLenum, target: GLenum, 
                                  pname: GLenum, params: PGLfloat){.stdcall, importc, ogl.}
proc glGetMultiTexParameterivEXT*(texunit: GLenum, target: GLenum, 
                                  pname: GLenum, params: PGLint){.stdcall, importc, ogl.}
proc glGetMultiTexLevelParameterfvEXT*(texunit: GLenum, target: GLenum, 
                                       level: GLint, pname: GLenum, 
                                       params: PGLfloat){.stdcall, importc, ogl.}
proc glGetMultiTexLevelParameterivEXT*(texunit: GLenum, target: GLenum, 
                                       level: GLint, pname: GLenum, 
                                       params: PGLint){.stdcall, importc, ogl.}
proc glMultiTexImage3DEXT*(texunit: GLenum, target: GLenum, level: GLint, 
                           internalformat: GLenum, width: GLsizei, 
                           height: GLsizei, depth: GLsizei, border: GLint, 
                           format: GLenum, typ: GLenum, pixels: PGLvoid){.
    stdcall, importc, ogl.}
proc glMultiTexSubImage3DEXT*(texunit: GLenum, target: GLenum, level: GLint, 
                              xoffset: GLint, yoffset: GLint, zoffset: GLint, 
                              width: GLsizei, height: GLsizei, depth: GLsizei, 
                              format: GLenum, typ: GLenum, pixels: PGLvoid){.
    stdcall, importc, ogl.}
proc glCopyMultiTexSubImage3DEXT*(texunit: GLenum, target: GLenum, level: GLint, 
                                  xoffset: GLint, yoffset: GLint, 
                                  zoffset: GLint, x: GLint, y: GLint, 
                                  width: GLsizei, height: GLsizei){.stdcall, importc, ogl.}
proc glBindMultiTextureEXT*(texunit: GLenum, target: GLenum, texture: GLuint){.
    stdcall, importc, ogl.}
proc glEnableClientStateIndexedEXT*(arr: GLenum, index: GLuint){.stdcall, importc, ogl.}
proc glDisableClientStateIndexedEXT*(arr: GLenum, index: GLuint){.stdcall, importc, ogl.}
proc glMultiTexCoordPointerEXT*(texunit: GLenum, size: GLint, typ: GLenum, 
                                stride: GLsizei, pointer: PGLvoid){.stdcall, importc, ogl.}
proc glMultiTexEnvfEXT*(texunit: GLenum, target: GLenum, pname: GLenum, 
                        param: GLfloat){.stdcall, importc, ogl.}
proc glMultiTexEnvfvEXT*(texunit: GLenum, target: GLenum, pname: GLenum, 
                         params: PGLfloat){.stdcall, importc, ogl.}
proc glMultiTexEnviEXT*(texunit: GLenum, target: GLenum, pname: GLenum, 
                        param: GLint){.stdcall, importc, ogl.}
proc glMultiTexEnvivEXT*(texunit: GLenum, target: GLenum, pname: GLenum, 
                         params: PGLint){.stdcall, importc, ogl.}
proc glMultiTexGendEXT*(texunit: GLenum, target: GLenum, pname: GLenum, 
                        param: GLdouble){.stdcall, importc, ogl.}
proc glMultiTexGendvEXT*(texunit: GLenum, target: GLenum, pname: GLenum, 
                         params: PGLdouble){.stdcall, importc, ogl.}
proc glMultiTexGenfEXT*(texunit: GLenum, target: GLenum, pname: GLenum, 
                        param: GLfloat){.stdcall, importc, ogl.}
proc glMultiTexGenfvEXT*(texunit: GLenum, target: GLenum, pname: GLenum, 
                         params: PGLfloat){.stdcall, importc, ogl.}
proc glMultiTexGeniEXT*(texunit: GLenum, target: GLenum, pname: GLenum, 
                        param: GLint){.stdcall, importc, ogl.}
proc glMultiTexGenivEXT*(texunit: GLenum, target: GLenum, pname: GLenum, 
                         params: PGLint){.stdcall, importc, ogl.}
proc glGetMultiTexEnvfvEXT*(texunit: GLenum, target: GLenum, pname: GLenum, 
                            params: PGLfloat){.stdcall, importc, ogl.}
proc glGetMultiTexEnvivEXT*(texunit: GLenum, target: GLenum, pname: GLenum, 
                            params: PGLint){.stdcall, importc, ogl.}
proc glGetMultiTexGendvEXT*(texunit: GLenum, coord: GLenum, pname: GLenum, 
                            params: PGLdouble){.stdcall, importc, ogl.}
proc glGetMultiTexGenfvEXT*(texunit: GLenum, coord: GLenum, pname: GLenum, 
                            params: PGLfloat){.stdcall, importc, ogl.}
proc glGetMultiTexGenivEXT*(texunit: GLenum, coord: GLenum, pname: GLenum, 
                            params: PGLint){.stdcall, importc, ogl.}
proc glGetFloatIndexedvEXT*(target: GLenum, index: GLuint, data: PGLfloat){.
    stdcall, importc, ogl.}
proc glGetDoubleIndexedvEXT*(target: GLenum, index: GLuint, data: PGLdouble){.
    stdcall, importc, ogl.}
proc glGetPointerIndexedvEXT*(target: GLenum, index: GLuint, data: PPGLvoid){.
    stdcall, importc, ogl.}
proc glCompressedTextureImage3DEXT*(texture: GLuint, target: GLenum, 
                                    level: GLint, internalformat: GLenum, 
                                    width: GLsizei, height: GLsizei, 
                                    depth: GLsizei, border: GLint, 
                                    imageSize: GLsizei, bits: PGLvoid){.stdcall, importc, ogl.}
proc glCompressedTextureImage2DEXT*(texture: GLuint, target: GLenum, 
                                    level: GLint, internalformat: GLenum, 
                                    width: GLsizei, height: GLsizei, 
                                    border: GLint, imageSize: GLsizei, 
                                    bits: PGLvoid){.stdcall, importc, ogl.}
proc glCompressedTextureImage1DEXT*(texture: GLuint, target: GLenum, 
                                    level: GLint, internalformat: GLenum, 
                                    width: GLsizei, border: GLint, 
                                    imageSize: GLsizei, bits: PGLvoid){.stdcall, importc, ogl.}
proc glCompressedTextureSubImage3DEXT*(texture: GLuint, target: GLenum, 
                                       level: GLint, xoffset: GLint, 
                                       yoffset: GLint, zoffset: GLint, 
                                       width: GLsizei, height: GLsizei, 
                                       depth: GLsizei, format: GLenum, 
                                       imageSize: GLsizei, bits: PGLvoid){.
    stdcall, importc, ogl.}
proc glCompressedTextureSubImage2DEXT*(texture: GLuint, target: GLenum, 
                                       level: GLint, xoffset: GLint, 
                                       yoffset: GLint, width: GLsizei, 
                                       height: GLsizei, format: GLenum, 
                                       imageSize: GLsizei, bits: PGLvoid){.
    stdcall, importc, ogl.}
proc glCompressedTextureSubImage1DEXT*(texture: GLuint, target: GLenum, 
                                       level: GLint, xoffset: GLint, 
                                       width: GLsizei, format: GLenum, 
                                       imageSize: GLsizei, bits: PGLvoid){.
    stdcall, importc, ogl.}
proc glGetCompressedTextureImageEXT*(texture: GLuint, target: GLenum, 
                                     lod: GLint, img: PGLvoid){.stdcall, importc, ogl.}
proc glCompressedMultiTexImage3DEXT*(texunit: GLenum, target: GLenum, 
                                     level: GLint, internalformat: GLenum, 
                                     width: GLsizei, height: GLsizei, 
                                     depth: GLsizei, border: GLint, 
                                     imageSize: GLsizei, bits: PGLvoid){.stdcall, importc, ogl.}
proc glCompressedMultiTexImage2DEXT*(texunit: GLenum, target: GLenum, 
                                     level: GLint, internalformat: GLenum, 
                                     width: GLsizei, height: GLsizei, 
                                     border: GLint, imageSize: GLsizei, 
                                     bits: PGLvoid){.stdcall, importc, ogl.}
proc glCompressedMultiTexImage1DEXT*(texunit: GLenum, target: GLenum, 
                                     level: GLint, internalformat: GLenum, 
                                     width: GLsizei, border: GLint, 
                                     imageSize: GLsizei, bits: PGLvoid){.stdcall, importc, ogl.}
proc glCompressedMultiTexSubImage3DEXT*(texunit: GLenum, target: GLenum, 
                                        level: GLint, xoffset: GLint, 
                                        yoffset: GLint, zoffset: GLint, 
                                        width: GLsizei, height: GLsizei, 
                                        depth: GLsizei, format: GLenum, 
                                        imageSize: GLsizei, bits: PGLvoid){.
    stdcall, importc, ogl.}
proc glCompressedMultiTexSubImage2DEXT*(texunit: GLenum, target: GLenum, 
                                        level: GLint, xoffset: GLint, 
                                        yoffset: GLint, width: GLsizei, 
                                        height: GLsizei, format: GLenum, 
                                        imageSize: GLsizei, bits: PGLvoid){.
    stdcall, importc, ogl.}
proc glCompressedMultiTexSubImage1DEXT*(texunit: GLenum, target: GLenum, 
                                        level: GLint, xoffset: GLint, 
                                        width: GLsizei, format: GLenum, 
                                        imageSize: GLsizei, bits: PGLvoid){.
    stdcall, importc, ogl.}
proc glGetCompressedMultiTexImageEXT*(texunit: GLenum, target: GLenum, 
                                      lod: GLint, img: PGLvoid){.stdcall, importc, ogl.}
proc glNamedProgramStringEXT*(prog: GLuint, target: GLenum, format: GLenum, 
                              length: GLsizei, string: PGLvoid){.stdcall, importc, ogl.}
proc glNamedProgramLocalParameter4dEXT*(prog: GLuint, target: GLenum, 
                                        index: GLuint, x: GLdouble, y: GLdouble, 
                                        z: GLdouble, w: GLdouble){.stdcall, importc, ogl.}
proc glNamedProgramLocalParameter4dvEXT*(prog: GLuint, target: GLenum, 
    index: GLuint, params: PGLdouble){.stdcall, importc, ogl.}
proc glNamedProgramLocalParameter4fEXT*(prog: GLuint, target: GLenum, 
                                        index: GLuint, x: GLfloat, y: GLfloat, 
                                        z: GLfloat, w: GLfloat){.stdcall, importc, ogl.}
proc glNamedProgramLocalParameter4fvEXT*(prog: GLuint, target: GLenum, 
    index: GLuint, params: PGLfloat){.stdcall, importc, ogl.}
proc glGetNamedProgramLocalParameterdvEXT*(prog: GLuint, target: GLenum, 
    index: GLuint, params: PGLdouble){.stdcall, importc, ogl.}
proc glGetNamedProgramLocalParameterfvEXT*(prog: GLuint, target: GLenum, 
    index: GLuint, params: PGLfloat){.stdcall, importc, ogl.}
proc glGetNamedProgramivEXT*(prog: GLuint, target: GLenum, pname: GLenum, 
                             params: PGLint){.stdcall, importc, ogl.}
proc glGetNamedProgramStringEXT*(prog: GLuint, target: GLenum, pname: GLenum, 
                                 string: PGLvoid){.stdcall, importc, ogl.}
proc glNamedProgramLocalParameters4fvEXT*(prog: GLuint, target: GLenum, 
    index: GLuint, count: GLsizei, params: PGLfloat){.stdcall, importc, ogl.}
proc glNamedProgramLocalParameterI4iEXT*(prog: GLuint, target: GLenum, 
    index: GLuint, x: GLint, y: GLint, z: GLint, w: GLint){.stdcall, importc, ogl.}
proc glNamedProgramLocalParameterI4ivEXT*(prog: GLuint, target: GLenum, 
    index: GLuint, params: PGLint){.stdcall, importc, ogl.}
proc glNamedProgramLocalParametersI4ivEXT*(prog: GLuint, target: GLenum, 
    index: GLuint, count: GLsizei, params: PGLint){.stdcall, importc, ogl.}
proc glNamedProgramLocalParameterI4uiEXT*(prog: GLuint, target: GLenum, 
    index: GLuint, x: GLuint, y: GLuint, z: GLuint, w: GLuint){.stdcall, importc, ogl.}
proc glNamedProgramLocalParameterI4uivEXT*(prog: GLuint, target: GLenum, 
    index: GLuint, params: PGLuint){.stdcall, importc, ogl.}
proc glNamedProgramLocalParametersI4uivEXT*(prog: GLuint, target: GLenum, 
    index: GLuint, count: GLsizei, params: PGLuint){.stdcall, importc, ogl.}
proc glGetNamedProgramLocalParameterIivEXT*(prog: GLuint, target: GLenum, 
    index: GLuint, params: PGLint){.stdcall, importc, ogl.}
proc glGetNamedProgramLocalParameterIuivEXT*(prog: GLuint, target: GLenum, 
    index: GLuint, params: PGLuint){.stdcall, importc, ogl.}
proc glTextureParameterIivEXT*(texture: GLuint, target: GLenum, pname: GLenum, 
                               params: PGLint){.stdcall, importc, ogl.}
proc glTextureParameterIuivEXT*(texture: GLuint, target: GLenum, pname: GLenum, 
                                params: PGLuint){.stdcall, importc, ogl.}
proc glGetTextureParameterIivEXT*(texture: GLuint, target: GLenum, 
                                  pname: GLenum, params: PGLint){.stdcall, importc, ogl.}
proc glGetTextureParameterIuivEXT*(texture: GLuint, target: GLenum, 
                                   pname: GLenum, params: PGLuint){.stdcall, importc, ogl.}
proc glMultiTexParameterIivEXT*(texture: GLuint, target: GLenum, pname: GLenum, 
                                params: PGLint){.stdcall, importc, ogl.}
proc glMultiTexParameterIuivEXT*(texture: GLuint, target: GLenum, pname: GLenum, 
                                 params: PGLuint){.stdcall, importc, ogl.}
proc glGetMultiTexParameterIivEXT*(texture: GLuint, target: GLenum, 
                                   pname: GLenum, params: PGLint){.stdcall, importc, ogl.}
proc glGetMultiTexParameterIuivEXT*(texture: GLuint, target: GLenum, 
                                    pname: GLenum, params: PGLuint){.stdcall, importc, ogl.}
proc glProgramUniform1fEXT*(prog: GLuint, location: GLint, v0: GLfloat){.stdcall, importc, ogl.}
proc glProgramUniform2fEXT*(prog: GLuint, location: GLint, v0: GLfloat, 
                            v1: GLfloat){.stdcall, importc, ogl.}
proc glProgramUniform3fEXT*(prog: GLuint, location: GLint, v0: GLfloat, 
                            v1: GLfloat, v2: GLfloat){.stdcall, importc, ogl.}
proc glProgramUniform4fEXT*(prog: GLuint, location: GLint, v0: GLfloat, 
                            v1: GLfloat, v2: GLfloat, v3: GLfloat){.stdcall, importc, ogl.}
proc glProgramUniform1iEXT*(prog: GLuint, location: GLint, v0: GLint){.stdcall, importc, ogl.}
proc glProgramUniform2iEXT*(prog: GLuint, location: GLint, v0: GLint, v1: GLint){.
    stdcall, importc, ogl.}
proc glProgramUniform3iEXT*(prog: GLuint, location: GLint, v0: GLint, v1: GLint, 
                            v2: GLint){.stdcall, importc, ogl.}
proc glProgramUniform4iEXT*(prog: GLuint, location: GLint, v0: GLint, v1: GLint, 
                            v2: GLint, v3: GLint){.stdcall, importc, ogl.}
proc glProgramUniform1fvEXT*(prog: GLuint, location: GLint, count: GLsizei, 
                             value: PGLfloat){.stdcall, importc, ogl.}
proc glProgramUniform2fvEXT*(prog: GLuint, location: GLint, count: GLsizei, 
                             value: PGLfloat){.stdcall, importc, ogl.}
proc glProgramUniform3fvEXT*(prog: GLuint, location: GLint, count: GLsizei, 
                             value: PGLfloat){.stdcall, importc, ogl.}
proc glProgramUniform4fvEXT*(prog: GLuint, location: GLint, count: GLsizei, 
                             value: PGLfloat){.stdcall, importc, ogl.}
proc glProgramUniform1ivEXT*(prog: GLuint, location: GLint, count: GLsizei, 
                             value: PGLint){.stdcall, importc, ogl.}
proc glProgramUniform2ivEXT*(prog: GLuint, location: GLint, count: GLsizei, 
                             value: PGLint){.stdcall, importc, ogl.}
proc glProgramUniform3ivEXT*(prog: GLuint, location: GLint, count: GLsizei, 
                             value: PGLint){.stdcall, importc, ogl.}
proc glProgramUniform4ivEXT*(prog: GLuint, location: GLint, count: GLsizei, 
                             value: PGLint){.stdcall, importc, ogl.}
proc glProgramUniformMatrix2fvEXT*(prog: GLuint, location: GLint, 
                                   count: GLsizei, transpose: GLboolean, 
                                   value: PGLfloat){.stdcall, importc, ogl.}
proc glProgramUniformMatrix3fvEXT*(prog: GLuint, location: GLint, 
                                   count: GLsizei, transpose: GLboolean, 
                                   value: PGLfloat){.stdcall, importc, ogl.}
proc glProgramUniformMatrix4fvEXT*(prog: GLuint, location: GLint, 
                                   count: GLsizei, transpose: GLboolean, 
                                   value: PGLfloat){.stdcall, importc, ogl.}
proc glProgramUniformMatrix2x3fvEXT*(prog: GLuint, location: GLint, 
                                     count: GLsizei, transpose: GLboolean, 
                                     value: PGLfloat){.stdcall, importc, ogl.}
proc glProgramUniformMatrix3x2fvEXT*(prog: GLuint, location: GLint, 
                                     count: GLsizei, transpose: GLboolean, 
                                     value: PGLfloat){.stdcall, importc, ogl.}
proc glProgramUniformMatrix2x4fvEXT*(prog: GLuint, location: GLint, 
                                     count: GLsizei, transpose: GLboolean, 
                                     value: PGLfloat){.stdcall, importc, ogl.}
proc glProgramUniformMatrix4x2fvEXT*(prog: GLuint, location: GLint, 
                                     count: GLsizei, transpose: GLboolean, 
                                     value: PGLfloat){.stdcall, importc, ogl.}
proc glProgramUniformMatrix3x4fvEXT*(prog: GLuint, location: GLint, 
                                     count: GLsizei, transpose: GLboolean, 
                                     value: PGLfloat){.stdcall, importc, ogl.}
proc glProgramUniformMatrix4x3fvEXT*(prog: GLuint, location: GLint, 
                                     count: GLsizei, transpose: GLboolean, 
                                     value: PGLfloat){.stdcall, importc, ogl.}
proc glProgramUniform1uiEXT*(prog: GLuint, location: GLint, v0: GLuint){.stdcall, importc, ogl.}
proc glProgramUniform2uiEXT*(prog: GLuint, location: GLint, v0: GLuint, 
                             v1: GLuint){.stdcall, importc, ogl.}
proc glProgramUniform3uiEXT*(prog: GLuint, location: GLint, v0: GLuint, 
                             v1: GLuint, v2: GLuint){.stdcall, importc, ogl.}
proc glProgramUniform4uiEXT*(prog: GLuint, location: GLint, v0: GLuint, 
                             v1: GLuint, v2: GLuint, v3: GLuint){.stdcall, importc, ogl.}
proc glProgramUniform1uivEXT*(prog: GLuint, location: GLint, count: GLsizei, 
                              value: PGLuint){.stdcall, importc, ogl.}
proc glProgramUniform2uivEXT*(prog: GLuint, location: GLint, count: GLsizei, 
                              value: PGLuint){.stdcall, importc, ogl.}
proc glProgramUniform3uivEXT*(prog: GLuint, location: GLint, count: GLsizei, 
                              value: PGLuint){.stdcall, importc, ogl.}
proc glProgramUniform4uivEXT*(prog: GLuint, location: GLint, count: GLsizei, 
                              value: PGLuint){.stdcall, importc, ogl.}
proc glNamedBufferDataEXT*(buffer: GLuint, size: GLsizei, data: PGLvoid, 
                           usage: GLenum){.stdcall, importc, ogl.}
proc glNamedBufferSubDataEXT*(buffer: GLuint, offset: GLintptr, 
                              size: GLsizeiptr, data: PGLvoid){.stdcall, importc, ogl.}
proc glMapNamedBufferEXT*(buffer: GLuint, access: GLenum): PGLvoid{.stdcall, importc, ogl.}
proc glUnmapNamedBufferEXT*(buffer: GLuint): GLboolean{.stdcall, importc, ogl.}
proc glMapNamedBufferRangeEXT*(buffer: GLuint, offset: GLintptr, 
                               len: GLsizeiptr, access: GLbitfield): PGLvoid{.
    stdcall, importc, ogl.}
proc glFlushMappedNamedBufferRangeEXT*(buffer: GLuint, offset: GLintptr, 
                                       len: GLsizeiptr){.stdcall, importc, ogl.}
proc glNamedCopyBufferSubDataEXT*(readBuffer: GLuint, writeBuffer: GLuint, 
                                  readOffset: GLintptr, writeOffset: GLintptr, 
                                  size: GLsizeiptr){.stdcall, importc, ogl.}
proc glGetNamedBufferParameterivEXT*(buffer: GLuint, pname: GLenum, 
                                     params: PGLint){.stdcall, importc, ogl.}
proc glGetNamedBufferPointervEXT*(buffer: GLuint, pname: GLenum, 
                                  params: PPGLvoid){.stdcall, importc, ogl.}
proc glGetNamedBufferSubDataEXT*(buffer: GLuint, offset: GLintptr, 
                                 size: GLsizeiptr, data: PGLvoid){.stdcall, importc, ogl.}
proc glTextureBufferEXT*(texture: GLuint, target: GLenum, 
                         internalformat: GLenum, buffer: GLuint){.stdcall, importc, ogl.}
proc glMultiTexBufferEXT*(texunit: GLenum, target: GLenum, interformat: GLenum, 
                          buffer: GLuint){.stdcall, importc, ogl.}
proc glNamedRenderbufferStorageEXT*(renderbuffer: GLuint, interformat: GLenum, 
                                    width: GLsizei, height: GLsizei){.stdcall, importc, ogl.}
proc glGetNamedRenderbufferParameterivEXT*(renderbuffer: GLuint, pname: GLenum, 
    params: PGLint){.stdcall, importc, ogl.}
proc glCheckNamedFramebufferStatusEXT*(framebuffer: GLuint, target: GLenum): GLenum{.
    stdcall, importc, ogl.}
proc glNamedFramebufferTexture1DEXT*(framebuffer: GLuint, attachment: GLenum, 
                                     textarget: GLenum, texture: GLuint, 
                                     level: GLint){.stdcall, importc, ogl.}
proc glNamedFramebufferTexture2DEXT*(framebuffer: GLuint, attachment: GLenum, 
                                     textarget: GLenum, texture: GLuint, 
                                     level: GLint){.stdcall, importc, ogl.}
proc glNamedFramebufferTexture3DEXT*(framebuffer: GLuint, attachment: GLenum, 
                                     textarget: GLenum, texture: GLuint, 
                                     level: GLint, zoffset: GLint){.stdcall, importc, ogl.}
proc glNamedFramebufferRenderbufferEXT*(framebuffer: GLuint, attachment: GLenum, 
                                        renderbuffertarget: GLenum, 
                                        renderbuffer: GLuint){.stdcall, importc, ogl.}
proc glGetNamedFramebufferAttachmentParameterivEXT*(framebuffer: GLuint, 
    attachment: GLenum, pname: GLenum, params: PGLint){.stdcall, importc, ogl.}
proc glGenerateTextureMipmapEXT*(texture: GLuint, target: GLenum){.stdcall, importc, ogl.}
proc glGenerateMultiTexMipmapEXT*(texunit: GLenum, target: GLenum){.stdcall, importc, ogl.}
proc glFramebufferDrawBufferEXT*(framebuffer: GLuint, mode: GLenum){.stdcall, importc, ogl.}
proc glFramebufferDrawBuffersEXT*(framebuffer: GLuint, n: GLsizei, bufs: PGLenum){.
    stdcall, importc, ogl.}
proc glFramebufferReadBufferEXT*(framebuffer: GLuint, mode: GLenum){.stdcall, importc, ogl.}
proc glGetFramebufferParameterivEXT*(framebuffer: GLuint, pname: GLenum, 
                                     params: PGLint){.stdcall, importc, ogl.}
proc glNamedRenderbufferStorageMultisampleEXT*(renderbuffer: GLuint, 
    samples: GLsizei, internalformat: GLenum, width: GLsizei, height: GLsizei){.
    stdcall, importc, ogl.}
proc glNamedRenderbufferStorageMultisampleCoverageEXT*(renderbuffer: GLuint, 
    coverageSamples: GLsizei, colorSamples: GLsizei, internalformat: GLenum, 
    width: GLsizei, height: GLsizei){.stdcall, importc, ogl.}
proc glNamedFramebufferTextureEXT*(framebuffer: GLuint, attachment: GLenum, 
                                   texture: GLuint, level: GLint){.stdcall, importc, ogl.}
proc glNamedFramebufferTextureLayerEXT*(framebuffer: GLuint, attachment: GLenum, 
                                        texture: GLuint, level: GLint, 
                                        layer: GLint){.stdcall, importc, ogl.}
proc glNamedFramebufferTextureFaceEXT*(framebuffer: GLuint, attachment: GLenum, 
                                       texture: GLuint, level: GLint, 
                                       face: GLenum){.stdcall, importc, ogl.}
proc glTextureRenderbufferEXT*(texture: GLuint, target: GLenum, 
                               renderbuffer: GLuint){.stdcall, importc, ogl.}
proc glMultiTexRenderbufferEXT*(texunit: GLenum, target: GLenum, 
                                renderbuffer: GLuint){.stdcall, importc, ogl.}
proc glProgramUniform1dEXT*(prog: GLuint, location: GLint, x: GLdouble){.stdcall, importc, ogl.}
proc glProgramUniform2dEXT*(prog: GLuint, location: GLint, x: GLdouble, 
                            y: GLdouble){.stdcall, importc, ogl.}
proc glProgramUniform3dEXT*(prog: GLuint, location: GLint, x: GLdouble, 
                            y: GLdouble, z: GLdouble){.stdcall, importc, ogl.}
proc glProgramUniform4dEXT*(prog: GLuint, location: GLint, x: GLdouble, 
                            y: GLdouble, z: GLdouble, w: GLdouble){.stdcall, importc, ogl.}
proc glProgramUniform1dvEXT*(prog: GLuint, location: GLint, count: GLsizei, 
                             value: PGLdouble){.stdcall, importc, ogl.}
proc glProgramUniform2dvEXT*(prog: GLuint, location: GLint, count: GLsizei, 
                             value: PGLdouble){.stdcall, importc, ogl.}
proc glProgramUniform3dvEXT*(prog: GLuint, location: GLint, count: GLsizei, 
                             value: PGLdouble){.stdcall, importc, ogl.}
proc glProgramUniform4dvEXT*(prog: GLuint, location: GLint, count: GLsizei, 
                             value: PGLdouble){.stdcall, importc, ogl.}
proc glProgramUniformMatrix2dvEXT*(prog: GLuint, location: GLint, 
                                   count: GLsizei, transpose: GLboolean, 
                                   value: PGLdouble){.stdcall, importc, ogl.}
proc glProgramUniformMatrix3dvEXT*(prog: GLuint, location: GLint, 
                                   count: GLsizei, transpose: GLboolean, 
                                   value: PGLdouble){.stdcall, importc, ogl.}
proc glProgramUniformMatrix4dvEXT*(prog: GLuint, location: GLint, 
                                   count: GLsizei, transpose: GLboolean, 
                                   value: PGLdouble){.stdcall, importc, ogl.}
proc glProgramUniformMatrix2x3dvEXT*(prog: GLuint, location: GLint, 
                                     count: GLsizei, transpose: GLboolean, 
                                     value: PGLdouble){.stdcall, importc, ogl.}
proc glProgramUniformMatrix2x4dvEXT*(prog: GLuint, location: GLint, 
                                     count: GLsizei, transpose: GLboolean, 
                                     value: PGLdouble){.stdcall, importc, ogl.}
proc glProgramUniformMatrix3x2dvEXT*(prog: GLuint, location: GLint, 
                                     count: GLsizei, transpose: GLboolean, 
                                     value: PGLdouble){.stdcall, importc, ogl.}
proc glProgramUniformMatrix3x4dvEXT*(prog: GLuint, location: GLint, 
                                     count: GLsizei, transpose: GLboolean, 
                                     value: PGLdouble){.stdcall, importc, ogl.}
proc glProgramUniformMatrix4x2dvEXT*(prog: GLuint, location: GLint, 
                                     count: GLsizei, transpose: GLboolean, 
                                     value: PGLdouble){.stdcall, importc, ogl.}
proc glProgramUniformMatrix4x3dvEXT*(prog: GLuint, location: GLint, 
                                     count: GLsizei, transpose: GLboolean, 
                                     value: PGLdouble){.stdcall, importc, ogl.}
  # GL_EXT_separate_shader_objects
proc glUseShaderProgramEXT*(typ: GLenum, prog: GLuint){.stdcall, importc, ogl.}
proc glActiveProgramEXT*(prog: GLuint){.stdcall, importc, ogl.}
proc glCreateShaderProgramEXT*(typ: GLenum, string: PGLchar): GLuint{.stdcall, importc, ogl.}
  # GL_EXT_shader_image_load_store
proc glBindImageTextureEXT*(index: GLuint, texture: GLuint, level: GLint, 
                            layered: GLboolean, layer: GLint, access: GLenum, 
                            format: GLint){.stdcall, importc, ogl.}
proc glMemoryBarrierEXT*(barriers: GLbitfield){.stdcall, importc, ogl.}
  # GL_EXT_vertex_attrib_64bit
proc glVertexAttribL1dEXT*(index: GLuint, x: GLdouble){.stdcall, importc, ogl.}
proc glVertexAttribL2dEXT*(index: GLuint, x: GLdouble, y: GLdouble){.stdcall, importc, ogl.}
proc glVertexAttribL3dEXT*(index: GLuint, x: GLdouble, y: GLdouble, z: GLdouble){.
    stdcall, importc, ogl.}
proc glVertexAttribL4dEXT*(index: GLuint, x: GLdouble, y: GLdouble, z: GLdouble, 
                           w: GLdouble){.stdcall, importc, ogl.}
proc glVertexAttribL1dvEXT*(index: GLuint, v: PGLdouble){.stdcall, importc, ogl.}
proc glVertexAttribL2dvEXT*(index: GLuint, v: PGLdouble){.stdcall, importc, ogl.}
proc glVertexAttribL3dvEXT*(index: GLuint, v: PGLdouble){.stdcall, importc, ogl.}
proc glVertexAttribL4dvEXT*(index: GLuint, v: PGLdouble){.stdcall, importc, ogl.}
proc glVertexAttribLPointerEXT*(index: GLuint, size: GLint, typ: GLenum, 
                                stride: GLsizei, pointer: PGLvoid){.stdcall, importc, ogl.}
proc glGetVertexAttribLdvEXT*(index: GLuint, pname: GLenum, params: PGLdouble){.
    stdcall, importc, ogl.}
proc glVertexArrayVertexAttribLOffsetEXT*(vaobj: GLuint, buffer: GLuint, 
    index: GLuint, size: GLint, typ: GLenum, stride: GLsizei, offset: GLintptr){.
    stdcall, importc, ogl.}
  # GL_IBM_multimode_draw_arrays
proc glMultiModeDrawArraysIBM*(mode: GLenum, first: PGLint, count: PGLsizei, 
                               primcount: GLsizei, modestride: GLint){.stdcall, importc, ogl.}
proc glMultiModeDrawElementsIBM*(mode: PGLenum, count: PGLsizei, typ: GLenum, 
                                 indices: PGLvoid, primcount: GLsizei, 
                                 modestride: GLint){.stdcall, importc, ogl.}
  # GL_IBM_vertex_array_lists
proc glColorPointerListIBM*(size: GLint, typ: GLenum, stride: GLint, 
                            pointer: PGLvoid, ptrstride: GLint){.stdcall, importc, ogl.}
proc glSecondaryColorPointerListIBM*(size: GLint, typ: GLenum, stride: GLint, 
                                     pointer: PGLvoid, ptrstride: GLint){.
    stdcall, importc, ogl.}
proc glEdgeFlagPointerListIBM*(stride: GLint, pointer: PGLboolean, 
                               ptrstride: GLint){.stdcall, importc, ogl.}
proc glFogCoordPointerListIBM*(typ: GLenum, stride: GLint, pointer: PGLvoid, 
                               ptrstride: GLint){.stdcall, importc, ogl.}
proc glIndexPointerListIBM*(typ: GLenum, stride: GLint, pointer: PGLvoid, 
                            ptrstride: GLint){.stdcall, importc, ogl.}
proc glNormalPointerListIBM*(typ: GLenum, stride: GLint, pointer: PGLvoid, 
                             ptrstride: GLint){.stdcall, importc, ogl.}
proc glTexCoordPointerListIBM*(size: GLint, typ: GLenum, stride: GLint, 
                               pointer: PGLvoid, ptrstride: GLint){.stdcall, importc, ogl.}
proc glVertexPointerListIBM*(size: GLint, typ: GLenum, stride: GLint, 
                             pointer: PGLvoid, ptrstride: GLint){.stdcall, importc, ogl.}
  # GL_INGR_blend_func_separate
proc glBlendFuncSeparateINGR*(sfactorRGB: GLenum, dfactorRGB: GLenum, 
                              sfactorAlpha: GLenum, dfactorAlpha: GLenum){.
    stdcall, importc, ogl.}
  # GL_INTEL_parallel_arrays
proc glVertexPointervINTEL*(size: GLint, typ: GLenum, pointer: PGLvoid){.stdcall, importc, ogl.}
proc glNormalPointervINTEL*(typ: GLenum, pointer: PGLvoid){.stdcall, importc, ogl.}
proc glColorPointervINTEL*(size: GLint, typ: GLenum, pointer: PGLvoid){.stdcall, importc, ogl.}
proc glTexCoordPointervINTEL*(size: GLint, typ: GLenum, pointer: PGLvoid){.
    stdcall, importc, ogl.}
  # GL_MESA_resize_buffers
proc glResizeBuffersMESA*(){.stdcall, importc, ogl.}
  # GL_MESA_window_pos
proc glWindowPos2dMESA*(x: GLdouble, y: GLdouble){.stdcall, importc, ogl.}
proc glWindowPos2dvMESA*(v: PGLdouble){.stdcall, importc, ogl.}
proc glWindowPos2fMESA*(x: GLfloat, y: GLfloat){.stdcall, importc, ogl.}
proc glWindowPos2fvMESA*(v: PGLfloat){.stdcall, importc, ogl.}
proc glWindowPos2iMESA*(x: GLint, y: GLint){.stdcall, importc, ogl.}
proc glWindowPos2ivMESA*(v: PGLint){.stdcall, importc, ogl.}
proc glWindowPos2sMESA*(x: GLshort, y: GLshort){.stdcall, importc, ogl.}
proc glWindowPos2svMESA*(v: PGLshort){.stdcall, importc, ogl.}
proc glWindowPos3dMESA*(x: GLdouble, y: GLdouble, z: GLdouble){.stdcall, importc, ogl.}
proc glWindowPos3dvMESA*(v: PGLdouble){.stdcall, importc, ogl.}
proc glWindowPos3fMESA*(x: GLfloat, y: GLfloat, z: GLfloat){.stdcall, importc, ogl.}
proc glWindowPos3fvMESA*(v: PGLfloat){.stdcall, importc, ogl.}
proc glWindowPos3iMESA*(x: GLint, y: GLint, z: GLint){.stdcall, importc, ogl.}
proc glWindowPos3ivMESA*(v: PGLint){.stdcall, importc, ogl.}
proc glWindowPos3sMESA*(x: GLshort, y: GLshort, z: GLshort){.stdcall, importc, ogl.}
proc glWindowPos3svMESA*(v: PGLshort){.stdcall, importc, ogl.}
proc glWindowPos4dMESA*(x: GLdouble, y: GLdouble, z: GLdouble, w: GLdouble){.
    stdcall, importc, ogl.}
proc glWindowPos4dvMESA*(v: PGLdouble){.stdcall, importc, ogl.}
proc glWindowPos4fMESA*(x: GLfloat, y: GLfloat, z: GLfloat, w: GLfloat){.stdcall, importc, ogl.}
proc glWindowPos4fvMESA*(v: PGLfloat){.stdcall, importc, ogl.}
proc glWindowPos4iMESA*(x: GLint, y: GLint, z: GLint, w: GLint){.stdcall, importc, ogl.}
proc glWindowPos4ivMESA*(v: PGLint){.stdcall, importc, ogl.}
proc glWindowPos4sMESA*(x: GLshort, y: GLshort, z: GLshort, w: GLshort){.stdcall, importc, ogl.}
proc glWindowPos4svMESA*(v: PGLshort){.stdcall, importc, ogl.}
  # GL_NV_evaluators
proc glMapControlPointsNV*(target: GLenum, index: GLuint, typ: GLenum, 
                           ustride: GLsizei, vstride: GLsizei, uorder: GLint, 
                           vorder: GLint, pack: GLboolean, points: PGLvoid){.
    stdcall, importc, ogl.}
proc glMapParameterivNV*(target: GLenum, pname: GLenum, params: PGLint){.stdcall, importc, ogl.}
proc glMapParameterfvNV*(target: GLenum, pname: GLenum, params: PGLfloat){.
    stdcall, importc, ogl.}
proc glGetMapControlPointsNV*(target: GLenum, index: GLuint, typ: GLenum, 
                              ustride: GLsizei, vstride: GLsizei, 
                              pack: GLboolean, points: PGLvoid){.stdcall, importc, ogl.}
proc glGetMapParameterivNV*(target: GLenum, pname: GLenum, params: PGLint){.
    stdcall, importc, ogl.}
proc glGetMapParameterfvNV*(target: GLenum, pname: GLenum, params: PGLfloat){.
    stdcall, importc, ogl.}
proc glGetMapAttribParameterivNV*(target: GLenum, index: GLuint, pname: GLenum, 
                                  params: PGLint){.stdcall, importc, ogl.}
proc glGetMapAttribParameterfvNV*(target: GLenum, index: GLuint, pname: GLenum, 
                                  params: PGLfloat){.stdcall, importc, ogl.}
proc glEvalMapsNV*(target: GLenum, mode: GLenum){.stdcall, importc, ogl.}
  # GL_NV_fence
proc glDeleteFencesNV*(n: GLsizei, fences: PGLuint){.stdcall, importc, ogl.}
proc glGenFencesNV*(n: GLsizei, fences: PGLuint){.stdcall, importc, ogl.}
proc glIsFenceNV*(fence: GLuint): GLboolean{.stdcall, importc, ogl.}
proc glTestFenceNV*(fence: GLuint): GLboolean{.stdcall, importc, ogl.}
proc glGetFenceivNV*(fence: GLuint, pname: GLenum, params: PGLint){.stdcall, importc, ogl.}
proc glFinishFenceNV*(fence: GLuint){.stdcall, importc, ogl.}
proc glSetFenceNV*(fence: GLuint, condition: GLenum){.stdcall, importc, ogl.}
  # GL_NV_fragment_prog
proc glProgramNamedParameter4fNV*(id: GLuint, length: GLsizei, name: PGLubyte, 
                                  x: GLfloat, y: GLfloat, z: GLfloat, w: GLfloat){.
    stdcall, importc, ogl.}
proc glProgramNamedParameter4dNV*(id: GLuint, length: GLsizei, name: PGLubyte, 
                                  x: GLdouble, y: GLdouble, z: GLdouble, 
                                  w: GLdouble){.stdcall, importc, ogl.}
proc glProgramNamedParameter4fvNV*(id: GLuint, length: GLsizei, name: PGLubyte, 
                                   v: PGLfloat){.stdcall, importc, ogl.}
proc glProgramNamedParameter4dvNV*(id: GLuint, length: GLsizei, name: PGLubyte, 
                                   v: PGLdouble){.stdcall, importc, ogl.}
proc glGetProgramNamedParameterfvNV*(id: GLuint, length: GLsizei, 
                                     name: PGLubyte, params: PGLfloat){.stdcall, importc, ogl.}
proc glGetProgramNamedParameterdvNV*(id: GLuint, length: GLsizei, 
                                     name: PGLubyte, params: PGLdouble){.stdcall, importc, ogl.}
  # GL_NV_half_float
proc glVertex2hNV*(x: GLhalfNV, y: GLhalfNV){.stdcall, importc, ogl.}
proc glVertex2hvNV*(v: PGLhalfNV){.stdcall, importc, ogl.}
proc glVertex3hNV*(x: GLhalfNV, y: GLhalfNV, z: GLhalfNV){.stdcall, importc, ogl.}
proc glVertex3hvNV*(v: PGLhalfNV){.stdcall, importc, ogl.}
proc glVertex4hNV*(x: GLhalfNV, y: GLhalfNV, z: GLhalfNV, w: GLhalfNV){.stdcall, importc, ogl.}
proc glVertex4hvNV*(v: PGLhalfNV){.stdcall, importc, ogl.}
proc glNormal3hNV*(nx: GLhalfNV, ny: GLhalfNV, nz: GLhalfNV){.stdcall, importc, ogl.}
proc glNormal3hvNV*(v: PGLhalfNV){.stdcall, importc, ogl.}
proc glColor3hNV*(red: GLhalfNV, green: GLhalfNV, blue: GLhalfNV){.stdcall, importc, ogl.}
proc glColor3hvNV*(v: PGLhalfNV){.stdcall, importc, ogl.}
proc glColor4hNV*(red: GLhalfNV, green: GLhalfNV, blue: GLhalfNV, 
                  alpha: GLhalfNV){.stdcall, importc, ogl.}
proc glColor4hvNV*(v: PGLhalfNV){.stdcall, importc, ogl.}
proc glTexCoord1hNV*(s: GLhalfNV){.stdcall, importc, ogl.}
proc glTexCoord1hvNV*(v: PGLhalfNV){.stdcall, importc, ogl.}
proc glTexCoord2hNV*(s: GLhalfNV, t: GLhalfNV){.stdcall, importc, ogl.}
proc glTexCoord2hvNV*(v: PGLhalfNV){.stdcall, importc, ogl.}
proc glTexCoord3hNV*(s: GLhalfNV, t: GLhalfNV, r: GLhalfNV){.stdcall, importc, ogl.}
proc glTexCoord3hvNV*(v: PGLhalfNV){.stdcall, importc, ogl.}
proc glTexCoord4hNV*(s: GLhalfNV, t: GLhalfNV, r: GLhalfNV, q: GLhalfNV){.
    stdcall, importc, ogl.}
proc glTexCoord4hvNV*(v: PGLhalfNV){.stdcall, importc, ogl.}
proc glMultiTexCoord1hNV*(target: GLenum, s: GLhalfNV){.stdcall, importc, ogl.}
proc glMultiTexCoord1hvNV*(target: GLenum, v: PGLhalfNV){.stdcall, importc, ogl.}
proc glMultiTexCoord2hNV*(target: GLenum, s: GLhalfNV, t: GLhalfNV){.stdcall, importc, ogl.}
proc glMultiTexCoord2hvNV*(target: GLenum, v: PGLhalfNV){.stdcall, importc, ogl.}
proc glMultiTexCoord3hNV*(target: GLenum, s: GLhalfNV, t: GLhalfNV, r: GLhalfNV){.
    stdcall, importc, ogl.}
proc glMultiTexCoord3hvNV*(target: GLenum, v: PGLhalfNV){.stdcall, importc, ogl.}
proc glMultiTexCoord4hNV*(target: GLenum, s: GLhalfNV, t: GLhalfNV, r: GLhalfNV, 
                          q: GLhalfNV){.stdcall, importc, ogl.}
proc glMultiTexCoord4hvNV*(target: GLenum, v: PGLhalfNV){.stdcall, importc, ogl.}
proc glFogCoordhNV*(fog: GLhalfNV){.stdcall, importc, ogl.}
proc glFogCoordhvNV*(fog: PGLhalfNV){.stdcall, importc, ogl.}
proc glSecondaryColor3hNV*(red: GLhalfNV, green: GLhalfNV, blue: GLhalfNV){.
    stdcall, importc, ogl.}
proc glSecondaryColor3hvNV*(v: PGLhalfNV){.stdcall, importc, ogl.}
proc glVertexWeighthNV*(weight: GLhalfNV){.stdcall, importc, ogl.}
proc glVertexWeighthvNV*(weight: PGLhalfNV){.stdcall, importc, ogl.}
proc glVertexAttrib1hNV*(index: GLuint, x: GLhalfNV){.stdcall, importc, ogl.}
proc glVertexAttrib1hvNV*(index: GLuint, v: PGLhalfNV){.stdcall, importc, ogl.}
proc glVertexAttrib2hNV*(index: GLuint, x: GLhalfNV, y: GLhalfNV){.stdcall, importc, ogl.}
proc glVertexAttrib2hvNV*(index: GLuint, v: PGLhalfNV){.stdcall, importc, ogl.}
proc glVertexAttrib3hNV*(index: GLuint, x: GLhalfNV, y: GLhalfNV, z: GLhalfNV){.
    stdcall, importc, ogl.}
proc glVertexAttrib3hvNV*(index: GLuint, v: PGLhalfNV){.stdcall, importc, ogl.}
proc glVertexAttrib4hNV*(index: GLuint, x: GLhalfNV, y: GLhalfNV, z: GLhalfNV, 
                         w: GLhalfNV){.stdcall, importc, ogl.}
proc glVertexAttrib4hvNV*(index: GLuint, v: PGLhalfNV){.stdcall, importc, ogl.}
proc glVertexAttribs1hvNV*(index: GLuint, n: GLsizei, v: PGLhalfNV){.stdcall, importc, ogl.}
proc glVertexAttribs2hvNV*(index: GLuint, n: GLsizei, v: PGLhalfNV){.stdcall, importc, ogl.}
proc glVertexAttribs3hvNV*(index: GLuint, n: GLsizei, v: PGLhalfNV){.stdcall, importc, ogl.}
proc glVertexAttribs4hvNV*(index: GLuint, n: GLsizei, v: PGLhalfNV){.stdcall, importc, ogl.}
  # GL_NV_occlusion_query
proc glGenOcclusionQueriesNV*(n: GLsizei, ids: PGLuint){.stdcall, importc, ogl.}
proc glDeleteOcclusionQueriesNV*(n: GLsizei, ids: PGLuint){.stdcall, importc, ogl.}
proc glIsOcclusionQueryNV*(id: GLuint): GLboolean{.stdcall, importc, ogl.}
proc glBeginOcclusionQueryNV*(id: GLuint){.stdcall, importc, ogl.}
proc glEndOcclusionQueryNV*(){.stdcall, importc, ogl.}
proc glGetOcclusionQueryivNV*(id: GLuint, pname: GLenum, params: PGLint){.
    stdcall, importc, ogl.}
proc glGetOcclusionQueryuivNV*(id: GLuint, pname: GLenum, params: PGLuint){.
    stdcall, importc, ogl.}
  # GL_NV_pixel_data_range
proc glPixelDataRangeNV*(target: GLenum, len: GLsizei, pointer: PGLvoid){.
    stdcall, importc, ogl.}
proc glFlushPixelDataRangeNV*(target: GLenum){.stdcall, importc, ogl.}
  # GL_NV_point_sprite
proc glPointParameteriNV*(pname: GLenum, param: GLint){.stdcall, importc, ogl.}
proc glPointParameterivNV*(pname: GLenum, params: PGLint){.stdcall, importc, ogl.}
  # GL_NV_primitive_restart
proc glPrimitiveRestartNV*(){.stdcall, importc, ogl.}
proc glPrimitiveRestartIndexNV*(index: GLuint){.stdcall, importc, ogl.}
  # GL_NV_register_combiners
proc glCombinerParameterfvNV*(pname: GLenum, params: PGLfloat){.stdcall, importc, ogl.}
proc glCombinerParameterfNV*(pname: GLenum, param: GLfloat){.stdcall, importc, ogl.}
proc glCombinerParameterivNV*(pname: GLenum, params: PGLint){.stdcall, importc, ogl.}
proc glCombinerParameteriNV*(pname: GLenum, param: GLint){.stdcall, importc, ogl.}
proc glCombinerInputNV*(stage: GLenum, portion: GLenum, variable: GLenum, 
                        input: GLenum, mapping: GLenum, componentUsage: GLenum){.
    stdcall, importc, ogl.}
proc glCombinerOutputNV*(stage: GLenum, portion: GLenum, abOutput: GLenum, 
                         cdOutput: GLenum, sumOutput: GLenum, scale: GLenum, 
                         bias: GLenum, abDotProduct: GLboolean, 
                         cdDotProduct: GLboolean, muxSum: GLboolean){.stdcall, importc, ogl.}
proc glFinalCombinerInputNV*(variable: GLenum, input: GLenum, mapping: GLenum, 
                             componentUsage: GLenum){.stdcall, importc, ogl.}
proc glGetCombinerInputParameterfvNV*(stage: GLenum, portion: GLenum, 
                                      variable: GLenum, pname: GLenum, 
                                      params: PGLfloat){.stdcall, importc, ogl.}
proc glGetCombinerInputParameterivNV*(stage: GLenum, portion: GLenum, 
                                      variable: GLenum, pname: GLenum, 
                                      params: PGLint){.stdcall, importc, ogl.}
proc glGetCombinerOutputParameterfvNV*(stage: GLenum, portion: GLenum, 
                                       pname: GLenum, params: PGLfloat){.stdcall, importc, ogl.}
proc glGetCombinerOutputParameterivNV*(stage: GLenum, portion: GLenum, 
                                       pname: GLenum, params: PGLint){.stdcall, importc, ogl.}
proc glGetFinalCombinerInputParameterfvNV*(variable: GLenum, pname: GLenum, 
    params: PGLfloat){.stdcall, importc, ogl.}
proc glGetFinalCombinerInputParameterivNV*(variable: GLenum, pname: GLenum, 
    params: PGLint){.stdcall, importc, ogl.}
  # GL_NV_register_combiners2
proc glCombinerStageParameterfvNV*(stage: GLenum, pname: GLenum, 
                                   params: PGLfloat){.stdcall, importc, ogl.}
proc glGetCombinerStageParameterfvNV*(stage: GLenum, pname: GLenum, 
                                      params: PGLfloat){.stdcall, importc, ogl.}
  # GL_NV_vertex_array_range
proc glFlushVertexArrayRangeNV*(){.stdcall, importc, ogl.}
proc glVertexArrayRangeNV*(len: GLsizei, pointer: PGLvoid){.stdcall, importc, ogl.}
  # GL_NV_vertex_prog
proc glAreProgramsResidentNV*(n: GLsizei, programs: PGLuint, 
                              residences: PGLboolean): GLboolean{.stdcall, importc, ogl.}
proc glBindProgramNV*(target: GLenum, id: GLuint){.stdcall, importc, ogl.}
proc glDeleteProgramsNV*(n: GLsizei, programs: PGLuint){.stdcall, importc, ogl.}
proc glExecuteProgramNV*(target: GLenum, id: GLuint, params: PGLfloat){.stdcall, importc, ogl.}
proc glGenProgramsNV*(n: GLsizei, programs: PGLuint){.stdcall, importc, ogl.}
proc glGetProgramParameterdvNV*(target: GLenum, index: GLuint, pname: GLenum, 
                                params: PGLdouble){.stdcall, importc, ogl.}
proc glGetProgramParameterfvNV*(target: GLenum, index: GLuint, pname: GLenum, 
                                params: PGLfloat){.stdcall, importc, ogl.}
proc glGetProgramivNV*(id: GLuint, pname: GLenum, params: PGLint){.stdcall, importc, ogl.}
proc glGetProgramStringNV*(id: GLuint, pname: GLenum, prog: PGLubyte){.stdcall, importc, ogl.}
proc glGetTrackMatrixivNV*(target: GLenum, address: GLuint, pname: GLenum, 
                           params: PGLint){.stdcall, importc, ogl.}
proc glGetVertexAttribdvNV*(index: GLuint, pname: GLenum, params: PGLdouble){.
    stdcall, importc, ogl.}
proc glGetVertexAttribfvNV*(index: GLuint, pname: GLenum, params: PGLfloat){.
    stdcall, importc, ogl.}
proc glGetVertexAttribivNV*(index: GLuint, pname: GLenum, params: PGLint){.
    stdcall, importc, ogl.}
proc glGetVertexAttribPointervNV*(index: GLuint, pname: GLenum, pointer: PGLvoid){.
    stdcall, importc, ogl.}
proc glIsProgramNV*(id: GLuint): GLboolean{.stdcall, importc, ogl.}
proc glLoadProgramNV*(target: GLenum, id: GLuint, length: GLsizei, 
                      prog: PGLubyte){.stdcall, importc, ogl.}
proc glProgramParameter4dNV*(target: GLenum, index: GLuint, x: GLdouble, 
                             y: GLdouble, z: GLdouble, w: GLdouble){.stdcall, importc, ogl.}
proc glProgramParameter4dvNV*(target: GLenum, index: GLuint, v: PGLdouble){.
    stdcall, importc, ogl.}
proc glProgramParameter4fNV*(target: GLenum, index: GLuint, x: GLfloat, 
                             y: GLfloat, z: GLfloat, w: GLfloat){.stdcall, importc, ogl.}
proc glProgramParameter4fvNV*(target: GLenum, index: GLuint, v: PGLfloat){.
    stdcall, importc, ogl.}
proc glProgramParameters4dvNV*(target: GLenum, index: GLuint, count: GLuint, 
                               v: PGLdouble){.stdcall, importc, ogl.}
proc glProgramParameters4fvNV*(target: GLenum, index: GLuint, count: GLuint, 
                               v: PGLfloat){.stdcall, importc, ogl.}
proc glRequestResidentProgramsNV*(n: GLsizei, programs: PGLuint){.stdcall, importc, ogl.}
proc glTrackMatrixNV*(target: GLenum, address: GLuint, matrix: GLenum, 
                      transform: GLenum){.stdcall, importc, ogl.}
proc glVertexAttribPointerNV*(index: GLuint, fsize: GLint, typ: GLenum, 
                              stride: GLsizei, pointer: PGLvoid){.stdcall, importc, ogl.}
proc glVertexAttrib1dNV*(index: GLuint, x: GLdouble){.stdcall, importc, ogl.}
proc glVertexAttrib1dvNV*(index: GLuint, v: PGLdouble){.stdcall, importc, ogl.}
proc glVertexAttrib1fNV*(index: GLuint, x: GLfloat){.stdcall, importc, ogl.}
proc glVertexAttrib1fvNV*(index: GLuint, v: PGLfloat){.stdcall, importc, ogl.}
proc glVertexAttrib1sNV*(index: GLuint, x: GLshort){.stdcall, importc, ogl.}
proc glVertexAttrib1svNV*(index: GLuint, v: PGLshort){.stdcall, importc, ogl.}
proc glVertexAttrib2dNV*(index: GLuint, x: GLdouble, y: GLdouble){.stdcall, importc, ogl.}
proc glVertexAttrib2dvNV*(index: GLuint, v: PGLdouble){.stdcall, importc, ogl.}
proc glVertexAttrib2fNV*(index: GLuint, x: GLfloat, y: GLfloat){.stdcall, importc, ogl.}
proc glVertexAttrib2fvNV*(index: GLuint, v: PGLfloat){.stdcall, importc, ogl.}
proc glVertexAttrib2sNV*(index: GLuint, x: GLshort, y: GLshort){.stdcall, importc, ogl.}
proc glVertexAttrib2svNV*(index: GLuint, v: PGLshort){.stdcall, importc, ogl.}
proc glVertexAttrib3dNV*(index: GLuint, x: GLdouble, y: GLdouble, z: GLdouble){.
    stdcall, importc, ogl.}
proc glVertexAttrib3dvNV*(index: GLuint, v: PGLdouble){.stdcall, importc, ogl.}
proc glVertexAttrib3fNV*(index: GLuint, x: GLfloat, y: GLfloat, z: GLfloat){.
    stdcall, importc, ogl.}
proc glVertexAttrib3fvNV*(index: GLuint, v: PGLfloat){.stdcall, importc, ogl.}
proc glVertexAttrib3sNV*(index: GLuint, x: GLshort, y: GLshort, z: GLshort){.
    stdcall, importc, ogl.}
proc glVertexAttrib3svNV*(index: GLuint, v: PGLshort){.stdcall, importc, ogl.}
proc glVertexAttrib4dNV*(index: GLuint, x: GLdouble, y: GLdouble, z: GLdouble, 
                         w: GLdouble){.stdcall, importc, ogl.}
proc glVertexAttrib4dvNV*(index: GLuint, v: PGLdouble){.stdcall, importc, ogl.}
proc glVertexAttrib4fNV*(index: GLuint, x: GLfloat, y: GLfloat, z: GLfloat, 
                         w: GLfloat){.stdcall, importc, ogl.}
proc glVertexAttrib4fvNV*(index: GLuint, v: PGLfloat){.stdcall, importc, ogl.}
proc glVertexAttrib4sNV*(index: GLuint, x: GLshort, y: GLshort, z: GLshort, 
                         w: GLshort){.stdcall, importc, ogl.}
proc glVertexAttrib4svNV*(index: GLuint, v: PGLshort){.stdcall, importc, ogl.}
proc glVertexAttrib4ubNV*(index: GLuint, x: GLubyte, y: GLubyte, z: GLubyte, 
                          w: GLubyte){.stdcall, importc, ogl.}
proc glVertexAttrib4ubvNV*(index: GLuint, v: PGLubyte){.stdcall, importc, ogl.}
proc glVertexAttribs1dvNV*(index: GLuint, count: GLsizei, v: PGLdouble){.stdcall, importc, ogl.}
proc glVertexAttribs1fvNV*(index: GLuint, count: GLsizei, v: PGLfloat){.stdcall, importc, ogl.}
proc glVertexAttribs1svNV*(index: GLuint, count: GLsizei, v: PGLshort){.stdcall, importc, ogl.}
proc glVertexAttribs2dvNV*(index: GLuint, count: GLsizei, v: PGLdouble){.stdcall, importc, ogl.}
proc glVertexAttribs2fvNV*(index: GLuint, count: GLsizei, v: PGLfloat){.stdcall, importc, ogl.}
proc glVertexAttribs2svNV*(index: GLuint, count: GLsizei, v: PGLshort){.stdcall, importc, ogl.}
proc glVertexAttribs3dvNV*(index: GLuint, count: GLsizei, v: PGLdouble){.stdcall, importc, ogl.}
proc glVertexAttribs3fvNV*(index: GLuint, count: GLsizei, v: PGLfloat){.stdcall, importc, ogl.}
proc glVertexAttribs3svNV*(index: GLuint, count: GLsizei, v: PGLshort){.stdcall, importc, ogl.}
proc glVertexAttribs4dvNV*(index: GLuint, count: GLsizei, v: PGLdouble){.stdcall, importc, ogl.}
proc glVertexAttribs4fvNV*(index: GLuint, count: GLsizei, v: PGLfloat){.stdcall, importc, ogl.}
proc glVertexAttribs4svNV*(index: GLuint, count: GLsizei, v: PGLshort){.stdcall, importc, ogl.}
proc glVertexAttribs4ubvNV*(index: GLuint, count: GLsizei, v: PGLubyte){.stdcall, importc, ogl.}
  # GL_NV_depth_buffer_float
proc glDepthRangedNV*(n: GLdouble, f: GLdouble){.stdcall, importc, ogl.}
proc glClearDepthdNV*(d: GLdouble){.stdcall, importc, ogl.}
proc glDepthBoundsdNV*(zmin: GLdouble, zmax: GLdouble){.stdcall, importc, ogl.}
  # GL_NV_framebuffer_multisample_coverage
proc glRenderbufferStorageMultsampleCoverageNV*(target: GLenum, 
    coverageSamples: GLsizei, colorSamples: GLsizei, internalformat: GLenum, 
    width: GLsizei, height: GLsizei){.stdcall, importc, ogl.}
  # GL_NV_geometry_program4
proc glProgramVertexLimitNV*(target: GLenum, limit: GLint){.stdcall, importc, ogl.}
  # GL_NV_gpu_program4
proc glProgramLocalParameterI4iNV*(target: GLenum, index: GLuint, x: GLint, 
                                   y: GLint, z: GLint, w: GLint){.stdcall, importc, ogl.}
proc glProgramLocalParameterI4ivNV*(target: GLenum, index: GLuint, 
                                    params: PGLint){.stdcall, importc, ogl.}
proc glProgramLocalParametersI4ivNV*(target: GLenum, index: GLuint, 
                                     count: GLsizei, params: PGLint){.stdcall, importc, ogl.}
proc glProgramLocalParameterI4uiNV*(target: GLenum, index: GLuint, x: GLuint, 
                                    y: GLuint, z: GLuint, w: GLuint){.stdcall, importc, ogl.}
proc glProgramLocalParameterI4uivNV*(target: GLenum, index: GLuint, 
                                     params: PGLuint){.stdcall, importc, ogl.}
proc glProgramLocalParametersI4uivNV*(target: GLenum, index: GLuint, 
                                      count: GLsizei, params: PGLuint){.stdcall, importc, ogl.}
proc glProgramEnvParameterI4iNV*(target: GLenum, index: GLuint, x: GLint, 
                                 y: GLint, z: GLint, w: GLint){.stdcall, importc, ogl.}
proc glProgramEnvParameterI4ivNV*(target: GLenum, index: GLuint, params: PGLint){.
    stdcall, importc, ogl.}
proc glProgramEnvParametersI4ivNV*(target: GLenum, index: GLuint, 
                                   count: GLsizei, params: PGLint){.stdcall, importc, ogl.}
proc glProgramEnvParameterI4uiNV*(target: GLenum, index: GLuint, x: GLuint, 
                                  y: GLuint, z: GLuint, w: GLuint){.stdcall, importc, ogl.}
proc glProgramEnvParameterI4uivNV*(target: GLenum, index: GLuint, 
                                   params: PGLuint){.stdcall, importc, ogl.}
proc glProgramEnvParametersI4uivNV*(target: GLenum, index: GLuint, 
                                    count: GLsizei, params: PGLuint){.stdcall, importc, ogl.}
proc glGetProgramLocalParameterIivNV*(target: GLenum, index: GLuint, 
                                      params: PGLint){.stdcall, importc, ogl.}
proc glGetProgramLocalParameterIuivNV*(target: GLenum, index: GLuint, 
                                       params: PGLuint){.stdcall, importc, ogl.}
proc glGetProgramEnvParameterIivNV*(target: GLenum, index: GLuint, 
                                    params: PGLint){.stdcall, importc, ogl.}
proc glGetProgramEnvParameterIuivNV*(target: GLenum, index: GLuint, 
                                     params: PGLuint){.stdcall, importc, ogl.}
  # GL_NV_parameter_buffer_object
proc glProgramBufferParametersfvNV*(target: GLenum, buffer: GLuint, 
                                    index: GLuint, count: GLsizei, 
                                    params: PGLfloat){.stdcall, importc, ogl.}
proc glProgramBufferParametersIivNV*(target: GLenum, buffer: GLuint, 
                                     index: GLuint, count: GLsizei, 
                                     params: GLint){.stdcall, importc, ogl.}
proc glProgramBufferParametersIuivNV*(target: GLenum, buffer: GLuint, 
                                      index: GLuint, count: GLuint, 
                                      params: PGLuint){.stdcall, importc, ogl.}
  # GL_NV_transform_feedback
proc glBeginTransformFeedbackNV*(primitiveMode: GLenum){.stdcall, importc, ogl.}
proc glEndTransformFeedbackNV*(){.stdcall, importc, ogl.}
proc glTransformFeedbackAttribsNV*(count: GLsizei, attribs: GLint, 
                                   bufferMode: GLenum){.stdcall, importc, ogl.}
proc glBindBufferRangeNV*(target: GLenum, index: GLuint, buffer: GLuint, 
                          offset: GLintptr, size: GLsizeiptr){.stdcall, importc, ogl.}
proc glBindBufferOffsetNV*(target: GLenum, index: GLuint, buffer: GLuint, 
                           offset: GLintptr){.stdcall, importc, ogl.}
proc glBindBufferBaseNV*(target: GLenum, index: GLuint, buffer: GLuint){.stdcall, importc, ogl.}
proc glTransformFeedbackVaryingsNV*(prog: GLuint, count: GLsizei, 
                                    locations: PGLint, bufferMode: GLenum){.
    stdcall, importc, ogl.}
proc glActiveVaryingNV*(prog: GLuint, name: PGLchar){.stdcall, importc, ogl.}
proc glGetVaryingLocationNV*(prog: GLuint, name: PGLchar): GLint{.stdcall, importc, ogl.}
proc glGetActiveVaryingNV*(prog: GLuint, index: GLuint, bufSize: GLsizei, 
                           len: PGLsizei, size: PGLsizei, typ: PGLenum, 
                           name: PGLchar){.stdcall, importc, ogl.}
proc glGetTransformFeedbackVaryingNV*(prog: GLuint, index: GLuint, 
                                      location: PGLint){.stdcall, importc, ogl.}
proc glTransformFeedbackStreamAttribsNV*(count: GLsizei, attribs: PGLint, 
    nbuffers: GLsizei, bufstreams: PGLint, bufferMode: GLenum){.stdcall, importc, ogl.}
  # GL_NV_conditional_render
proc glBeginConditionalRenderNV*(id: GLuint, mode: GLenum){.stdcall, importc, ogl.}
proc glEndConditionalRenderNV*(){.stdcall, importc, ogl.}
  # GL_NV_present_video
proc glPresentFrameKeyedNV*(video_slot: GLuint, minPresentTime: GLuint64EXT, 
                            beginPresentTimeId: GLuint, 
                            presentDuratioId: GLuint, typ: GLenum, 
                            target0: GLenum, fill0: GLuint, key0: GLuint, 
                            target1: GLenum, fill1: GLuint, key1: GLuint){.
    stdcall, importc, ogl.}
proc glPresentFrameDualFillNV*(video_slot: GLuint, minPresentTime: GLuint64EXT, 
                               beginPresentTimeId: GLuint, 
                               presentDurationId: GLuint, typ: GLenum, 
                               target0: GLenum, fill0: GLuint, target1: GLenum, 
                               fill1: GLuint, target2: GLenum, fill2: GLuint, 
                               target3: GLenum, fill3: GLuint){.stdcall, importc, ogl.}
proc glGetVideoivNV*(video_slot: GLuint, pname: GLenum, params: PGLint){.stdcall, importc, ogl.}
proc glGetVideouivNV*(video_slot: GLuint, pname: GLenum, params: PGLuint){.
    stdcall, importc, ogl.}
proc glGetVideoi64vNV*(video_slot: GLuint, pname: GLenum, params: PGLint64EXT){.
    stdcall, importc, ogl.}
proc glGetVideoui64vNV*(video_slot: GLuint, pname: GLenum, params: PGLuint64EXT){.
    stdcall, importc, ogl.}
  #procedure glVideoParameterivNV(video_slot: GLuint; pname: GLenum; const params: PGLint); stdcall, importc, ogl;
  # GL_NV_explicit_multisample
proc glGetMultisamplefvNV*(pname: GLenum, index: GLuint, val: PGLfloat){.stdcall, importc, ogl.}
proc glSampleMaskIndexedNV*(index: GLuint, mask: GLbitfield){.stdcall, importc, ogl.}
proc glTexRenderbufferNV*(target: GLenum, renderbuffer: GLuint){.stdcall, importc, ogl.}
  # GL_NV_transform_feedback2
proc glBindTransformFeedbackNV*(target: GLenum, id: GLuint){.stdcall, importc, ogl.}
proc glDeleteTransformFeedbacksNV*(n: GLsizei, ids: PGLuint){.stdcall, importc, ogl.}
proc glGenTransformFeedbacksNV*(n: GLsizei, ids: PGLuint){.stdcall, importc, ogl.}
proc glIsTransformFeedbackNV*(id: GLuint): GLboolean{.stdcall, importc, ogl.}
proc glPauseTransformFeedbackNV*(){.stdcall, importc, ogl.}
proc glResumeTransformFeedbackNV*(){.stdcall, importc, ogl.}
proc glDrawTransformFeedbackNV*(mode: GLenum, id: GLuint){.stdcall, importc, ogl.}
  # GL_NV_video_capture
proc glBeginVideoCaptureNV*(video_capture_slot: GLuint){.stdcall, importc, ogl.}
proc glBindVideoCaptureStreamBufferNV*(video_capture_slot: GLuint, 
                                       stream: GLuint, frame_region: GLenum, 
                                       offset: GLintptrARB){.stdcall, importc, ogl.}
proc glBindVideoCaptureStreamTextureNV*(video_capture_slot: GLuint, 
                                        stream: GLuint, frame_region: GLenum, 
                                        target: GLenum, texture: GLuint){.
    stdcall, importc, ogl.}
proc glEndVideoCaptureNV*(video_capture_slot: GLuint){.stdcall, importc, ogl.}
proc glGetVideoCaptureivNV*(video_capture_slot: GLuint, pname: GLenum, 
                            params: PGLint){.stdcall, importc, ogl.}
proc glGetVideoCaptureStreamivNV*(video_capture_slot: GLuint, stream: GLuint, 
                                  pname: GLenum, params: PGLint){.stdcall, importc, ogl.}
proc glGetVideoCaptureStreamfvNV*(video_capture_slot: GLuint, stream: GLuint, 
                                  pname: GLenum, params: PGLfloat){.stdcall, importc, ogl.}
proc glGetVideoCaptureStreamdvNV*(video_capture_slot: GLuint, stream: GLuint, 
                                  pname: GLenum, params: PGLdouble){.stdcall, importc, ogl.}
proc glVideoCaptureNV*(video_capture_slot: GLuint, sequence_num: PGLuint, 
                       capture_time: PGLuint64EXT): GLenum{.stdcall, importc, ogl.}
proc glVideoCaptureStreamParameterivNV*(video_capture_slot: GLuint, 
                                        stream: GLuint, pname: GLenum, 
                                        params: PGLint){.stdcall, importc, ogl.}
proc glVideoCaptureStreamParameterfvNV*(video_capture_slot: GLuint, 
                                        stream: GLuint, pname: GLenum, 
                                        params: PGLfloat){.stdcall, importc, ogl.}
proc glVideoCaptureStreamParameterdvNV*(video_capture_slot: GLuint, 
                                        stream: GLuint, pname: GLenum, 
                                        params: PGLdouble){.stdcall, importc, ogl.}
  # GL_NV_copy_image
proc glCopyImageSubDataNV*(srcName: GLuint, srcTarget: GLenum, srcLevel: GLint, 
                           srcX: GLint, srcY: GLint, srcZ: GLint, 
                           dstName: GLuint, dstTarget: GLenum, dstLevel: GLint, 
                           dstX: GLint, dstY: GLint, dstZ: GLint, 
                           width: GLsizei, height: GLsizei, depth: GLsizei){.
    stdcall, importc, ogl.}
  # GL_NV_shader_buffer_load
proc glMakeBufferResidentNV*(target: GLenum, access: GLenum){.stdcall, importc, ogl.}
proc glMakeBufferNonResidentNV*(target: GLenum){.stdcall, importc, ogl.}
proc glIsBufferResidentNV*(target: GLenum): GLboolean{.stdcall, importc, ogl.}
proc glMakeNamedBufferResidentNV*(buffer: GLuint, access: GLenum){.stdcall, importc, ogl.}
proc glMakeNamedBufferNonResidentNV*(buffer: GLuint){.stdcall, importc, ogl.}
proc glIsNamedBufferResidentNV*(buffer: GLuint): GLboolean{.stdcall, importc, ogl.}
proc glGetBufferParameterui64vNV*(target: GLenum, pname: GLenum, 
                                  params: PGLuint64EXT){.stdcall, importc, ogl.}
proc glGetNamedBufferParameterui64vNV*(buffer: GLuint, pname: GLenum, 
                                       params: PGLuint64EXT){.stdcall, importc, ogl.}
proc glGetIntegerui64vNV*(value: GLenum, result: PGLuint64EXT){.stdcall, importc, ogl.}
proc glUniformui64NV*(location: GLint, value: GLuint64EXT){.stdcall, importc, ogl.}
proc glUniformui64vNV*(location: GLint, count: GLsizei, value: PGLuint64EXT){.
    stdcall, importc, ogl.}
proc glGetUniformui64vNV*(prog: GLuint, location: GLint, params: PGLuint64EXT){.
    stdcall, importc, ogl.}
proc glProgramUniformui64NV*(prog: GLuint, location: GLint, value: GLuint64EXT){.
    stdcall, importc, ogl.}
proc glProgramUniformui64vNV*(prog: GLuint, location: GLint, count: GLsizei, 
                              value: PGLuint64EXT){.stdcall, importc, ogl.}
  # GL_NV_vertex_buffer_unified_memory
proc glBufferAddressRangeNV*(pname: GLenum, index: GLuint, adress: GLuint64EXT, 
                             len: GLsizeiptr){.stdcall, importc, ogl.}
proc glVertexFormatNV*(size: GLint, typ: GLenum, stride: GLsizei){.stdcall, importc, ogl.}
proc glNormalFormatNV*(typ: GLenum, stride: GLsizei){.stdcall, importc, ogl.}
proc glColorFormatNV*(size: GLint, typ: GLenum, stride: GLsizei){.stdcall, importc, ogl.}
proc glIndexFormatNV*(typ: GLenum, stride: GLsizei){.stdcall, importc, ogl.}
proc glTexCoordFormatNV*(size: GLint, typ: GLenum, stride: GLsizei){.stdcall, importc, ogl.}
proc glEdgeFlagFormatNV*(stride: GLsizei){.stdcall, importc, ogl.}
proc glSecondaryColorFormatNV*(size: GLint, typ: GLenum, stride: GLsizei){.
    stdcall, importc, ogl.}
proc glFogCoordFormatNV*(typ: GLenum, stride: GLsizei){.stdcall, importc, ogl.}
proc glVertexAttribFormatNV*(index: GLuint, size: GLint, typ: GLenum, 
                             normalized: GLboolean, stride: GLsizei){.stdcall, importc, ogl.}
proc glVertexAttribIFormatNV*(index: GLuint, size: GLint, typ: GLenum, 
                              stride: GLsizei){.stdcall, importc, ogl.}
proc glGetIntegerui64i_vNV*(value: GLenum, index: GLuint, Result: PGLuint64EXT){.
    stdcall, importc, ogl.}
  # GL_NV_gpu_program5
proc glProgramSubroutineParametersuivNV*(target: GLenum, count: GLsizei, 
    params: PGLuint){.stdcall, importc, ogl.}
proc glGetProgramSubroutineParameteruivNV*(target: GLenum, index: GLuint, 
    param: PGLuint){.stdcall, importc, ogl.}
  # GL_NV_gpu_shader5
proc glUniform1i64NV*(location: GLint, x: GLint64EXT){.stdcall, importc, ogl.}
proc glUniform2i64NV*(location: GLint, x: GLint64EXT, y: GLint64EXT){.stdcall, importc, ogl.}
proc glUniform3i64NV*(location: GLint, x: GLint64EXT, y: GLint64EXT, 
                      z: GLint64EXT){.stdcall, importc, ogl.}
proc glUniform4i64NV*(location: GLint, x: GLint64EXT, y: GLint64EXT, 
                      z: GLint64EXT, w: GLint64EXT){.stdcall, importc, ogl.}
proc glUniform1i64vNV*(location: GLint, count: GLsizei, value: PGLint64EXT){.
    stdcall, importc, ogl.}
proc glUniform2i64vNV*(location: GLint, count: GLsizei, value: PGLint64EXT){.
    stdcall, importc, ogl.}
proc glUniform3i64vNV*(location: GLint, count: GLsizei, value: PGLint64EXT){.
    stdcall, importc, ogl.}
proc glUniform4i64vNV*(location: GLint, count: GLsizei, value: PGLint64EXT){.
    stdcall, importc, ogl.}
proc glUniform1ui64NV*(location: GLint, x: GLuint64EXT){.stdcall, importc, ogl.}
proc glUniform2ui64NV*(location: GLint, x: GLuint64EXT, y: GLuint64EXT){.stdcall, importc, ogl.}
proc glUniform3ui64NV*(location: GLint, x: GLuint64EXT, y: GLuint64EXT, 
                       z: GLuint64EXT){.stdcall, importc, ogl.}
proc glUniform4ui64NV*(location: GLint, x: GLuint64EXT, y: GLuint64EXT, 
                       z: GLuint64EXT, w: GLuint64EXT){.stdcall, importc, ogl.}
proc glUniform1ui64vNV*(location: GLint, count: GLsizei, value: PGLuint64EXT){.
    stdcall, importc, ogl.}
proc glUniform2ui64vNV*(location: GLint, count: GLsizei, value: PGLuint64EXT){.
    stdcall, importc, ogl.}
proc glUniform3ui64vNV*(location: GLint, count: GLsizei, value: PGLuint64EXT){.
    stdcall, importc, ogl.}
proc glUniform4ui64vNV*(location: GLint, count: GLsizei, value: PGLuint64EXT){.
    stdcall, importc, ogl.}
proc glGetUniformi64vNV*(prog: GLuint, location: GLint, params: PGLint64EXT){.
    stdcall, importc, ogl.}
proc glProgramUniform1i64NV*(prog: GLuint, location: GLint, x: GLint64EXT){.
    stdcall, importc, ogl.}
proc glProgramUniform2i64NV*(prog: GLuint, location: GLint, x: GLint64EXT, 
                             y: GLint64EXT){.stdcall, importc, ogl.}
proc glProgramUniform3i64NV*(prog: GLuint, location: GLint, x: GLint64EXT, 
                             y: GLint64EXT, z: GLint64EXT){.stdcall, importc, ogl.}
proc glProgramUniform4i64NV*(prog: GLuint, location: GLint, x: GLint64EXT, 
                             y: GLint64EXT, z: GLint64EXT, w: GLint64EXT){.
    stdcall, importc, ogl.}
proc glProgramUniform1i64vNV*(prog: GLuint, location: GLint, count: GLsizei, 
                              value: PGLint64EXT){.stdcall, importc, ogl.}
proc glProgramUniform2i64vNV*(prog: GLuint, location: GLint, count: GLsizei, 
                              value: PGLint64EXT){.stdcall, importc, ogl.}
proc glProgramUniform3i64vNV*(prog: GLuint, location: GLint, count: GLsizei, 
                              value: PGLint64EXT){.stdcall, importc, ogl.}
proc glProgramUniform4i64vNV*(prog: GLuint, location: GLint, count: GLsizei, 
                              value: PGLint64EXT){.stdcall, importc, ogl.}
proc glProgramUniform1ui64NV*(prog: GLuint, location: GLint, x: GLuint64EXT){.
    stdcall, importc, ogl.}
proc glProgramUniform2ui64NV*(prog: GLuint, location: GLint, x: GLuint64EXT, 
                              y: GLuint64EXT){.stdcall, importc, ogl.}
proc glProgramUniform3ui64NV*(prog: GLuint, location: GLint, x: GLuint64EXT, 
                              y: GLuint64EXT, z: GLuint64EXT){.stdcall, importc, ogl.}
proc glProgramUniform4ui64NV*(prog: GLuint, location: GLint, x: GLuint64EXT, 
                              y: GLuint64EXT, z: GLuint64EXT, w: GLuint64EXT){.
    stdcall, importc, ogl.}
proc glProgramUniform1ui64vNV*(prog: GLuint, location: GLint, count: GLsizei, 
                               value: PGLuint64EXT){.stdcall, importc, ogl.}
proc glProgramUniform2ui64vNV*(prog: GLuint, location: GLint, count: GLsizei, 
                               value: PGLuint64EXT){.stdcall, importc, ogl.}
proc glProgramUniform3ui64vNV*(prog: GLuint, location: GLint, count: GLsizei, 
                               value: PGLuint64EXT){.stdcall, importc, ogl.}
proc glProgramUniform4ui64vNV*(prog: GLuint, location: GLint, count: GLsizei, 
                               value: PGLuint64EXT){.stdcall, importc, ogl.}
  # GL_NV_vertex_attrib_integer_64bit
proc glVertexAttribL1i64NV*(index: GLuint, x: GLint64EXT){.stdcall, importc, ogl.}
proc glVertexAttribL2i64NV*(index: GLuint, x: GLint64EXT, y: GLint64EXT){.
    stdcall, importc, ogl.}
proc glVertexAttribL3i64NV*(index: GLuint, x: GLint64EXT, y: GLint64EXT, 
                            z: GLint64EXT){.stdcall, importc, ogl.}
proc glVertexAttribL4i64NV*(index: GLuint, x: GLint64EXT, y: GLint64EXT, 
                            z: GLint64EXT, w: GLint64EXT){.stdcall, importc, ogl.}
proc glVertexAttribL1i64vNV*(index: GLuint, v: PGLint64EXT){.stdcall, importc, ogl.}
proc glVertexAttribL2i64vNV*(index: GLuint, v: PGLint64EXT){.stdcall, importc, ogl.}
proc glVertexAttribL3i64vNV*(index: GLuint, v: PGLint64EXT){.stdcall, importc, ogl.}
proc glVertexAttribL4i64vNV*(index: GLuint, v: PGLint64EXT){.stdcall, importc, ogl.}
proc glVertexAttribL1ui64NV*(index: GLuint, x: GLuint64EXT){.stdcall, importc, ogl.}
proc glVertexAttribL2ui64NV*(index: GLuint, x: GLuint64EXT, y: GLuint64EXT){.
    stdcall, importc, ogl.}
proc glVertexAttribL3ui64NV*(index: GLuint, x: GLuint64EXT, y: GLuint64EXT, 
                             z: GLuint64EXT){.stdcall, importc, ogl.}
proc glVertexAttribL4ui64NV*(index: GLuint, x: GLuint64EXT, y: GLuint64EXT, 
                             z: GLuint64EXT, w: GLuint64EXT){.stdcall, importc, ogl.}
proc glVertexAttribL1ui64vNV*(index: GLuint, v: PGLuint64EXT){.stdcall, importc, ogl.}
proc glVertexAttribL2ui64vNV*(index: GLuint, v: PGLuint64EXT){.stdcall, importc, ogl.}
proc glVertexAttribL3ui64vNV*(index: GLuint, v: PGLuint64EXT){.stdcall, importc, ogl.}
proc glVertexAttribL4ui64vNV*(index: GLuint, v: PGLuint64EXT){.stdcall, importc, ogl.}
proc glGetVertexAttribLi64vNV*(index: GLuint, pname: GLenum, params: PGLint64EXT){.
    stdcall, importc, ogl.}
proc glGetVertexAttribLui64vNV*(index: GLuint, pname: GLenum, 
                                params: PGLuint64EXT){.stdcall, importc, ogl.}
proc glVertexAttribLFormatNV*(index: GLuint, size: GLint, typ: GLenum, 
                              stride: GLsizei){.stdcall, importc, ogl.}
  # GL_NV_vdpau_interop
proc glVDPAUInitNV*(vdpDevice: PGLvoid, getProcAddress: PGLvoid){.stdcall, importc, ogl.}
proc glVDPAUFiniNV*(){.stdcall, importc, ogl.}
proc glVDPAURegisterVideoSurfaceNV*(vdpSurface: PGLvoid, target: GLenum, 
                                    numTextureNames: GLsizei, 
                                    textureNames: PGLuint): GLvdpauSurfaceNV{.
    stdcall, importc, ogl.}
proc glVDPAURegisterOutputSurfaceNV*(vdpSurface: PGLvoid, target: GLenum, 
                                     numTextureNames: GLsizei, 
                                     textureNames: PGLuint): GLvdpauSurfaceNV{.
    stdcall, importc, ogl.}
proc glVDPAUIsSurfaceNV*(surface: GLvdpauSurfaceNV){.stdcall, importc, ogl.}
proc glVDPAUUnregisterSurfaceNV*(surface: GLvdpauSurfaceNV){.stdcall, importc, ogl.}
proc glVDPAUGetSurfaceivNV*(surface: GLvdpauSurfaceNV, pname: GLenum, 
                            bufSize: GLsizei, len: PGLsizei, values: PGLint){.
    stdcall, importc, ogl.}
proc glVDPAUSurfaceAccessNV*(surface: GLvdpauSurfaceNV, access: GLenum){.stdcall, importc, ogl.}
proc glVDPAUMapSurfacesNV*(numSurfaces: GLsizei, surfaces: PGLvdpauSurfaceNV){.
    stdcall, importc, ogl.}
proc glVDPAUUnmapSurfacesNV*(numSurface: GLsizei, surfaces: PGLvdpauSurfaceNV){.
    stdcall, importc, ogl.}
  # GL_NV_texture_barrier
proc glTextureBarrierNV*(){.stdcall, importc, ogl.}
  # GL_PGI_misc_hints
proc glHintPGI*(target: GLenum, mode: GLint){.stdcall, importc, ogl.}
  # GL_SGIS_detail_texture
proc glDetailTexFuncSGIS*(target: GLenum, n: GLsizei, points: PGLfloat){.stdcall, importc, ogl.}
proc glGetDetailTexFuncSGIS*(target: GLenum, points: PGLfloat){.stdcall, importc, ogl.}
  # GL_SGIS_fog_function
proc glFogFuncSGIS*(n: GLsizei, points: PGLfloat){.stdcall, importc, ogl.}
proc glGetFogFuncSGIS*(points: PGLfloat){.stdcall, importc, ogl.}
  # GL_SGIS_multisample
proc glSampleMaskSGIS*(value: GLclampf, invert: GLboolean){.stdcall, importc, ogl.}
proc glSamplePatternSGIS*(pattern: GLenum){.stdcall, importc, ogl.}
  # GL_SGIS_pixel_texture
proc glPixelTexGenParameteriSGIS*(pname: GLenum, param: GLint){.stdcall, importc, ogl.}
proc glPixelTexGenParameterivSGIS*(pname: GLenum, params: PGLint){.stdcall, importc, ogl.}
proc glPixelTexGenParameterfSGIS*(pname: GLenum, param: GLfloat){.stdcall, importc, ogl.}
proc glPixelTexGenParameterfvSGIS*(pname: GLenum, params: PGLfloat){.stdcall, importc, ogl.}
proc glGetPixelTexGenParameterivSGIS*(pname: GLenum, params: PGLint){.stdcall, importc, ogl.}
proc glGetPixelTexGenParameterfvSGIS*(pname: GLenum, params: PGLfloat){.stdcall, importc, ogl.}
  # GL_SGIS_point_parameters
proc glPointParameterfSGIS*(pname: GLenum, param: GLfloat){.stdcall, importc, ogl.}
proc glPointParameterfvSGIS*(pname: GLenum, params: PGLfloat){.stdcall, importc, ogl.}
  # GL_SGIS_sharpen_texture
proc glSharpenTexFuncSGIS*(target: GLenum, n: GLsizei, points: PGLfloat){.
    stdcall, importc, ogl.}
proc glGetSharpenTexFuncSGIS*(target: GLenum, points: PGLfloat){.stdcall, importc, ogl.}
  # GL_SGIS_texture4D
proc glTexImage4DSGIS*(target: GLenum, level: GLint, internalformat: GLenum, 
                       width: GLsizei, height: GLsizei, depth: GLsizei, 
                       size4d: GLsizei, border: GLint, format: GLenum, 
                       typ: GLenum, pixels: PGLvoid){.stdcall, importc, ogl.}
proc glTexSubImage4DSGIS*(target: GLenum, level: GLint, xoffset: GLint, 
                          yoffset: GLint, zoffset: GLint, woffset: GLint, 
                          width: GLsizei, height: GLsizei, depth: GLsizei, 
                          size4d: GLsizei, format: GLenum, typ: GLenum, 
                          pixels: PGLvoid){.stdcall, importc, ogl.}
  # GL_SGIS_texture_color_mask
proc glTextureColorMaskSGIS*(red: GLboolean, green: GLboolean, blue: GLboolean, 
                             alpha: GLboolean){.stdcall, importc, ogl.}
  # GL_SGIS_texture_filter4
proc glGetTexFilterFuncSGIS*(target: GLenum, filter: GLenum, weights: PGLfloat){.
    stdcall, importc, ogl.}
proc glTexFilterFuncSGIS*(target: GLenum, filter: GLenum, n: GLsizei, 
                          weights: PGLfloat){.stdcall, importc, ogl.}
  # GL_SGIX_async
proc glAsyncMarkerSGIX*(marker: GLuint){.stdcall, importc, ogl.}
proc glFinishAsyncSGIX*(markerp: PGLuint): GLint{.stdcall, importc, ogl.}
proc glPollAsyncSGIX*(markerp: PGLuint): GLint{.stdcall, importc, ogl.}
proc glGenAsyncMarkersSGIX*(range: GLsizei): GLuint{.stdcall, importc, ogl.}
proc glDeleteAsyncMarkersSGIX*(marker: GLuint, range: GLsizei){.stdcall, importc, ogl.}
proc glIsAsyncMarkerSGIX*(marker: GLuint): GLboolean{.stdcall, importc, ogl.}
  # GL_SGIX_flush_raster
proc glFlushRasterSGIX*(){.stdcall, importc, ogl.}
  # GL_SGIX_fragment_lighting
proc glFragmentColorMaterialSGIX*(face: GLenum, mode: GLenum){.stdcall, importc, ogl.}
proc glFragmentLightfSGIX*(light: GLenum, pname: GLenum, param: GLfloat){.
    stdcall, importc, ogl.}
proc glFragmentLightfvSGIX*(light: GLenum, pname: GLenum, params: PGLfloat){.
    stdcall, importc, ogl.}
proc glFragmentLightiSGIX*(light: GLenum, pname: GLenum, param: GLint){.stdcall, importc, ogl.}
proc glFragmentLightivSGIX*(light: GLenum, pname: GLenum, params: PGLint){.
    stdcall, importc, ogl.}
proc glFragmentLightModelfSGIX*(pname: GLenum, param: GLfloat){.stdcall, importc, ogl.}
proc glFragmentLightModelfvSGIX*(pname: GLenum, params: PGLfloat){.stdcall, importc, ogl.}
proc glFragmentLightModeliSGIX*(pname: GLenum, param: GLint){.stdcall, importc, ogl.}
proc glFragmentLightModelivSGIX*(pname: GLenum, params: PGLint){.stdcall, importc, ogl.}
proc glFragmentMaterialfSGIX*(face: GLenum, pname: GLenum, param: GLfloat){.
    stdcall, importc, ogl.}
proc glFragmentMaterialfvSGIX*(face: GLenum, pname: GLenum, params: PGLfloat){.
    stdcall, importc, ogl.}
proc glFragmentMaterialiSGIX*(face: GLenum, pname: GLenum, param: GLint){.
    stdcall, importc, ogl.}
proc glFragmentMaterialivSGIX*(face: GLenum, pname: GLenum, params: PGLint){.
    stdcall, importc, ogl.}
proc glGetFragmentLightfvSGIX*(light: GLenum, pname: GLenum, params: PGLfloat){.
    stdcall, importc, ogl.}
proc glGetFragmentLightivSGIX*(light: GLenum, pname: GLenum, params: PGLint){.
    stdcall, importc, ogl.}
proc glGetFragmentMaterialfvSGIX*(face: GLenum, pname: GLenum, params: PGLfloat){.
    stdcall, importc, ogl.}
proc glGetFragmentMaterialivSGIX*(face: GLenum, pname: GLenum, params: PGLint){.
    stdcall, importc, ogl.}
proc glLightEnviSGIX*(pname: GLenum, param: GLint){.stdcall, importc, ogl.}
  # GL_SGIX_framezoom
proc glFrameZoomSGIX*(factor: GLint){.stdcall, importc, ogl.}
  # GL_SGIX_igloo_interface
proc glIglooInterfaceSGIX*(pname: GLenum, params: PGLvoid){.stdcall, importc, ogl.}
  # GL_SGIX_instruments
proc glGetInstrumentsSGIX*(): GLint{.stdcall, importc, ogl.}
proc glInstrumentsBufferSGIX*(size: GLsizei, buffer: PGLint){.stdcall, importc, ogl.}
proc glPollInstrumentsSGIX*(marker_p: PGLint): GLint{.stdcall, importc, ogl.}
proc glReadInstrumentsSGIX*(marker: GLint){.stdcall, importc, ogl.}
proc glStartInstrumentsSGIX*(){.stdcall, importc, ogl.}
proc glStopInstrumentsSGIX*(marker: GLint){.stdcall, importc, ogl.}
  # GL_SGIX_list_priority
proc glGetListParameterfvSGIX*(list: GLuint, pname: GLenum, params: PGLfloat){.
    stdcall, importc, ogl.}
proc glGetListParameterivSGIX*(list: GLuint, pname: GLenum, params: PGLint){.
    stdcall, importc, ogl.}
proc glListParameterfSGIX*(list: GLuint, pname: GLenum, param: GLfloat){.stdcall, importc, ogl.}
proc glListParameterfvSGIX*(list: GLuint, pname: GLenum, params: PGLfloat){.
    stdcall, importc, ogl.}
proc glListParameteriSGIX*(list: GLuint, pname: GLenum, param: GLint){.stdcall, importc, ogl.}
proc glListParameterivSGIX*(list: GLuint, pname: GLenum, params: PGLint){.
    stdcall, importc, ogl.}
  # GL_SGIX_pixel_texture
proc glPixelTexGenSGIX*(mode: GLenum){.stdcall, importc, ogl.}
  # GL_SGIX_polynomial_ffd
proc glDeformationMap3dSGIX*(target: GLenum, u1: GLdouble, u2: GLdouble, 
                             ustride: GLint, uorder: GLint, v1: GLdouble, 
                             v2: GLdouble, vstride: GLint, vorder: GLint, 
                             w1: GLdouble, w2: GLdouble, wstride: GLint, 
                             worder: GLint, points: PGLdouble){.stdcall, importc, ogl.}
proc glDeformationMap3fSGIX*(target: GLenum, u1: GLfloat, u2: GLfloat, 
                             ustride: GLint, uorder: GLint, v1: GLfloat, 
                             v2: GLfloat, vstride: GLint, vorder: GLint, 
                             w1: GLfloat, w2: GLfloat, wstride: GLint, 
                             worder: GLint, points: PGLfloat){.stdcall, importc, ogl.}
proc glDeformSGIX*(mask: GLbitfield){.stdcall, importc, ogl.}
proc glLoadIdentityDeformationMapSGIX*(mask: GLbitfield){.stdcall, importc, ogl.}
  # GL_SGIX_reference_plane
proc glReferencePlaneSGIX*(equation: PGLdouble){.stdcall, importc, ogl.}
  # GL_SGIX_sprite
proc glSpriteParameterfSGIX*(pname: GLenum, param: GLfloat){.stdcall, importc, ogl.}
proc glSpriteParameterfvSGIX*(pname: GLenum, params: PGLfloat){.stdcall, importc, ogl.}
proc glSpriteParameteriSGIX*(pname: GLenum, param: GLint){.stdcall, importc, ogl.}
proc glSpriteParameterivSGIX*(pname: GLenum, params: PGLint){.stdcall, importc, ogl.}
  # GL_SGIX_tag_sample_buffer
proc glTagSampleBufferSGIX*(){.stdcall, importc, ogl.}
  # GL_SGI_color_table
proc glColorTableSGI*(target: GLenum, internalformat: GLenum, width: GLsizei, 
                      format: GLenum, typ: GLenum, table: PGLvoid){.stdcall, importc, ogl.}
proc glColorTableParameterfvSGI*(target: GLenum, pname: GLenum, params: PGLfloat){.
    stdcall, importc, ogl.}
proc glColorTableParameterivSGI*(target: GLenum, pname: GLenum, params: PGLint){.
    stdcall, importc, ogl.}
proc glCopyColorTableSGI*(target: GLenum, internalformat: GLenum, x: GLint, 
                          y: GLint, width: GLsizei){.stdcall, importc, ogl.}
proc glGetColorTableSGI*(target: GLenum, format: GLenum, typ: GLenum, 
                         table: PGLvoid){.stdcall, importc, ogl.}
proc glGetColorTableParameterfvSGI*(target: GLenum, pname: GLenum, 
                                    params: PGLfloat){.stdcall, importc, ogl.}
proc glGetColorTableParameterivSGI*(target: GLenum, pname: GLenum, 
                                    params: PGLint){.stdcall, importc, ogl.}
  # GL_SUNX_constant_data
proc glFinishTextureSUNX*(){.stdcall, importc, ogl.}
  # GL_SUN_global_alpha
proc glGlobalAlphaFactorbSUN*(factor: GLbyte){.stdcall, importc, ogl.}
proc glGlobalAlphaFactorsSUN*(factor: GLshort){.stdcall, importc, ogl.}
proc glGlobalAlphaFactoriSUN*(factor: GLint){.stdcall, importc, ogl.}
proc glGlobalAlphaFactorfSUN*(factor: GLfloat){.stdcall, importc, ogl.}
proc glGlobalAlphaFactordSUN*(factor: GLdouble){.stdcall, importc, ogl.}
proc glGlobalAlphaFactorubSUN*(factor: GLubyte){.stdcall, importc, ogl.}
proc glGlobalAlphaFactorusSUN*(factor: GLushort){.stdcall, importc, ogl.}
proc glGlobalAlphaFactoruiSUN*(factor: GLuint){.stdcall, importc, ogl.}
  # GL_SUN_mesh_array
proc glDrawMeshArraysSUN*(mode: GLenum, first: GLint, count: GLsizei, 
                          width: GLsizei){.stdcall, importc, ogl.}
  # GL_SUN_triangle_list
proc glReplacementCodeuiSUN*(code: GLuint){.stdcall, importc, ogl.}
proc glReplacementCodeusSUN*(code: GLushort){.stdcall, importc, ogl.}
proc glReplacementCodeubSUN*(code: GLubyte){.stdcall, importc, ogl.}
proc glReplacementCodeuivSUN*(code: PGLuint){.stdcall, importc, ogl.}
proc glReplacementCodeusvSUN*(code: PGLushort){.stdcall, importc, ogl.}
proc glReplacementCodeubvSUN*(code: PGLubyte){.stdcall, importc, ogl.}
proc glReplacementCodePointerSUN*(typ: GLenum, stride: GLsizei, pointer: PGLvoid){.
    stdcall, importc, ogl.}
  # GL_SUN_vertex
proc glColor4ubVertex2fSUN*(r: GLubyte, g: GLubyte, b: GLubyte, a: GLubyte, 
                            x: GLfloat, y: GLfloat){.stdcall, importc, ogl.}
proc glColor4ubVertex2fvSUN*(c: PGLubyte, v: PGLfloat){.stdcall, importc, ogl.}
proc glColor4ubVertex3fSUN*(r: GLubyte, g: GLubyte, b: GLubyte, a: GLubyte, 
                            x: GLfloat, y: GLfloat, z: GLfloat){.stdcall, importc, ogl.}
proc glColor4ubVertex3fvSUN*(c: PGLubyte, v: PGLfloat){.stdcall, importc, ogl.}
proc glColor3fVertex3fSUN*(r: GLfloat, g: GLfloat, b: GLfloat, x: GLfloat, 
                           y: GLfloat, z: GLfloat){.stdcall, importc, ogl.}
proc glColor3fVertex3fvSUN*(c: PGLfloat, v: PGLfloat){.stdcall, importc, ogl.}
proc glNormal3fVertex3fSUN*(nx: GLfloat, ny: GLfloat, nz: GLfloat, x: GLfloat, 
                            y: GLfloat, z: GLfloat){.stdcall, importc, ogl.}
proc glNormal3fVertex3fvSUN*(n: PGLfloat, v: PGLfloat){.stdcall, importc, ogl.}
proc glColor4fNormal3fVertex3fSUN*(r: GLfloat, g: GLfloat, b: GLfloat, 
                                   a: GLfloat, nx: GLfloat, ny: GLfloat, 
                                   nz: GLfloat, x: GLfloat, y: GLfloat, 
                                   z: GLfloat){.stdcall, importc, ogl.}
proc glColor4fNormal3fVertex3fvSUN*(c: PGLfloat, n: PGLfloat, v: PGLfloat){.
    stdcall, importc, ogl.}
proc glTexCoord2fVertex3fSUN*(s: GLfloat, t: GLfloat, x: GLfloat, y: GLfloat, 
                              z: GLfloat){.stdcall, importc, ogl.}
proc glTexCoord2fVertex3fvSUN*(tc: PGLfloat, v: PGLfloat){.stdcall, importc, ogl.}
proc glTexCoord4fVertex4fSUN*(s: GLfloat, t: GLfloat, p: GLfloat, q: GLfloat, 
                              x: GLfloat, y: GLfloat, z: GLfloat, w: GLfloat){.
    stdcall, importc, ogl.}
proc glTexCoord4fVertex4fvSUN*(tc: PGLfloat, v: PGLfloat){.stdcall, importc, ogl.}
proc glTexCoord2fColor4ubVertex3fSUN*(s: GLfloat, t: GLfloat, r: GLubyte, 
                                      g: GLubyte, b: GLubyte, a: GLubyte, 
                                      x: GLfloat, y: GLfloat, z: GLfloat){.
    stdcall, importc, ogl.}
proc glTexCoord2fColor4ubVertex3fvSUN*(tc: PGLfloat, c: PGLubyte, v: PGLfloat){.
    stdcall, importc, ogl.}
proc glTexCoord2fColor3fVertex3fSUN*(s: GLfloat, t: GLfloat, r: GLfloat, 
                                     g: GLfloat, b: GLfloat, x: GLfloat, 
                                     y: GLfloat, z: GLfloat){.stdcall, importc, ogl.}
proc glTexCoord2fColor3fVertex3fvSUN*(tc: PGLfloat, c: PGLfloat, v: PGLfloat){.
    stdcall, importc, ogl.}
proc glTexCoord2fNormal3fVertex3fSUN*(s: GLfloat, t: GLfloat, nx: GLfloat, 
                                      ny: GLfloat, nz: GLfloat, x: GLfloat, 
                                      y: GLfloat, z: GLfloat){.stdcall, importc, ogl.}
proc glTexCoord2fNormal3fVertex3fvSUN*(tc: PGLfloat, n: PGLfloat, v: PGLfloat){.
    stdcall, importc, ogl.}
proc glTexCoord2fColor4fNormal3fVertex3fSUN*(s: GLfloat, t: GLfloat, r: GLfloat, 
    g: GLfloat, b: GLfloat, a: GLfloat, nx: GLfloat, ny: GLfloat, nz: GLfloat, 
    x: GLfloat, y: GLfloat, z: GLfloat){.stdcall, importc, ogl.}
proc glTexCoord2fColor4fNormal3fVertex3fvSUN*(tc: PGLfloat, c: PGLfloat, 
    n: PGLfloat, v: PGLfloat){.stdcall, importc, ogl.}
proc glTexCoord4fColor4fNormal3fVertex4fSUN*(s: GLfloat, t: GLfloat, p: GLfloat, 
    q: GLfloat, r: GLfloat, g: GLfloat, b: GLfloat, a: GLfloat, nx: GLfloat, 
    ny: GLfloat, nz: GLfloat, x: GLfloat, y: GLfloat, z: GLfloat, w: GLfloat){.
    stdcall, importc, ogl.}
proc glTexCoord4fColor4fNormal3fVertex4fvSUN*(tc: PGLfloat, c: PGLfloat, 
    n: PGLfloat, v: PGLfloat){.stdcall, importc, ogl.}
proc glReplacementCodeuiVertex3fSUN*(rc: GLuint, x: GLfloat, y: GLfloat, 
                                     z: GLfloat){.stdcall, importc, ogl.}
proc glReplacementCodeuiVertex3fvSUN*(rc: PGLuint, v: PGLfloat){.stdcall, importc, ogl.}
proc glReplacementCodeuiColor4ubVertex3fSUN*(rc: GLuint, r: GLubyte, g: GLubyte, 
    b: GLubyte, a: GLubyte, x: GLfloat, y: GLfloat, z: GLfloat){.stdcall, importc, ogl.}
proc glReplacementCodeuiColor4ubVertex3fvSUN*(rc: PGLuint, c: PGLubyte, 
    v: PGLfloat){.stdcall, importc, ogl.}
proc glReplacementCodeuiColor3fVertex3fSUN*(rc: GLuint, r: GLfloat, g: GLfloat, 
    b: GLfloat, x: GLfloat, y: GLfloat, z: GLfloat){.stdcall, importc, ogl.}
proc glReplacementCodeuiColor3fVertex3fvSUN*(rc: PGLuint, c: PGLfloat, 
    v: PGLfloat){.stdcall, importc, ogl.}
proc glReplacementCodeuiNormal3fVertex3fSUN*(rc: GLuint, nx: GLfloat, 
    ny: GLfloat, nz: GLfloat, x: GLfloat, y: GLfloat, z: GLfloat){.stdcall, importc, ogl.}
proc glReplacementCodeuiNormal3fVertex3fvSUN*(rc: PGLuint, n: PGLfloat, 
    v: PGLfloat){.stdcall, importc, ogl.}
proc glReplacementCodeuiColor4fNormal3fVertex3fSUN*(rc: GLuint, r: GLfloat, 
    g: GLfloat, b: GLfloat, a: GLfloat, nx: GLfloat, ny: GLfloat, nz: GLfloat, 
    x: GLfloat, y: GLfloat, z: GLfloat){.stdcall, importc, ogl.}
proc glReplacementCodeuiColor4fNormal3fVertex3fvSUN*(rc: PGLuint, c: PGLfloat, 
    n: PGLfloat, v: PGLfloat){.stdcall, importc, ogl.}
proc glReplacementCodeuiTexCoord2fVertex3fSUN*(rc: GLuint, s: GLfloat, 
    t: GLfloat, x: GLfloat, y: GLfloat, z: GLfloat){.stdcall, importc, ogl.}
proc glReplacementCodeuiTexCoord2fVertex3fvSUN*(rc: PGLuint, tc: PGLfloat, 
    v: PGLfloat){.stdcall, importc, ogl.}
proc glReplacementCodeuiTexCoord2fNormal3fVertex3fSUN*(rc: GLuint, s: GLfloat, 
    t: GLfloat, nx: GLfloat, ny: GLfloat, nz: GLfloat, x: GLfloat, y: GLfloat, 
    z: GLfloat){.stdcall, importc, ogl.}
proc glReplacementCodeuiTexCoord2fNormal3fVertex3fvSUN*(rc: PGLuint, 
    tc: PGLfloat, n: PGLfloat, v: PGLfloat){.stdcall, importc, ogl.}
proc glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fSUN*(rc: GLuint, 
    s: GLfloat, t: GLfloat, r: GLfloat, g: GLfloat, b: GLfloat, a: GLfloat, 
    nx: GLfloat, ny: GLfloat, nz: GLfloat, x: GLfloat, y: GLfloat, z: GLfloat){.
    stdcall, importc, ogl.}
proc glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fvSUN*(rc: PGLuint, 
    tc: PGLfloat, c: PGLfloat, n: PGLfloat, v: PGLfloat){.stdcall, importc, ogl.}
  # window support functions
when defined(windows): 
  when not defined(wglGetProcAddress):
    proc wglGetProcAddress*(ProcName: cstring): Pointer{.stdcall, importc, wgl.}
  proc wglCopyContext*(p1: HGLRC, p2: HGLRC, p3: int): BOOL{.stdcall, importc, wgl.}
  proc wglCreateContext*(DC: HDC): HGLRC{.stdcall, importc, wgl.}
  proc wglCreateLayerContext*(p1: HDC, p2: int): HGLRC{.stdcall, importc, wgl.}
  proc wglDeleteContext*(p1: HGLRC): BOOL{.stdcall, importc, wgl.}
  proc wglDescribeLayerPlane*(p1: HDC, p2, p3: int, p4: int, 
                              LayerPlaneDescriptor: pointer): BOOL{.stdcall, importc, wgl.}
  proc wglGetCurrentContext*(): HGLRC{.stdcall, importc, wgl.}
  proc wglGetCurrentDC*(): HDC{.stdcall, importc, wgl.}
  proc wglGetLayerPaletteEntries*(p1: HDC, p2, p3, p4: int, pcr: pointer): int{.
      stdcall, importc, wgl.}
  proc wglMakeCurrent*(DC: HDC, p2: HGLRC): BOOL{.stdcall, importc, wgl.}
  proc wglRealizeLayerPalette*(p1: HDC, p2: int, p3: BOOL): BOOL{.stdcall, importc, wgl.}
  proc wglSetLayerPaletteEntries*(p1: HDC, p2, p3, p4: int, pcr: pointer): int{.
      stdcall, importc, wgl.}
  proc wglShareLists*(p1, p2: HGLRC): BOOL{.stdcall, importc, wgl.}
  proc wglSwapLayerBuffers*(p1: HDC, p2: int): BOOL{.stdcall, importc, wgl.}
  proc wglSwapMultipleBuffers*(p1: int32, p2: PWGLSWAP): int32{.stdcall, importc, wgl.}
  proc wglUseFontBitmapsA*(DC: HDC, p2, p3, p4: int32): BOOL{.stdcall, importc, wgl.}
  proc wglUseFontBitmapsW*(DC: HDC, p2, p3, p4: int32): BOOL{.stdcall, importc, wgl.}
  proc wglUseFontBitmaps*(DC: HDC, p2, p3, p4: int32): BOOL{.stdcall, importc, wgl.}
  proc wglUseFontOutlinesA*(p1: HDC, p2, p3, p4: int32, p5, p6: float32, 
                            p7: int, GlyphMetricsFloat: pointer): BOOL{.stdcall, importc, wgl.}
  proc wglUseFontOutlinesW*(p1: HDC, p2, p3, p4: int32, p5, p6: float32, 
                            p7: int, GlyphMetricsFloat: pointer): BOOL{.stdcall, importc, wgl.}
  proc wglUseFontOutlines*(p1: HDC, p2, p3, p4: int32, p5, p6: float32, p7: int, 
                           GlyphMetricsFloat: pointer): BOOL{.stdcall, importc, wgl.}
    # WGL_ARB_buffer_region
  proc wglCreateBufferRegionARB*(hDC: HDC, iLayerPlane: GLint, uType: GLuint): THandle{.
      stdcall, importc, wgl.}
  proc wglDeleteBufferRegionARB*(hRegion: THandle){.stdcall, importc, wgl.}
  proc wglSaveBufferRegionARB*(hRegion: THandle, x: GLint, y: GLint, 
                               width: GLint, height: GLint): bool{.stdcall, importc, wgl.}
  proc wglRestoreBufferRegionARB*(hRegion: THandle, x: GLint, y: GLint, 
                                  width: GLint, height: GLint, xSrc: GLint, 
                                  ySrc: GLint): bool{.stdcall, importc, wgl.}
    # WGL_ARB_extensions_string
  proc wglGetExtensionsStringARB*(hdc: HDC): cstring{.stdcall, importc, wgl.}
    # WGL_ARB_make_current_read
  proc wglMakeContextCurrentARB*(hDrawDC: HDC, hReadDC: HDC, hglrc: HGLRC): bool{.
      stdcall, importc, wgl.}
  proc wglGetCurrentReadDCARB*(): HDC{.stdcall, importc, wgl.}
    # WGL_ARB_pbuffer
  proc wglCreatePbufferARB*(hDC: HDC, iPixelFormat: GLint, iWidth: GLint, 
                            iHeight: GLint, piAttribList: PGLint): HPBUFFERARB{.
      stdcall, importc, wgl.}
  proc wglGetPbufferDCARB*(hPbuffer: HPBUFFERARB): HDC{.stdcall, importc, wgl.}
  proc wglReleasePbufferDCARB*(hPbuffer: HPBUFFERARB, hDC: HDC): GLint{.stdcall, importc, wgl.}
  proc wglDestroyPbufferARB*(hPbuffer: HPBUFFERARB): bool{.stdcall, importc, wgl.}
  proc wglQueryPbufferARB*(hPbuffer: HPBUFFERARB, iAttribute: GLint, 
                           piValue: PGLint): bool{.stdcall, importc, wgl.}
    # WGL_ARB_pixel_format
  proc wglGetPixelFormatAttribivARB*(hdc: HDC, iPixelFormat: GLint, 
                                     iLayerPlane: GLint, nAttributes: GLuint, 
                                     piAttributes: PGLint, piValues: PGLint): bool{.
      stdcall, importc, wgl.}
  proc wglGetPixelFormatAttribfvARB*(hdc: HDC, iPixelFormat: GLint, 
                                     iLayerPlane: GLint, nAttributes: GLuint, 
                                     piAttributes: PGLint, pfValues: PGLfloat): bool{.
      stdcall, importc, wgl.}
  proc wglChoosePixelFormatARB*(hdc: HDC, piAttribIList: PGLint, 
                                pfAttribFList: PGLfloat, nMaxFormats: GLuint, 
                                piFormats: PGLint, nNumFormats: PGLuint): BOOL{.
      stdcall, importc, wgl.}
    # WGL_ARB_color_buffer_float
  proc wglClampColorARB*(target: GLenum, clamp: GLenum){.stdcall, importc, wgl.}
    # WGL_ARB_render_texture
  proc wglBindTexImageARB*(hPbuffer: HPBUFFERARB, iBuffer: GLint): bool{.stdcall, importc, wgl.}
  proc wglReleaseTexImageARB*(hPbuffer: HPBUFFERARB, iBuffer: GLint): bool{.
      stdcall, importc, wgl.}
  proc wglSetPbufferAttribARB*(hPbuffer: HPBUFFERARB, piAttribList: PGLint): bool{.
      stdcall, importc, wgl.}
    # WGL_ARB_create_context
  proc wglCreateContextAttribsARB*(hDC: HDC, hShareContext: HGLRC, 
                                   attribList: PGLint): HGLRC{.stdcall, importc, wgl.}
    # WGL_AMD_gpu_association
  proc wglGetGPUIDsAMD*(maxCount: int, ids: ptr int): int{.stdcall, importc, wgl.}
  proc wglGetGPUInfoAMD*(id: int, prop: int, dataType: GLenum, size: int, 
                         data: Pointer): int{.stdcall, importc, wgl.}
  proc wglGetContextGPUIDAMD*(hglrc: HGLRC): int{.stdcall, importc, wgl.}
  proc wglCreateAssociatedContextAMD*(id: int): HGLRC{.stdcall, importc, wgl.}
  proc wglCreateAssociatedContextAttribsAMD*(id: int, hShareContext: HGLRC, 
      attribList: ptr int32): HGLRC{.stdcall, importc, wgl.}
  proc wglDeleteAssociatedContextAMD*(hglrc: HGLRC): bool{.stdcall, importc, wgl.}
  proc wglMakeAssociatedContextCurrentAMD*(hglrc: HGLRC): bool{.stdcall, importc, wgl.}
  proc wglGetCurrentAssociatedContextAMD*(): HGLRC{.stdcall, importc, wgl.}
  proc wglBlitContextFramebufferAMD*(dstCtx: HGLRC, srcX0: GLint, srcY0: GLint, 
                                     srcX1: GLint, srcY1: GLint, dstX0: GLint, 
                                     dstY0: GLint, dstX1: GLint, dstY1: GLint, 
                                     mask: GLbitfield, filter: GLenum){.stdcall, importc, wgl.}
    # WGL_EXT_display_color_table
  proc wglCreateDisplayColorTableEXT*(id: GLushort): GLboolean{.stdcall, importc, wgl.}
  proc wglLoadDisplayColorTableEXT*(table: PGLushort, len: GLuint): GLboolean{.
      stdcall, importc, wgl.}
  proc wglBindDisplayColorTableEXT*(id: GLushort): GLboolean{.stdcall, importc, wgl.}
  proc wglDestroyDisplayColorTableEXT*(id: GLushort){.stdcall, importc, wgl.}
    # WGL_EXT_extensions_string
  proc wglGetExtensionsStringEXT*(): cstring{.stdcall, importc, wgl.}
    # WGL_EXT_make_current_read
  proc wglMakeContextCurrentEXT*(hDrawDC: HDC, hReadDC: HDC, hglrc: HGLRC): bool{.
      stdcall, importc, wgl.}
  proc wglGetCurrentReadDCEXT*(): HDC{.stdcall, importc, wgl.}
    # WGL_EXT_pbuffer
  proc wglCreatePbufferEXT*(hDC: HDC, iPixelFormat: GLint, iWidth: GLint, 
                            iHeight: GLint, piAttribList: PGLint): HPBUFFEREXT{.
      stdcall, importc, wgl.}
  proc wglGetPbufferDCEXT*(hPbuffer: HPBUFFEREXT): HDC{.stdcall, importc, wgl.}
  proc wglReleasePbufferDCEXT*(hPbuffer: HPBUFFEREXT, hDC: HDC): GLint{.stdcall, importc, wgl.}
  proc wglDestroyPbufferEXT*(hPbuffer: HPBUFFEREXT): bool{.stdcall, importc, wgl.}
  proc wglQueryPbufferEXT*(hPbuffer: HPBUFFEREXT, iAttribute: GLint, 
                           piValue: PGLint): bool{.stdcall, importc, wgl.}
    # WGL_EXT_pixel_format
  proc wglGetPixelFormatAttribivEXT*(hdc: HDC, iPixelFormat: GLint, 
                                     iLayerPlane: GLint, nAttributes: GLuint, 
                                     piAttributes: PGLint, piValues: PGLint): bool{.
      stdcall, importc, wgl.}
  proc wglGetPixelFormatAttribfvEXT*(hdc: HDC, iPixelFormat: GLint, 
                                     iLayerPlane: GLint, nAttributes: GLuint, 
                                     piAttributes: PGLint, pfValues: PGLfloat): bool{.
      stdcall, importc, wgl.}
  proc wglChoosePixelFormatEXT*(hdc: HDC, piAttribIList: PGLint, 
                                pfAttribFList: PGLfloat, nMaxFormats: GLuint, 
                                piFormats: PGLint, nNumFormats: PGLuint): bool{.
      stdcall, importc, wgl.}
    # WGL_EXT_swap_control
  proc wglSwapIntervalEXT*(interval: GLint): bool{.stdcall, importc, wgl.}
  proc wglGetSwapIntervalEXT*(): GLint{.stdcall, importc, wgl.}
    # WGL_I3D_digital_video_control
  proc wglGetDigitalVideoParametersI3D*(hDC: HDC, iAttribute: GLint, 
                                        piValue: PGLint): bool{.stdcall, importc, wgl.}
  proc wglSetDigitalVideoParametersI3D*(hDC: HDC, iAttribute: GLint, 
                                        piValue: PGLint): bool{.stdcall, importc, wgl.}
    # WGL_I3D_gamma
  proc wglGetGammaTableParametersI3D*(hDC: HDC, iAttribute: GLint, 
                                      piValue: PGLint): bool{.stdcall, importc, wgl.}
  proc wglSetGammaTableParametersI3D*(hDC: HDC, iAttribute: GLint, 
                                      piValue: PGLint): bool{.stdcall, importc, wgl.}
  proc wglGetGammaTableI3D*(hDC: HDC, iEntries: GLint, puRed: PGLushort, 
                            puGreen: PGLushort, puBlue: PGLushort): bool{.
      stdcall, importc, wgl.}
  proc wglSetGammaTableI3D*(hDC: HDC, iEntries: GLint, puRed: PGLushort, 
                            puGreen: PGLushort, puBlue: PGLushort): bool{.
      stdcall, importc, wgl.}
    # WGL_I3D_genlock
  proc wglEnableGenlockI3D*(hDC: HDC): bool{.stdcall, importc, wgl.}
  proc wglDisableGenlockI3D*(hDC: HDC): bool{.stdcall, importc, wgl.}
  proc wglIsEnabledGenlockI3D*(hDC: HDC, pFlag: bool): bool{.stdcall, importc, wgl.}
  proc wglGenlockSourceI3D*(hDC: HDC, uSource: GLuint): bool{.stdcall, importc, wgl.}
  proc wglGetGenlockSourceI3D*(hDC: HDC, uSource: PGLuint): bool{.stdcall, importc, wgl.}
  proc wglGenlockSourceEdgeI3D*(hDC: HDC, uEdge: GLuint): bool{.stdcall, importc, wgl.}
  proc wglGetGenlockSourceEdgeI3D*(hDC: HDC, uEdge: PGLuint): bool{.stdcall, importc, wgl.}
  proc wglGenlockSampleRateI3D*(hDC: HDC, uRate: GLuint): bool{.stdcall, importc, wgl.}
  proc wglGetGenlockSampleRateI3D*(hDC: HDC, uRate: PGLuint): bool{.stdcall, importc, wgl.}
  proc wglGenlockSourceDelayI3D*(hDC: HDC, uDelay: GLuint): bool{.stdcall, importc, wgl.}
  proc wglGetGenlockSourceDelayI3D*(hDC: HDC, uDelay: PGLuint): bool{.stdcall, importc, wgl.}
  proc wglQueryGenlockMaxSourceDelayI3D*(hDC: HDC, uMaxLineDelay: PGLuint, 
      uMaxPixelDelay: PGLuint): bool{.stdcall, importc, wgl.}
    # WGL_I3D_image_buffer
  proc wglCreateImageBufferI3D*(hDC: HDC, dwSize: GLuint, uFlags: GLuint): GLvoid{.
      stdcall, importc, wgl.}
  proc wglDestroyImageBufferI3D*(hDC: HDC, pAddress: GLvoid): bool{.stdcall, importc, wgl.}
  proc wglAssociateImageBufferEventsI3D*(hDC: HDC, pEvent: THandle, 
      pAddress: PGLvoid, pSize: PGLuint, count: GLuint): bool{.stdcall, importc, wgl.}
  proc wglReleaseImageBufferEventsI3D*(hDC: HDC, pAddress: PGLvoid, 
                                       count: GLuint): bool{.stdcall, importc, wgl.}
    # WGL_I3D_swap_frame_lock
  proc wglEnableFrameLockI3D*(): bool{.stdcall, importc, wgl.}
  proc wglDisableFrameLockI3D*(): bool{.stdcall, importc, wgl.}
  proc wglIsEnabledFrameLockI3D*(pFlag: bool): bool{.stdcall, importc, wgl.}
  proc wglQueryFrameLockMasterI3D*(pFlag: bool): bool{.stdcall, importc, wgl.}
    # WGL_I3D_swap_frame_usage
  proc wglGetFrameUsageI3D*(pUsage: PGLfloat): bool{.stdcall, importc, wgl.}
  proc wglBeginFrameTrackingI3D*(): bool{.stdcall, importc, wgl.}
  proc wglEndFrameTrackingI3D*(): bool{.stdcall, importc, wgl.}
  proc wglQueryFrameTrackingI3D*(pFrameCount: PGLuint, pMissedFrames: PGLuint, 
                                 pLastMissedUsage: PGLfloat): bool{.stdcall, importc, wgl.}
    # WGL_NV_vertex_array_range
  proc wglAllocateMemoryNV*(size: GLsizei, readfreq: GLfloat, 
                            writefreq: GLfloat, priority: GLfloat){.stdcall, importc, wgl.}
  proc wglFreeMemoryNV*(pointer: Pointer){.stdcall, importc, wgl.}
    # WGL_NV_present_video
  proc wglEnumerateVideoDevicesNV*(hdc: HDC, phDeviceList: PHVIDEOOUTPUTDEVICENV): int{.
      stdcall, importc, wgl.}
  proc wglBindVideoDeviceNV*(hd: HDC, uVideoSlot: int, 
                             hVideoDevice: HVIDEOOUTPUTDEVICENV, 
                             piAttribList: ptr int32): bool{.stdcall, importc, wgl.}
  proc wglQueryCurrentContextNV*(iAttribute: int, piValue: ptr int32): bool{.
      stdcall, importc, wgl.}
    # WGL_NV_video_output
  proc wglGetVideoDeviceNV*(hDC: HDC, numDevices: int, hVideoDevice: PHPVIDEODEV): bool{.
      stdcall, importc, wgl.}
  proc wglReleaseVideoDeviceNV*(hVideoDevice: HPVIDEODEV): bool{.stdcall, importc, wgl.}
  proc wglBindVideoImageNV*(hVideoDevice: HPVIDEODEV, hPbuffer: HPBUFFERARB, 
                            iVideoBuffer: int): bool{.stdcall, importc, wgl.}
  proc wglReleaseVideoImageNV*(hPbuffer: HPBUFFERARB, iVideoBuffer: int): bool{.
      stdcall, importc, wgl.}
  proc wglSendPbufferToVideoNV*(hPbuffer: HPBUFFERARB, iBufferType: int, 
                                pulCounterPbuffer: ptr int, bBlock: bool): bool{.
      stdcall, importc, wgl.}
  proc wglGetVideoInfoNV*(hpVideoDevice: HPVIDEODEV, 
                          pulCounterOutputPbuffer: ptr int, 
                          pulCounterOutputVideo: ptr int): bool{.stdcall, importc, wgl.}
    # WGL_NV_swap_group
  proc wglJoinSwapGroupNV*(hDC: HDC, group: GLuint): bool{.stdcall, importc, wgl.}
  proc wglBindSwapBarrierNV*(group: GLuint, barrier: GLuint): bool{.stdcall, importc, wgl.}
  proc wglQuerySwapGroupNV*(hDC: HDC, group: PGLuint, barrier: PGLuint): bool{.
      stdcall, importc, wgl.}
  proc wglQueryMaxSwapGroupsNV*(hDC: HDC, mxGroups: PGLuint, 
                                maxBarriers: PGLuint): bool{.stdcall, importc, wgl.}
  proc wglQueryFrameCountNV*(hDC: HDC, count: PGLuint): bool{.stdcall, importc, wgl.}
  proc wglResetFrameCountNV*(hDC: HDC): bool{.stdcall, importc, wgl.}
    # WGL_NV_gpu_affinity
  proc wglEnumGpusNV*(iGpuIndex: int, phGpu: PHGPUNV): bool{.stdcall, importc, wgl.}
  proc wglEnumGpuDevicesNV*(hGpu: HGPUNV, iDeviceIndex: int, 
                            lpGpuDevice: PGPU_DEVICE): bool{.stdcall, importc, wgl.}
  proc wglCreateAffinityDCNV*(phGpuList: PHGPUNV): HDC{.stdcall, importc, wgl.}
  proc wglEnumGpusFromAffinityDCNV*(hAffinityDC: HDC, iGpuIndex: int, 
                                    hGpu: PHGPUNV): bool{.stdcall, importc, wgl.}
  proc wglDeleteDCNV*(hDC: HDC): bool{.stdcall, importc, wgl.}
    # WGL_NV_video_capture
  proc wglBindVideoCaptureDeviceNV*(uVideoSlot: int, 
                                    hDevice: HVIDEOINPUTDEVICENV): bool{.stdcall, importc, wgl.}
  proc wglEnumerateVideoCaptureDevicesNV*(hDc: HDC, 
      phDeviceList: PHVIDEOINPUTDEVICENV): int{.stdcall, importc, wgl.}
  proc wglLockVideoCaptureDeviceNV*(hDc: HDC, hDevice: HVIDEOINPUTDEVICENV): bool{.
      stdcall, importc, wgl.}
  proc wglQueryVideoCaptureDeviceNV*(hDc: HDC, hDevice: HVIDEOINPUTDEVICENV, 
                                     iAttribute: int, piValue: ptr int32): bool{.
      stdcall, importc, wgl.}
  proc wglReleaseVideoCaptureDeviceNV*(hDc: HDC, hDevice: HVIDEOINPUTDEVICENV): bool{.
      stdcall, importc, wgl.}
    # WGL_NV_copy_image
  proc wglCopyImageSubDataNV*(hSrcRc: HGLRC, srcName: GLuint, srcTarget: GLenum, 
                              srcLevel: GLint, srcX: GLint, srcY: GLint, 
                              srcZ: GLint, hDstRC: HGLRC, dstName: GLuint, 
                              dstTarget: GLenum, dstLevel: GLint, dstX: GLint, 
                              dstY: GLint, dstZ: GLint, width: GLsizei, 
                              height: GLsizei, depth: GLsizei): bool{.stdcall, importc, wgl.}
    # WGL_NV_DX_interop
  proc wglDXSetResourceShareHandleNV*(dxObject: PGLVoid, hareHandle: int): bool{.
      stdcall, importc, wgl.}
  proc wglDXOpenDeviceNV*(dxDevice: PGLVoid): int{.stdcall, importc, wgl.}
  proc wglDXCloseDeviceNV*(hDevice: int): bool{.stdcall, importc, wgl.}
  proc wglDXRegisterObjectNV*(hDevice: int, dxObject: PGLVoid, name: GLUInt, 
                              typ: TGLEnum, access: TGLenum): int{.stdcall, importc, wgl.}
  proc wglDXUnregisterObjectNV*(hDevice: int, hObject: int): bool{.stdcall, importc, wgl.}
  proc wglDXObjectAccessNV*(hObject: int, access: GLenum): bool{.stdcall, importc, wgl.}
  proc wglDXLockObjectsNV*(hDevice: int, count: GLint, hObjects: ptr int): bool{.
      stdcall, importc, wgl.}
  proc wglDXUnlockObjectsNV*(hDevice: int, count: GLint, hObjects: ptr int): bool{.
      stdcall, importc, wgl.}
    # WGL_OML_sync_control
  proc wglGetSyncValuesOML*(hdc: HDC, ust: PGLint64, msc: PGLint64, 
                            sbc: PGLint64): bool{.stdcall, importc, wgl.}
  proc wglGetMscRateOML*(hdc: HDC, numerator: PGLint, denominator: PGLint): bool{.
      stdcall, importc, wgl.}
  proc wglSwapBuffersMscOML*(hdc: HDC, target_msc: GLint64, divisor: GLint64, 
                             remainder: GLint64): GLint64{.stdcall, importc, wgl.}
  proc wglSwapLayerBuffersMscOML*(hdc: HDC, fuPlanes: GLint, 
                                  target_msc: GLint64, divisor: GLint64, 
                                  remainder: GLint64): GLint64{.stdcall, importc, wgl.}
  proc wglWaitForMscOML*(hdc: HDC, target_msc: GLint64, divisor: GLint64, 
                         remainder: GLint64, ust: PGLint64, msc: PGLint64, 
                         sbc: PGLint64): bool{.stdcall, importc, wgl.}
  proc wglWaitForSbcOML*(hdc: HDC, target_sbc: GLint64, ust: PGLint64, 
                         msc: PGLint64, sbc: PGLint64): bool{.stdcall, importc, wgl.}
    # WGL_3DL_stereo_control
  proc wglSetStereoEmitterState3DL*(hDC: HDC, uState: int32): bool{.stdcall, importc, wgl.}
    # WIN_draw_range_elements
  proc glDrawRangeElementsWIN*(mode: GLenum, start: GLuint, ending: GLuint, 
                               count: GLsizei, typ: GLenum, indices: PGLvoid){.
      stdcall, importc, wgl.}
    # WIN_swap_hint
  proc glAddSwapHintRectWIN*(x: GLint, y: GLint, width: GLsizei, height: GLsizei){.
      stdcall, importc, wgl.}
when defined(LINUX): 
  proc glXChooseVisual*(dpy: PDisplay, screen: GLint, attribList: PGLint): PXVisualInfo{.
      stdcall, importc, oglx.}
  proc glXCopyContext*(dpy: PDisplay, src: GLXContext, dst: GLXContext, 
                       mask: GLuint){.stdcall, importc, oglx.}
  proc glXCreateContext*(dpy: PDisplay, vis: PXVisualInfo, 
                         shareList: GLXContext, direct: GLboolean): GLXContext{.
      stdcall, importc, oglx.}
  proc glXCreateGLXPixmap*(dpy: PDisplay, vis: PXVisualInfo, pixmap: Pixmap): GLXPixmap{.
      stdcall, importc, oglx.}
  proc glXDestroyContext*(dpy: PDisplay, ctx: GLXContext){.stdcall, importc, oglx.}
  proc glXDestroyGLXPixmap*(dpy: PDisplay, pix: GLXPixmap){.stdcall, importc, oglx.}
  proc glXGetConfig*(dpy: PDisplay, vis: PXVisualInfo, attrib: GLint, 
                     value: PGLint): GLint{.stdcall, importc, oglx.}
  proc glXGetCurrentContext*(): GLXContext{.stdcall, importc, oglx.}
  proc glXGetCurrentDrawable*(): GLXDrawable{.stdcall, importc, oglx.}
  proc glXIsDirect*(dpy: PDisplay, ctx: GLXContext): glboolean{.stdcall, importc, oglx.}
  proc glXMakeCurrent*(dpy: PDisplay, drawable: GLXDrawable, ctx: GLXContext): GLboolean{.
      stdcall, importc, oglx.}
  proc glXQueryExtension*(dpy: PDisplay, errorBase: PGLint, eventBase: PGLint): GLboolean{.
      stdcall, importc, oglx.}
  proc glXQueryVersion*(dpy: PDisplay, major: PGLint, minor: PGLint): GLboolean{.
      stdcall, importc, oglx.}
  proc glXSwapBuffers*(dpy: PDisplay, drawable: GLXDrawable){.stdcall, importc, oglx.}
  proc glXUseXFont*(font: Font, first: GLint, count: GLint, listBase: GLint){.
      stdcall, importc, oglx.}
  proc glXWaitGL*(){.stdcall, importc, oglx.}
  proc glXWaitX*(){.stdcall, importc, oglx.}
  proc glXGetClientString*(dpy: PDisplay, name: GLint): PGLchar{.stdcall, importc, oglx.}
  proc glXQueryServerString*(dpy: PDisplay, screen: GLint, name: GLint): PGLchar{.
      stdcall, importc, oglx.}
  proc glXQueryExtensionsString*(dpy: PDisplay, screen: GLint): PGLchar{.stdcall, importc, oglx.}
    # GLX_VERSION_1_3
  proc glXGetFBConfigs*(dpy: PDisplay, screen: GLint, nelements: PGLint): GLXFBConfig{.
      stdcall, importc, oglx.}
  proc glXChooseFBConfig*(dpy: PDisplay, screen: GLint, attrib_list: PGLint, 
                          nelements: PGLint): GLXFBConfig{.stdcall, importc, oglx.}
  proc glXGetFBConfigAttrib*(dpy: PDisplay, config: GLXFBConfig, 
                             attribute: GLint, value: PGLint): glint{.stdcall, importc, oglx.}
  proc glXGetVisualFromFBConfig*(dpy: PDisplay, config: GLXFBConfig): PXVisualInfo{.stdcall, importc, oglx.}
  proc glXCreateWindow*(dpy: PDisplay, config: GLXFBConfig, win: Window, 
                        attrib_list: PGLint): GLXWindow{.stdcall, importc, oglx.}
  proc glXDestroyWindow*(dpy: PDisplay, win: GLXWindow){.stdcall, importc, oglx.}
  proc glXCreatePixmap*(dpy: PDisplay, config: GLXFBConfig, pixmap: Pixmap, 
                        attrib_list: PGLint): GLXPixmap{.stdcall, importc, oglx.}
  proc glXDestroyPixmap*(dpy: PDisplay, pixmap: GLXPixmap){.stdcall, importc, oglx.}
  proc glXCreatePbuffer*(dpy: PDisplay, config: GLXFBConfig, attrib_list: PGLint): GLXPbuffer{.
      stdcall, importc, oglx.}
  proc glXDestroyPbuffer*(dpy: PDisplay, pbuf: GLXPbuffer){.stdcall, importc, oglx.}
  proc glXQueryDrawable*(dpy: PDisplay, draw: GLXDrawable, attribute: GLint, 
                         value: PGLuint){.stdcall, importc, oglx.}
  proc glXCreateNewContext*(dpy: PDisplay, config: GLXFBConfig, 
                            rendertyp: GLint, share_list: GLXContext, 
                            direct: GLboolean): GLXContext{.stdcall, importc, oglx.}
  proc glXMakeContextCurrent*(display: PDisplay, draw: GLXDrawable, 
                              read: GLXDrawable, ctx: GLXContext): GLboolean{.
      stdcall, importc, oglx.}
  proc glXGetCurrentReadDrawable*(): GLXDrawable{.stdcall, importc, oglx.}
  proc glXGetCurreentDisplay*(): PDisplay{.stdcall, importc, oglx.}
  proc glXQueryContext*(dpy: PDisplay, ctx: GLXContext, attribute: GLint, 
                        value: PGLint): GLint{.stdcall, importc, oglx.}
  proc glXSelectEvent*(dpy: PDisplay, draw: GLXDrawable, event_mask: GLuint){.
      stdcall, importc, oglx.}
  proc glXGetSelectedEvent*(dpy: PDisplay, draw: GLXDrawable, 
                            event_mask: PGLuint){.stdcall, importc, oglx.}
    # GLX_VERSION_1_4
  when not defined(glXGetProcAddress):
    proc glXGetProcAddress*(name: cstring): pointer{.stdcall, importc, oglx.}
    # GLX_ARB_get_proc_address
  when not defined(glXGetProcAddressARB):
    proc glXGetProcAddressARB*(name: cstring): pointer{.stdcall, importc, oglx.}
    # GLX_ARB_create_context
  proc glXCreateContextAttribsARB*(dpy: PDisplay, config: GLXFBConfig, 
                                   share_context: GLXContext, direct: GLboolean, 
                                   attrib_list: PGLint): GLXContext{.stdcall, importc, oglx.}
    # GLX_EXT_import_context
  proc glXGetCurrentDisplayEXT*(): PDisplay{.stdcall, importc, oglx.}
  proc glXQueryContextInfoEXT*(dpy: PDisplay, context: GLXContext, 
                               attribute: GLint, value: PGLint): GLint{.stdcall, importc, oglx.}
  proc glXGetContextIDEXT*(context: GLXContext): GLXContextID{.stdcall, importc, oglx.}
  proc glXImportContextEXT*(dpy: PDisplay, contextID: GLXContextID): GLXContext{.
      stdcall, importc, oglx.}
  proc glXFreeContextEXT*(dpy: PDisplay, context: GLXContext){.stdcall, importc, oglx.}
    # GLX_EXT_texture_from_pixmap
  proc glXBindTexImageEXT*(dpy: PDisplay, drawable: GLXDrawable, buffer: GLint, 
                           attrib_list: PGLint){.stdcall, importc, oglx.}
  proc glXReleaseTexImageEXT*(dpy: PDisplay, drawable: GLXDrawable, 
                              buffer: GLint){.stdcall, importc, oglx.}
# GL utility functions and procedures

proc gluErrorString*(errCode: GLenum): Cstring{.stdcall, importc, glu.}
proc gluGetString*(name: GLenum): Cstring{.stdcall, importc, glu.}
proc gluOrtho2D*(left, right, bottom, top: GLdouble){.stdcall, importc, glu.}
proc gluPerspective*(fovy, aspect, zNear, zFar: GLdouble){.stdcall, importc, glu.}
proc gluPickMatrix*(x, y, width, height: GLdouble, viewport: TVector4i){.stdcall, importc, glu.}
proc gluLookAt*(eyex, eyey, eyez, centerx, centery, centerz, upx, upy, upz: GLdouble){.
    stdcall, importc, glu.}
proc gluProject*(objx, objy, objz: GLdouble, modelMatrix: TGLMatrixd4, 
                 projMatrix: TGLMatrixd4, viewport: TVector4i, 
                 winx, winy, winz: PGLdouble): GLint{.stdcall, importc, glu.}
proc gluUnProject*(winx, winy, winz: GLdouble, modelMatrix: TGLMatrixd4, 
                   projMatrix: TGLMatrixd4, viewport: TVector4i, 
                   objx, objy, objz: PGLdouble): GLint{.stdcall, importc, glu.}
proc gluScaleImage*(format: GLenum, widthin, heightin: GLint, typein: GLenum, 
                    datain: Pointer, widthout, heightout: GLint, 
                    typeout: GLenum, dataout: Pointer): GLint{.stdcall, importc, glu.}
proc gluBuild1DMipmaps*(target: GLenum, components, width: GLint, 
                        format, atype: GLenum, data: Pointer): GLint{.stdcall, importc, glu.}
proc gluBuild2DMipmaps*(target: GLenum, components, width, height: GLint, 
                        format, atype: GLenum, Data: Pointer): GLint{.stdcall, importc, glu.}
proc gluNewQuadric*(): PGLUQuadric{.stdcall, importc, glu.}
proc gluDeleteQuadric*(state: PGLUQuadric){.stdcall, importc, glu.}
proc gluQuadricNormals*(quadObject: PGLUQuadric, normals: GLenum){.stdcall, importc, glu.}
proc gluQuadricTexture*(quadObject: PGLUQuadric, textureCoords: GLboolean){.
    stdcall, importc, glu.}
proc gluQuadricOrientation*(quadObject: PGLUQuadric, orientation: GLenum){.
    stdcall, importc, glu.}
proc gluQuadricDrawStyle*(quadObject: PGLUQuadric, drawStyle: GLenum){.stdcall, importc, glu.}
proc gluCylinder*(quadObject: PGLUQuadric, 
                  baseRadius, topRadius, height: GLdouble, slices, stacks: GLint){.
    stdcall, importc, glu.}
proc gluDisk*(quadObject: PGLUQuadric, innerRadius, outerRadius: GLdouble, 
              slices, loops: GLint){.stdcall, importc, glu.}
proc gluPartialDisk*(quadObject: PGLUQuadric, 
                     innerRadius, outerRadius: GLdouble, slices, loops: GLint, 
                     startAngle, sweepAngle: GLdouble){.stdcall, importc, glu.}
proc gluSphere*(quadObject: PGLUQuadric, radius: GLdouble, slices, stacks: GLint){.
    stdcall, importc, glu.}
proc gluQuadricCallback*(quadObject: PGLUQuadric, which: GLenum, 
                         fn: TGLUQuadricErrorProc){.stdcall, importc, glu.}
proc gluNewTess*(): PGLUTesselator{.stdcall, importc, glu.}
proc gluDeleteTess*(tess: PGLUTesselator){.stdcall, importc, glu.}
proc gluTessBeginPolygon*(tess: PGLUTesselator, polygon_data: Pointer){.stdcall, importc, glu.}
proc gluTessBeginContour*(tess: PGLUTesselator){.stdcall, importc, glu.}
proc gluTessVertex*(tess: PGLUTesselator, coords: TGLArrayd3, data: Pointer){.
    stdcall, importc, glu.}
proc gluTessEndContour*(tess: PGLUTesselator){.stdcall, importc, glu.}
proc gluTessEndPolygon*(tess: PGLUTesselator){.stdcall, importc, glu.}
proc gluTessProperty*(tess: PGLUTesselator, which: GLenum, value: GLdouble){.
    stdcall, importc, glu.}
proc gluTessNormal*(tess: PGLUTesselator, x, y, z: GLdouble){.stdcall, importc, glu.}
proc gluTessCallback*(tess: PGLUTesselator, which: GLenum, fn: Pointer){.stdcall, importc, glu.}
proc gluGetTessProperty*(tess: PGLUTesselator, which: GLenum, value: PGLdouble){.
    stdcall, importc, glu.}
proc gluNewNurbsRenderer*(): PGLUNurbs{.stdcall, importc, glu.}
proc gluDeleteNurbsRenderer*(nobj: PGLUNurbs){.stdcall, importc, glu.}
proc gluBeginSurface*(nobj: PGLUNurbs){.stdcall, importc, glu.}
proc gluBeginCurve*(nobj: PGLUNurbs){.stdcall, importc, glu.}
proc gluEndCurve*(nobj: PGLUNurbs){.stdcall, importc, glu.}
proc gluEndSurface*(nobj: PGLUNurbs){.stdcall, importc, glu.}
proc gluBeginTrim*(nobj: PGLUNurbs){.stdcall, importc, glu.}
proc gluEndTrim*(nobj: PGLUNurbs){.stdcall, importc, glu.}
proc gluPwlCurve*(nobj: PGLUNurbs, count: GLint, points: PGLfloat, 
                  stride: GLint, atype: GLenum){.stdcall, importc, glu.}
proc gluNurbsCurve*(nobj: PGLUNurbs, nknots: GLint, knot: PGLfloat, 
                    stride: GLint, ctlarray: PGLfloat, order: GLint, 
                    atype: GLenum){.stdcall, importc, glu.}
proc gluNurbsSurface*(nobj: PGLUNurbs, sknot_count: GLint, sknot: PGLfloat, 
                      tknot_count: GLint, tknot: PGLfloat, 
                      s_stride, t_stride: GLint, ctlarray: PGLfloat, 
                      sorder, torder: GLint, atype: GLenum){.stdcall, importc, glu.}
proc gluLoadSamplingMatrices*(nobj: PGLUNurbs, 
                              modelMatrix, projMatrix: TGLMatrixf4, 
                              viewport: TVector4i){.stdcall, importc, glu.}
proc gluNurbsProperty*(nobj: PGLUNurbs, aproperty: GLenum, value: GLfloat){.
    stdcall, importc, glu.}
proc gluGetNurbsProperty*(nobj: PGLUNurbs, aproperty: GLenum, value: PGLfloat){.
    stdcall, importc, glu.}
proc gluNurbsCallback*(nobj: PGLUNurbs, which: GLenum, fn: TGLUNurbsErrorProc){.
    stdcall, importc, glu.}
proc gluBeginPolygon*(tess: PGLUTesselator){.stdcall, importc, glu.}
proc gluNextContour*(tess: PGLUTesselator, atype: GLenum){.stdcall, importc, glu.}
proc gluEndPolygon*(tess: PGLUTesselator){.stdcall, importc, glu.}

type 
  TRCOption* = enum 
    opDoubleBuffered, opGDI, opStereo
  TRCOptions* = Set[TRCOption]

var lastPixelFormat*: Int

when defined(windows): 
  proc CreateRenderingContext*(DC: HDC, Options: TRCOptions, ColorBits, ZBits, 
      StencilBits, AccumBits, AuxBuffers: int, Layer: int): HGLRC
  proc DestroyRenderingContext*(RC: HGLRC)
  proc ActivateRenderingContext*(DC: HDC, RC: HGLRC)
  proc DeactivateRenderingContext*()
# implementation

proc getExtensionString*(): String = 
  when defined(windows):
    result = $glGetString(GL_EXTENSIONS) & ' ' & $wglGetExtensionsStringEXT() & 
        ' ' & $wglGetExtensionsStringARB(wglGetCurrentDC())
  else:
    result = $glGetString(GL_EXTENSIONS)

when defined(windows): 
  proc CreateRenderingContext(DC: HDC, Options: TRCOptions, ColorBits, ZBits, 
      StencilBits, AccumBits, AuxBuffers: int, Layer: int): HGLRC = 
    type
      TPIXELFORMATDESCRIPTOR {.final, pure.} = object
        nSize: int16
        nVersion: int16
        dwFlags: DWORD
        iPixelType: int8
        cColorBits: int8
        cRedBits: int8
        cRedShift: int8
        cGreenBits: int8
        cGreenShift: int8
        cBlueBits: int8
        cBlueShift: int8
        cAlphaBits: int8
        cAlphaShift: int8
        cAccumBits: int8
        cAccumRedBits: int8
        cAccumGreenBits: int8
        cAccumBlueBits: int8
        cAccumAlphaBits: int8
        cDepthBits: int8
        cStencilBits: int8
        cAuxBuffers: int8
        iLayerType: int8
        bReserved: int8
        dwLayerMask: DWORD
        dwVisibleMask: DWORD
        dwDamageMask: DWORD

    proc GetObjectType(h: HDC): DWORD{.stdcall, dynlib: "gdi32",
                                           importc: "GetObjectType".}
    proc ChoosePixelFormat(para1: HDC, para2: ptr TPIXELFORMATDESCRIPTOR): int32{.
        stdcall, dynlib: "gdi32", importc: "ChoosePixelFormat".}
    proc GetPixelFormat(para1: HDC): int32{.stdcall, dynlib: "gdi32",
        importc: "GetPixelFormat".}
    proc SetPixelFormat(para1: HDC, para2: int32, 
        para3: ptr TPIXELFORMATDESCRIPTOR): WINBOOL{.
        stdcall, dynlib: "gdi32", importc: "SetPixelFormat".}
    proc DescribePixelFormat(para1: HDC, para2, para3: int32,
                             para4: ptr TPIXELFORMATDESCRIPTOR) {.stdcall,
        dynlib: "gdi32", importc: "DescribePixelFormat".}

    const 
      OBJ_MEMDC = 10'i32
      OBJ_ENHMETADC = 12'i32
      OBJ_METADC = 4'i32
      PFD_DOUBLEBUFFER = 0x00000001
      PFD_STEREO = 0x00000002
      PFD_DRAW_TO_WINDOW = 0x00000004
      PFD_DRAW_TO_BITMAP = 0x00000008
      PFD_SUPPORT_GDI = 0x00000010
      PFD_SUPPORT_OPENGL = 0x00000020
      PFDtyp_RGBA = 0'i8
      PFD_MAIN_PLANE = 0'i8
      PFD_OVERLAY_PLANE = 1'i8
      PFD_UNDERLAY_PLANE = int32(- 1)
    var 
      PFDescriptor: TPixelFormatDescriptor
      PixelFormat: int32
      AType: int32
    PFDescriptor.nSize = SizeOf(PFDescriptor).int16
    PFDescriptor.nVersion = 1'i16
    PFDescriptor.dwFlags = PFD_SUPPORT_OPENGL
    AType = GetObjectType(DC)
    if AType == 0: OSError()
    if AType == OBJ_MEMDC or AType == OBJ_METADC or AType == OBJ_ENHMETADC: 
      PFDescriptor.dwFlags = PFDescriptor.dwFlags or PFD_DRAW_TO_BITMAP
    else: 
      PFDescriptor.dwFlags = PFDescriptor.dwFlags or PFD_DRAW_TO_WINDOW
    if opDoubleBuffered in Options: 
      PFDescriptor.dwFlags = PFDescriptor.dwFlags or PFD_DOUBLEBUFFER
    if opGDI in Options: 
      PFDescriptor.dwFlags = PFDescriptor.dwFlags or PFD_SUPPORT_GDI
    if opStereo in Options: 
      PFDescriptor.dwFlags = PFDescriptor.dwFlags or PFD_STEREO
    PFDescriptor.iPixelType = PFDtyp_RGBA
    PFDescriptor.cColorBits = ColorBits.toU8
    PFDescriptor.cDepthBits = zBits.toU8
    PFDescriptor.cStencilBits = StencilBits.toU8
    PFDescriptor.cAccumBits = AccumBits.toU8
    PFDescriptor.cAuxBuffers = AuxBuffers.toU8
    if Layer == 0: PFDescriptor.iLayerType = PFD_MAIN_PLANE
    elif Layer > 0: PFDescriptor.iLayerType = PFD_OVERLAY_PLANE
    else: PFDescriptor.iLayerType = int8(PFD_UNDERLAY_PLANE)
    PixelFormat = ChoosePixelFormat(DC, addr(PFDescriptor))
    if PixelFormat == 0: OSError()
    if GetPixelFormat(DC) != PixelFormat: 
      if SetPixelFormat(DC, PixelFormat, addr(PFDescriptor)) == 0'i32: 
        OSError()
    DescribePixelFormat(DC, PixelFormat.int32, SizeOf(PFDescriptor).int32, 
                        addr(PFDescriptor))
    Result = wglCreateContext(DC)
    if Result == 0: OSError()
    else: LastPixelFormat = 0
  
  proc DestroyRenderingContext(RC: HGLRC) = 
    discard wglDeleteContext(RC)

  proc ActivateRenderingContext(DC: HDC, RC: HGLRC) = 
    discard wglMakeCurrent(DC, RC)

  proc DeactivateRenderingContext() = 
    discard wglMakeCurrent(0, 0)
