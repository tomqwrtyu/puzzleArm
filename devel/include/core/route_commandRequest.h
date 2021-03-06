// Generated by gencpp from file core/route_commandRequest.msg
// DO NOT EDIT!


#ifndef CORE_MESSAGE_ROUTE_COMMANDREQUEST_H
#define CORE_MESSAGE_ROUTE_COMMANDREQUEST_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace core
{
template <class ContainerAllocator>
struct route_commandRequest_
{
  typedef route_commandRequest_<ContainerAllocator> Type;

  route_commandRequest_()
    : route()  {
    }
  route_commandRequest_(const ContainerAllocator& _alloc)
    : route(_alloc)  {
  (void)_alloc;
    }



   typedef std::vector<int32_t, typename ContainerAllocator::template rebind<int32_t>::other >  _route_type;
  _route_type route;





  typedef boost::shared_ptr< ::core::route_commandRequest_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::core::route_commandRequest_<ContainerAllocator> const> ConstPtr;

}; // struct route_commandRequest_

typedef ::core::route_commandRequest_<std::allocator<void> > route_commandRequest;

typedef boost::shared_ptr< ::core::route_commandRequest > route_commandRequestPtr;
typedef boost::shared_ptr< ::core::route_commandRequest const> route_commandRequestConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::core::route_commandRequest_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::core::route_commandRequest_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::core::route_commandRequest_<ContainerAllocator1> & lhs, const ::core::route_commandRequest_<ContainerAllocator2> & rhs)
{
  return lhs.route == rhs.route;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::core::route_commandRequest_<ContainerAllocator1> & lhs, const ::core::route_commandRequest_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace core

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsFixedSize< ::core::route_commandRequest_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::core::route_commandRequest_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct IsMessage< ::core::route_commandRequest_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::core::route_commandRequest_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::core::route_commandRequest_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::core::route_commandRequest_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::core::route_commandRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "ba095d58d975bd3c99ae6d685178a1bb";
  }

  static const char* value(const ::core::route_commandRequest_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0xba095d58d975bd3cULL;
  static const uint64_t static_value2 = 0x99ae6d685178a1bbULL;
};

template<class ContainerAllocator>
struct DataType< ::core::route_commandRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "core/route_commandRequest";
  }

  static const char* value(const ::core::route_commandRequest_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::core::route_commandRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "int32[] route\n"
;
  }

  static const char* value(const ::core::route_commandRequest_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::core::route_commandRequest_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.route);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct route_commandRequest_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::core::route_commandRequest_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::core::route_commandRequest_<ContainerAllocator>& v)
  {
    s << indent << "route[]" << std::endl;
    for (size_t i = 0; i < v.route.size(); ++i)
    {
      s << indent << "  route[" << i << "]: ";
      Printer<int32_t>::stream(s, indent + "  ", v.route[i]);
    }
  }
};

} // namespace message_operations
} // namespace ros

#endif // CORE_MESSAGE_ROUTE_COMMANDREQUEST_H
