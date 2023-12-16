shader_type spatial;

// Uniforms
uniform vec4 albedo : hint_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float metallic : hint_range(0.0, 1.0) = 0.5;
uniform float roughness : hint_range(0.0, 1.0) = 0.5;

// Vertex shader
void vertex() {
    // No changes to the vertex position in this simple shader
}

// Fragment shader
void fragment() {
    vec3 normal = normalize(NORMAL);
    vec3 view_dir = normalize(VERTEX - CAMERA_POSITION);
    vec3 light_dir = normalize(vec3(1.0, 1.0, 1.0)); // Directional light, adjust as needed

    // Lambertian lighting
    float ndotl = max(dot(normal, light_dir), 0.0);
    
    // Specular reflection (Cook-Torrance model)
    vec3 halfway_dir = normalize(light_dir + view_dir);
    float roughness_sq = roughness * roughness;
    float NdotH = max(dot(normal, halfway_dir), 0.0);
    float D = (roughness_sq) / (PI * pow(dot(normal, halfway_dir), 4.0) * pow(roughness_sq + pow(NdotH, 2.0) * (1.0 - roughness_sq), 2.0));
    float G = min(1.0, (2.0 * NdotH * min(dot(normal, view_dir), dot(normal, light_dir))) / (dot(view_dir, halfway_dir) + dot(light_dir, halfway_dir)));

    // Fresnel-Schlick approximation for reflectance
    float F = 0.04 + (1.0 - 0.04) * pow(1.0 - dot(view_dir, halfway_dir), 5.0);

    // Combine diffuse and specular terms
    vec3 specular = F * G * D / (4.0 * max(dot(normal, view_dir), 0.001) * max(dot(normal, light_dir), 0.001));
    vec3 diffuse = (1.0 - F) * albedo.rgb * ndotl;

    // Final color
    COLOR = vec4(diffuse + specular, albedo.a);
}
